import 'package:drift/drift.dart';

import '../../core/units/meal_plan_models.dart';
import 'database.dart';

/// Plan ve alışveriş listesi iş akışı (MASTER_PROMPT §10.2–10.3, T20).
class PlanRepository {
  PlanRepository(this._db);

  final AppDatabase _db;

  /// Üretilen taslağı kaydeder; plan kimliği döner.
  Future<int> savePlan({
    required String startDateIso,
    required GeneratedPlan plan,
    required Map<int, String> slotToRecipeId,
    String? name,
  }) {
    return _db.transaction(() async {
      final planId = await _db
          .into(_db.mealPlan)
          .insert(
            MealPlanCompanion.insert(
              startDateIso: startDateIso,
              name: Value(name),
              createdAtUtc: DateTime.now().toUtc(),
            ),
          );
      for (final e in plan.entries) {
        await _db
            .into(_db.mealPlanEntry)
            .insert(
              MealPlanEntryCompanion.insert(
                mealPlanId: planId,
                dayOffset: e.dayOffset,
                mealType: 'slot-${e.slot}',
                servings: e.servings,
                recipeId: Value(slotToRecipeId[e.slot]),
              ),
            );
      }
      return planId;
    });
  }

  /// Tek tarifli girdi kaydı (kopyala/taşı/değiştir için).
  Future<int> savePlanEntry({
    required int mealPlanId,
    required int dayOffset,
    required String mealType,
    required String recipeId,
    required double servings,
  }) => _db
      .into(_db.mealPlanEntry)
      .insert(
        MealPlanEntryCompanion.insert(
          mealPlanId: mealPlanId,
          dayOffset: dayOffset,
          mealType: mealType,
          recipeId: Value(recipeId),
          servings: servings,
        ),
      );

  /// Tarih aralığındaki planların tarif malzemelerini alışveriş girdisine
  /// çevirir (porsiyonla ölçeklenir).
  Future<List<ShoppingInputItem>> collectIngredients({
    required String dateStartIso,
    required String dateEndIso,
  }) async {
    final query = _db.select(_db.mealPlanEntry).join([
      innerJoin(
        _db.mealPlan,
        _db.mealPlan.id.equalsExp(_db.mealPlanEntry.mealPlanId),
      ),
    ]);
    query.where(
      _db.mealPlan.startDateIso.isBetweenValues(dateStartIso, dateEndIso),
    );
    final rows = await query.get();
    final items = <ShoppingInputItem>[];
    for (final row in rows) {
      final entry = row.readTable(_db.mealPlanEntry);
      final recipeId = entry.recipeId;
      if (recipeId == null) continue;
      final ings = await (_db.select(
        _db.recipeIngredient,
      )..where((t) => t.recipeId.equals(recipeId))).get();
      for (final ing in ings) {
        items.add(
          ShoppingInputItem(
            foodId: ing.foodId,
            grams: ing.grams * entry.servings,
          ),
        );
      }
    }
    return items;
  }

  /// Alışveriş listesi oluşturur: birleştirilmiş satırlar + korunan
  /// manuel maddeler (MASTER §10.3).
  Future<int> createShoppingList({
    required String title,
    required List<MergedShoppingItem> merged,
    required Map<String, String> categoryByFoodId,
    List<({String label, String category})> manualItems = const [],
  }) {
    return _db.transaction(() async {
      final listId = await _db
          .into(_db.shoppingList)
          .insert(
            ShoppingListCompanion.insert(
              title: title,
              createdAtUtc: DateTime.now().toUtc(),
            ),
          );
      for (final m in merged) {
        await _db
            .into(_db.shoppingListItem)
            .insert(
              ShoppingListItemCompanion.insert(
                shoppingListId: listId,
                foodId: Value(m.foodId),
                quantityGrams: Value(m.grams),
                category: Value(categoryByFoodId[m.foodId]),
              ),
            );
      }
      for (final manual in manualItems) {
        await _db
            .into(_db.shoppingListItem)
            .insert(
              ShoppingListItemCompanion.insert(
                shoppingListId: listId,
                label: Value(manual.label),
                category: Value(manual.category),
              ),
            );
      }
      return listId;
    });
  }
}
