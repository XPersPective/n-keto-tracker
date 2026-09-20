import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/meal_repository.dart';

/// T16 öğün iş akışı testleri (MASTER_PROMPT §8.2, §16.1): günlük
/// toplamlar, kullanıcı net-karb beyanı geçersiz kılması, hızlı tekrar,
/// TR/EN arama.
void main() {
  late AppDatabase db;
  late MealRepository repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = MealRepository(db);
  });

  tearDown(() async => db.close());

  Future<String> addFood({
    required String slug,
    required double kcal,
    required double protein,
    required double fat,
    required double carb,
    required double fiber,
    String? nameTr,
  }) async {
    final id = 'seed-$slug';
    await db
        .into(db.food)
        .insert(
          FoodCompanion.insert(
            id: id,
            canonicalName: slug,
            nameTr: Value(nameTr),
            category: 'test',
            kcalPer100g: kcal,
            proteinGPer100g: protein,
            fatGPer100g: fat,
            carbohydrateTotalGPer100g: carb,
            fiberGPer100g: Value(fiber),
            netCarbGPer100g: (carb - fiber).clamp(0, double.infinity),
            dataSource: 'test',
          ),
        );
    return id;
  }

  test('günlük toplamlar: iki besinli öğün doğru toplanır', () async {
    final egg = await addFood(
      slug: 'egg',
      kcal: 143,
      protein: 12.6,
      fat: 9.5,
      carb: 0.7,
      fiber: 0,
      nameTr: 'Yumurta',
    );
    final avocado = await addFood(
      slug: 'avocado',
      kcal: 160,
      protein: 2.0,
      fat: 14.7,
      carb: 8.5,
      fiber: 6.7,
      nameTr: 'Avokado',
    );
    final day = DateTime(2026, 9, 20, 8);
    await repo.createMeal(
      mealType: 'breakfast',
      eatenAtUtc: day.toUtc(),
      localOffsetMinutes: 180,
      items: [
        MealItemInput(foodId: egg, grams: 100),
        MealItemInput(foodId: avocado, grams: 50),
      ],
    );
    final totals = await repo.dailyTotals(day);
    // yumurta: 143 kcal, 0.7 net; avokado yarım: 80 kcal, (8.5−6.7)/2=0.9 net
    expect(totals.kcal, closeTo(143 + 80, 0.01));
    expect(totals.netCarbG, closeTo(0.7 + 0.9, 0.01));
    expect(totals.fiberG, closeTo(6.7 / 2, 0.01));
    expect(totals.proteinG, closeTo(12.6 + 1.0, 0.01));
    expect(totals.fatG, closeTo(9.5 + 14.7 / 2, 0.01));
  });

  test('kullanıcı net-karb beyanı hesaplanan değeri geçersiz kılar', () async {
    final egg = await addFood(
      slug: 'egg2',
      kcal: 143,
      protein: 12.6,
      fat: 9.5,
      carb: 0.7,
      fiber: 0,
    );
    final day = DateTime(2026, 9, 21, 8);
    await repo.createMeal(
      mealType: 'snack',
      eatenAtUtc: day.toUtc(),
      localOffsetMinutes: 180,
      items: [
        // Etiket beyanı: 2.0 g (kaynak 0.7 der; kullanıcı beyanı kazanır).
        MealItemInput(foodId: egg, grams: 100, userNetCarbOverrideG: 2.0),
      ],
    );
    final totals = await repo.dailyTotals(day);
    expect(totals.netCarbG, closeTo(2.0, 0.001));
  });

  test('boş gün 0 toplam döner; boş öğün reddedilir', () async {
    final totals = await repo.dailyTotals(DateTime(2026, 9, 22));
    expect(totals.kcal, 0);
    expect(
      () => repo.createMeal(
        mealType: 'lunch',
        eatenAtUtc: DateTime.utc(2026, 9, 22, 12),
        localOffsetMinutes: 180,
        items: const [],
      ),
      throwsA(isA<ArgumentError>()),
    );
  });

  test('hızlı tekrar: öğün öğelerini yeni zamanla kopyalar', () async {
    final egg = await addFood(
      slug: 'egg3',
      kcal: 143,
      protein: 12.6,
      fat: 9.5,
      carb: 0.7,
      fiber: 0,
    );
    final sourceId = await repo.createMeal(
      mealType: 'breakfast',
      eatenAtUtc: DateTime.utc(2026, 9, 20, 7),
      localOffsetMinutes: 180,
      isFavorite: true,
      items: [MealItemInput(foodId: egg, grams: 150)],
    );
    final newId = await repo.repeatMeal(
      sourceMealId: sourceId,
      eatenAtUtc: DateTime.utc(2026, 9, 21, 7),
      localOffsetMinutes: 180,
    );
    expect(newId, isNot(sourceId));
    final items = await (db.select(
      db.mealItem,
    )..where((i) => i.mealId.equals(newId))).get();
    expect(items.single.grams, 150);
    final candidates = await repo.quickRepeatCandidates();
    expect(candidates.favorites, hasLength(2));
    expect(candidates.recent, hasLength(2));
  });

  test('arama TR ve EN isimlerle çalışır', () async {
    await addFood(
      slug: 'white-cheese-x',
      kcal: 264,
      protein: 14.2,
      fat: 21.3,
      carb: 4.1,
      fiber: 0,
      nameTr: 'Beyaz peynir',
    );
    await addFood(
      slug: 'salmon-x',
      kcal: 208,
      protein: 20.4,
      fat: 13.4,
      carb: 0,
      fiber: 0,
      nameTr: 'Somon',
    );
    expect((await repo.searchFoods('beyaz')), hasLength(1));
    expect((await repo.searchFoods('peynir')), hasLength(1));
    expect((await repo.searchFoods('SALMON')), hasLength(1));
    expect((await repo.searchFoods('  ')), isEmpty);
  });
}
