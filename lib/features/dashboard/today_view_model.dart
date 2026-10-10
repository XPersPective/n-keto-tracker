import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/database.dart';
import '../../core/database/providers.dart';

/// Bugün ekranı veri modeli (PB-021). Besin/ağırlık/semptom/plan
/// kartları için yerel gün başına sorgular; tüm sorgular `changeOverWindow`
/// ve `dailyTotals`'ın kullandığı yerel gün kuralıyla (gece yarısı
/// başlangıç, timezone offset'iyle UTC'ye dönüş) uyumludur.

/// Öğün tipinin yerelleştirilmiş etiketi için sözleşme.
String mealTypeLabelTr(String type) {
  switch (type) {
    case 'breakfast':
      return 'Kahvaltı';
    case 'lunch':
      return 'Öğle';
    case 'dinner':
      return 'Akşam';
    case 'snack':
      return 'Ara öğün';
    case 'custom':
      return 'Özel';
  }
  return type;
}

String mealTypeLabelEn(String type) {
  switch (type) {
    case 'breakfast':
      return 'Breakfast';
    case 'lunch':
      return 'Lunch';
    case 'dinner':
      return 'Dinner';
    case 'snack':
      return 'Snack';
    case 'custom':
      return 'Custom';
  }
  return type;
}

/// Bugünün öğün kayıtları (en yenisi önce).
final todayMealsProvider = FutureProvider.autoDispose<List<MealRow>>((
  ref,
) async {
  final db = ref.watch(appDatabaseProvider);
  final now = DateTime.now();
  final startLocal = DateTime(now.year, now.month, now.day);
  final endLocal = startLocal.add(const Duration(days: 1));
  final tzOffset = now.timeZoneOffset;
  final startUtc = startLocal.subtract(tzOffset);
  final endUtc = endLocal.subtract(tzOffset);
  return (db.select(db.meal)
        ..where((m) => m.eatenAtUtc.isBetweenValues(startUtc, endUtc))
        ..orderBy([(m) => OrderingTerm.desc(m.eatenAtUtc)]))
      .get();
}, dependencies: [appDatabaseProvider]);

/// Bugünün ağırlık kaydı (en yenisi); null ise kayıt yok.
final todayWeightProvider = FutureProvider.autoDispose<WeightEntryRow?>((
  ref,
) async {
  final db = ref.watch(appDatabaseProvider);
  final now = DateTime.now();
  final startLocal = DateTime(now.year, now.month, now.day);
  final endLocal = startLocal.add(const Duration(days: 1));
  final tzOffset = now.timeZoneOffset;
  final startUtc = startLocal.subtract(tzOffset);
  final endUtc = endLocal.subtract(tzOffset);
  return (db.select(db.weightEntry)
        ..where((w) => w.measuredAtUtc.isBetweenValues(startUtc, endUtc))
        ..orderBy([(w) => OrderingTerm.desc(w.measuredAtUtc)])
        ..limit(1))
      .getSingleOrNull();
}, dependencies: [appDatabaseProvider]);

/// Bugünün semptom kayıtları (en yenisi önce).
final todaySymptomsProvider =
    FutureProvider.autoDispose<
      List<({SymptomDefinitionRow def, SymptomEntryRow entry})>
    >((ref) async {
      final db = ref.watch(appDatabaseProvider);
      final now = DateTime.now();
      final startLocal = DateTime(now.year, now.month, now.day);
      final endLocal = startLocal.add(const Duration(days: 1));
      final tzOffset = now.timeZoneOffset;
      final startUtc = startLocal.subtract(tzOffset);
      final endUtc = endLocal.subtract(tzOffset);
      final q = db.select(db.symptomEntry).join([
        innerJoin(
          db.symptomDefinition,
          db.symptomDefinition.id.equalsExp(
            db.symptomEntry.symptomDefinitionId,
          ),
        ),
      ]);
      q.where(db.symptomEntry.createdAtUtc.isBetweenValues(startUtc, endUtc));
      q.orderBy([OrderingTerm.desc(db.symptomEntry.createdAtUtc)]);
      final rows = await q.get();
      return rows
          .map(
            (r) => (
              def: r.readTable(db.symptomDefinition),
              entry: r.readTable(db.symptomEntry),
            ),
          )
          .toList();
    }, dependencies: [appDatabaseProvider]);

/// Bugünün planlı öğün girdileri. DayOffset 0 = bugün.
final todayPlanEntriesProvider =
    FutureProvider.autoDispose<
      List<({MealPlanRow plan, MealPlanEntryRow entry, RecipeRow? recipe})>
    >((ref) async {
      final db = ref.watch(appDatabaseProvider);
      // DayOffset alanı mutlak 0–6; bugün için bugünün plan başlangıç gününü
      // hesaplamak yerine MealPlanEntry satırları içinden en yeni createdAtUtc
      // olan planın 0. gününü alıyoruz. Birden çok plan varsa en yeni kazanır.
      final latestPlan =
          await (db.select(db.mealPlan)
                ..orderBy([(p) => OrderingTerm.desc(p.createdAtUtc)])
                ..limit(1))
              .getSingleOrNull();
      if (latestPlan == null) return const [];
      final q = db.select(db.mealPlanEntry).join([
        innerJoin(
          db.mealPlan,
          db.mealPlan.id.equalsExp(db.mealPlanEntry.mealPlanId),
        ),
      ]);
      q.where(
        db.mealPlanEntry.mealPlanId.equals(latestPlan.id) &
            db.mealPlanEntry.dayOffset.equals(0),
      );
      q.orderBy([OrderingTerm.asc(db.mealPlanEntry.mealType)]);
      final rows = await q.get();
      final out =
          <({MealPlanRow plan, MealPlanEntryRow entry, RecipeRow? recipe})>[];
      for (final r in rows) {
        final entry = r.readTable(db.mealPlanEntry);
        final plan = r.readTable(db.mealPlan);
        final RecipeRow? recipe;
        if (entry.recipeId == null) {
          recipe = null;
        } else {
          recipe = await (db.select(
            db.recipe,
          )..where((t) => t.id.equals(entry.recipeId!))).getSingleOrNull();
        }
        out.add((plan: plan, entry: entry, recipe: recipe));
      }
      return out;
    }, dependencies: [appDatabaseProvider]);
