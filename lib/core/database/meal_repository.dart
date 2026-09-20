import 'package:drift/drift.dart';

import 'database.dart';
import '../../core/units/serving.dart';

/// Öğün kayıt ve günlük toplam iş akışı (MASTER_PROMPT §8.2, T16).
class MealRepository {
  MealRepository(this._db);

  final AppDatabase _db;

  static const mealTypes = ['breakfast', 'lunch', 'dinner', 'snack', 'custom'];

  /// Çoklu besinli öğün kaydı: öğün + öğeler tek transaction'da.
  Future<int> createMeal({
    required String mealType,
    required DateTime eatenAtUtc,
    required int localOffsetMinutes,
    required List<MealItemInput> items,
    String? note,
    String? customName,
    bool isFavorite = false,
  }) {
    if (items.isEmpty) {
      throw ArgumentError('öğün en az bir besin içermeli');
    }
    return _db.transaction(() async {
      final mealId = await _db
          .into(_db.meal)
          .insert(
            MealCompanion.insert(
              mealType: mealType,
              eatenAtUtc: eatenAtUtc,
              localOffsetMinutes: localOffsetMinutes,
              note: Value(note),
              customName: Value(customName),
              isFavorite: Value(isFavorite),
            ),
          );
      for (final item in items) {
        await _db
            .into(_db.mealItem)
            .insert(
              MealItemCompanion.insert(
                mealId: mealId,
                foodId: item.foodId,
                grams: item.grams,
                userNetCarbOverrideG: Value(item.userNetCarbOverrideG),
              ),
            );
      }
      return mealId;
    });
  }

  /// Bir tarihin (yerel) günlük besin toplamları (MASTER §8.2):
  /// enerji, toplam karb, lif, net karb, protein, yağ.
  /// Kullanıcı net-karb beyanı varsa onu geçersiz kılar.
  Future<DailyTotals> dailyTotals(DateTime localDay) async {
    final query = _db.select(_db.meal).join([
      innerJoin(_db.mealItem, _db.mealItem.mealId.equalsExp(_db.meal.id)),
      innerJoin(_db.food, _db.food.id.equalsExp(_db.mealItem.foodId)),
    ]);
    // Yerel gün sınırları UTC'ye çevrilerek sorgulanır (offsetsiz basit
    // yaklaşım: cihaz offset'i o gün için sabit kabul edilir).
    final startLocal = DateTime(localDay.year, localDay.month, localDay.day);
    final endLocal = startLocal.add(const Duration(days: 1));
    final tzOffset = localDay.timeZoneOffset;
    final startUtc = startLocal.subtract(tzOffset);
    final endUtc = endLocal.subtract(tzOffset);
    query.where(_db.meal.eatenAtUtc.isBetweenValues(startUtc, endUtc));

    var kcal = 0.0;
    var carb = 0.0;
    var fiber = 0.0;
    var netCarb = 0.0;
    var protein = 0.0;
    var fat = 0.0;

    final rows = await query.get();
    for (final row in rows) {
      final mealItem = row.readTable(_db.mealItem);
      final food = row.readTable(_db.food);
      final n = scaleItem(
        kcalPer100g: food.kcalPer100g,
        proteinGPer100g: food.proteinGPer100g,
        fatGPer100g: food.fatGPer100g,
        carbohydrateTotalGPer100g: food.carbohydrateTotalGPer100g,
        fiberGPer100g: food.fiberGPer100g,
        netCarbGPer100g: food.netCarbGPer100g,
        grams: mealItem.grams,
      );
      kcal += n.kcal;
      carb += n.carbohydrateTotalG;
      fiber += n.fiberG;
      protein += n.proteinG;
      fat += n.fatG;
      // Kullanıcı beyanı varsa onu kullan (MASTER §8.1).
      final override = mealItem.userNetCarbOverrideG;
      netCarb += override != null
          ? override.clamp(0, double.infinity)
          : n.netCarbG;
    }
    return DailyTotals(
      kcal: kcal,
      carbohydrateTotalG: carb,
      fiberG: fiber,
      netCarbG: netCarb,
      proteinG: protein,
      fatG: fat,
    );
  }

  /// Hızlı tekrar: son N favori ve son N öğün (ayrı listeler).
  Future<({List<MealRow> favorites, List<MealRow> recent})>
  quickRepeatCandidates({int limit = 5}) async {
    final favorites =
        await (_db.select(_db.meal)
              ..where((m) => m.isFavorite.equals(true))
              ..orderBy([(m) => OrderingTerm.desc(m.eatenAtUtc)])
              ..limit(limit))
            .get();
    final recent =
        await (_db.select(_db.meal)
              ..orderBy([(m) => OrderingTerm.desc(m.eatenAtUtc)])
              ..limit(limit))
            .get();
    return (favorites: favorites, recent: recent);
  }

  /// Tekrar kaydı: bir öğünün öğelerini yeni zamanla kopyalar.
  Future<int> repeatMeal({
    required int sourceMealId,
    required DateTime eatenAtUtc,
    required int localOffsetMinutes,
  }) async {
    final source = await (_db.select(
      _db.meal,
    )..where((m) => m.id.equals(sourceMealId))).getSingle();
    final items = await (_db.select(
      _db.mealItem,
    )..where((i) => i.mealId.equals(sourceMealId))).get();
    return createMeal(
      mealType: source.mealType,
      eatenAtUtc: eatenAtUtc,
      localOffsetMinutes: localOffsetMinutes,
      note: source.note,
      customName: source.customName,
      isFavorite: source.isFavorite,
      items: items
          .map(
            (i) => MealItemInput(
              foodId: i.foodId,
              grams: i.grams,
              userNetCarbOverrideG: i.userNetCarbOverrideG,
            ),
          )
          .toList(),
    );
  }

  /// Besin arama (yerel, TR/EN; MASTER §8.2).
  Future<List<FoodRow>> searchFoods(String query, {int limit = 20}) async {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return [];
    final pattern = '%$q%';
    return (_db.select(_db.food)
          ..where(
            (t) =>
                t.canonicalName.lower().like(pattern) |
                t.nameTr.lower().like(pattern) |
                t.nameEn.lower().like(pattern),
          )
          ..limit(limit))
        .get();
  }
}

/// Formdan gelen öğe girdisi.
class MealItemInput {
  const MealItemInput({
    required this.foodId,
    required this.grams,
    this.userNetCarbOverrideG,
  });

  final String foodId;
  final double grams;
  final double? userNetCarbOverrideG;
}

/// Günlük toplamlar (MASTER §8.2).
class DailyTotals {
  const DailyTotals({
    required this.kcal,
    required this.carbohydrateTotalG,
    required this.fiberG,
    required this.netCarbG,
    required this.proteinG,
    required this.fatG,
  });

  final double kcal;
  final double carbohydrateTotalG;
  final double fiberG;
  final double netCarbG;
  final double proteinG;
  final double fatG;
}
