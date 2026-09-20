import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/plan_repository.dart';
import 'package:n_keto_tracker/core/privacy/risk_lock.dart';
import 'package:n_keto_tracker/core/units/meal_plan_models.dart';
import 'package:n_keto_tracker/core/units/plan_generator.dart';
import 'package:n_keto_tracker/features/onboarding/onboarding_controller.dart';

RecipeSummary _recipe(String id, String category, Set<String> allergens) =>
    RecipeSummary(
      id: id,
      title: id,
      category: category,
      allergens: allergens,
      netCarbPerServingG: 8,
      kcalPerServing: 400,
    );

/// T20 testleri (MASTER_PROMPT §10.2–10.3): determinizm, filtreler,
/// dürüst başarısızlık, birleştirme, plan→liste, risk kilidi.
void main() {
  final recipes = [
    _recipe('r-a', 'breakfast', {}),
    _recipe('r-b', 'lunch', {}),
    _recipe('r-c', 'dinner', {}),
    _recipe('r-d', 'dinner', {'süt'}),
  ];

  test('üretici deterministiktir: aynı girdi → aynı çıktı', () {
    final a = PlanGenerator.generate(recipes: recipes, days: 3, mealsPerDay: 2);
    final b = PlanGenerator.generate(recipes: recipes, days: 3, mealsPerDay: 2);
    expect(a, isNotNull);
    expect(b, isNotNull);
    expect(a!.entries.length, b!.entries.length);
    for (var i = 0; i < a.entries.length; i++) {
      expect(a.entries[i].recipeId, b.entries[i].recipeId);
      expect(a.entries[i].dayOffset, b.entries[i].dayOffset);
      expect(a.entries[i].slot, b.entries[i].slot);
    }
  });

  test('alerjen filtresi: süt içeren tarif elenir', () {
    final plan = PlanGenerator.generate(
      recipes: recipes,
      days: 1,
      mealsPerDay: 3,
      excludeAllergens: {'süt'},
    );
    expect(plan, isNotNull);
    expect(plan!.entries.every((e) => e.recipeId != 'r-d'), isTrue);
  });

  test('uygun tarif yoksa null döner (kural gevşetilmez)', () {
    final plan = PlanGenerator.generate(
      recipes: recipes.where((r) => r.allergens.contains('süt')).toList(),
      days: 1,
      mealsPerDay: 3,
      excludeAllergens: {'süt'},
    );
    expect(plan, isNull);
  });

  test('alışveriş birleştirme: gram toplanır, adet ayrı satır', () {
    final merged = ShoppingMerger.merge([
      const ShoppingInputItem(foodId: 'seed-egg', grams: 100),
      const ShoppingInputItem(foodId: 'seed-egg', grams: 150),
      const ShoppingInputItem(
        foodId: 'seed-olives-green',
        grams: 0,
        unitLabel: 'adet',
      ),
      const ShoppingInputItem(
        foodId: 'seed-olives-green',
        grams: 0,
        unitLabel: 'adet',
      ),
      const ShoppingInputItem(
        foodId: 'seed-olives-green',
        grams: 0,
        unitLabel: 'adet',
      ),
    ]);
    final egg = merged.singleWhere((m) => m.foodId == 'seed-egg');
    expect(egg.grams, 250);
    expect(egg.unitLabel, isNull);
    final olives = merged.singleWhere((m) => m.foodId == 'seed-olives-green');
    expect(olives.unitLabel, 'adet');
    expect(olives.grams, 3); // 3 satır = 3 adet
  });

  test('risk kilidi: kilitliyken üretim çağrısı reddedilir (T10 entegre)', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container
        .read(onboardingControllerProvider.notifier)
        .updateRisk((r) => r.copyWith(under18: true));
    final lock = container.read(riskLockProvider);
    expect(
      () => guardPlanGeneration(
        lock,
        () => PlanGenerator.generate(recipes: recipes, days: 1, mealsPerDay: 1),
      ),
      throwsA(isA<PlanLockedException>()),
    );
  });

  test('plan → alışveriş listesi entegrasyonu (DB)', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    final repo = PlanRepository(db);

    // Tarifleri elle ekle (recipe_seeder bağımlılığı olmadan).
    await db
        .into(db.recipe)
        .insert(
          RecipeCompanion.insert(
            id: 'r-menemen',
            servings: 2,
            createdAtUtc: DateTime.now().toUtc(),
          ),
        );
    await db
        .into(db.food)
        .insert(
          FoodCompanion.insert(
            id: 'seed-egg',
            canonicalName: 'Egg',
            category: 'test',
            kcalPer100g: 143,
            proteinGPer100g: 12.6,
            fatGPer100g: 9.5,
            carbohydrateTotalGPer100g: 0.7,
            netCarbGPer100g: 0.7,
            dataSource: 'test',
          ),
        );
    await db
        .into(db.recipeIngredient)
        .insert(
          RecipeIngredientCompanion.insert(
            recipeId: 'r-menemen',
            foodId: 'seed-egg',
            grams: 150,
          ),
        );
    await db
        .into(db.recipeIngredient)
        .insert(
          RecipeIngredientCompanion.insert(
            recipeId: 'r-menemen',
            foodId: 'seed-egg',
            grams: 50,
          ),
        );

    final planId = await repo.savePlan(
      startDateIso: '2026-09-21',
      plan: PlanGenerator.generate(recipes: recipes, days: 1, mealsPerDay: 1)!,
      slotToRecipeId: {0: 'r-menemen'},
    );
    expect(planId, greaterThan(0));

    final items = await repo.collectIngredients(
      dateStartIso: '2026-09-21',
      dateEndIso: '2026-09-21',
    );
    expect(items, hasLength(2)); // 150 g + 50 g
    final merged = ShoppingMerger.merge(items);
    expect(merged.single.grams, 200); // birleşti

    final listId = await repo.createShoppingList(
      title: 'Hafta 39',
      merged: merged,
      categoryByFoodId: {'seed-egg': 'test'},
      manualItems: const [(label: 'Kahve çekirdeği', category: 'içecek')],
    );
    final listItems = await (db.select(
      db.shoppingListItem,
    )..where((i) => i.shoppingListId.equals(listId))).get();
    expect(listItems, hasLength(2)); // 1 birleşik + 1 manuel
    final manual = listItems.singleWhere((i) => i.foodId == null);
    expect(manual.label, 'Kahve çekirdeği');
  });
}
