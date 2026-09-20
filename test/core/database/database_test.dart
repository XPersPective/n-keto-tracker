import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/core/database/database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  /// MASTER_PROMPT §13: 27 tablo; drift şeması bunları sınıf adıyla açar.
  const expectedTables = {
    'app_settings',
    'consent_records',
    'user_profile',
    'risk_screening',
    'energy_estimate',
    'goal',
    'food',
    'serving_option',
    'recipe',
    'recipe_ingredient',
    'meal',
    'meal_item',
    'glucose_measurement',
    'ketone_measurement',
    'measurement_session',
    'weight_entry',
    'symptom_definition',
    'symptom_entry',
    'context_tag',
    'meal_plan',
    'meal_plan_entry',
    'shopping_list',
    'shopping_list_item',
    'evidence_source',
    'evidence_claim',
    'content_version',
    'export_history',
  };

  Future<Set<String>> tableNames() async {
    final rows = await db
        .customSelect(
          "SELECT name FROM sqlite_master WHERE type='table' "
          "AND name NOT LIKE 'sqlite_%'",
        )
        .get();
    return rows.map((r) => r.read<String>('name')).toSet();
  }

  test('27 tablo oluşturuluyor', () async {
    final names = await tableNames();
    for (final t in expectedTables) {
      expect(names, contains(t), reason: '$t tablosu yok');
    }
    expect(
      names.where(expectedTables.contains).length,
      27,
      reason: 'Beklenen tablo sayısı 27 olmalı',
    );
  });

  test('foreign_keys pragma açılışta etkin', () async {
    final rows = await db.customSelect('PRAGMA foreign_keys').get();
    expect(rows.first.read<int>('foreign_keys'), 1);
  });

  test(
    'CRUD: besin ekle/oku/güncelle/sil (seed ve user kimlik ayrımıyla)',
    () async {
      final seedId = 'usda-173944';
      final userId = 'user:00000000-0000-4000-8000-000000000001';
      final base = FoodCompanion(
        canonicalName: const Value('Test food'),
        category: const Value('test'),
        kcalPer100g: const Value(100),
        proteinGPer100g: const Value(5),
        fatGPer100g: const Value(8),
        carbohydrateTotalGPer100g: const Value(3),
        netCarbGPer100g: const Value(2),
        dataSource: const Value('test-source'),
      );
      await db
          .into(db.food)
          .insert(
            base.copyWith(id: Value(seedId), isUserCreated: const Value(false)),
          );
      await db
          .into(db.food)
          .insert(
            base.copyWith(id: Value(userId), isUserCreated: const Value(true)),
          );

      final rows = await db.select(db.food).get();
      expect(rows.length, 2);
      expect(rows.map((f) => f.id).toSet(), {seedId, userId});

      final read = await (db.select(
        db.food,
      )..where((f) => f.id.equals(seedId))).getSingle();
      expect(read.netCarbGPer100g, 2);

      await (db.update(db.food)..where((f) => f.id.equals(seedId))).write(
        const FoodCompanion(netCarbGPer100g: Value(1.5)),
      );
      final updated = await (db.select(
        db.food,
      )..where((f) => f.id.equals(seedId))).getSingle();
      expect(updated.netCarbGPer100g, 1.5);

      await (db.delete(db.food)..where((f) => f.id.equals(userId))).go();
      expect((await db.select(db.food).get()).length, 1);
    },
  );

  test('FK ihlali: var olmayan öğüne öğe eklenemez', () async {
    expect(
      () => db
          .into(db.mealItem)
          .insert(
            MealItemCompanion(
              mealId: const Value(999),
              foodId: const Value('usda-x'),
              grams: const Value(100),
            ),
          ),
      throwsA(isA<Exception>()),
    );
  });

  test('CASCADE: öğün silinince öğeleri de silinir', () async {
    final foodId = 'usda-1';
    await db.into(db.food).insert(_food(foodId));
    final mealId = await db
        .into(db.meal)
        .insert(
          MealCompanion(
            mealType: const Value('breakfast'),
            eatenAtUtc: Value(DateTime.utc(2026, 9, 20, 7)),
            localOffsetMinutes: const Value(180),
          ),
        );
    for (final g in [50.0, 120.0]) {
      await db
          .into(db.mealItem)
          .insert(
            MealItemCompanion(
              mealId: Value(mealId),
              foodId: Value(foodId),
              grams: Value(g),
            ),
          );
    }
    expect((await db.select(db.mealItem).get()).length, 2);

    await (db.delete(db.meal)..where((m) => m.id.equals(mealId))).go();
    expect((await db.select(db.mealItem).get()), isEmpty);
  });

  test('RESTRICT: öğün kaydında kullanılan besin silinemez', () async {
    final foodId = 'usda-2';
    await db.into(db.food).insert(_food(foodId));
    final mealId = await db
        .into(db.meal)
        .insert(
          MealCompanion(
            mealType: const Value('lunch'),
            eatenAtUtc: Value(DateTime.utc(2026, 9, 20, 12)),
            localOffsetMinutes: const Value(180),
          ),
        );
    await db
        .into(db.mealItem)
        .insert(
          MealItemCompanion(
            mealId: Value(mealId),
            foodId: Value(foodId),
            grams: const Value(100),
          ),
        );

    expect(
      () => (db.delete(db.food)..where((f) => f.id.equals(foodId))).go(),
      throwsA(isA<Exception>()),
    );
  });

  test(
    'Transaction rollback: hatalı işlem hiçbir kısmi yazı bırakmaz',
    () async {
      await db
          .transaction(() async {
            await db
                .into(db.contextTag)
                .insert(
                  const ContextTagCompanion(
                    id: Value('fasting'),
                    labelTr: Value('Açlık'),
                    labelEn: Value('Fasting'),
                  ),
                );
            // Aynı PK'yi ikinci kez eklemek kısıt ihlali => transaction başarısız.
            await db
                .into(db.contextTag)
                .insert(
                  const ContextTagCompanion(
                    id: Value('fasting'),
                    labelTr: Value('Açlık'),
                    labelEn: Value('Fasting'),
                  ),
                );
          })
          .catchError((_) {});
      expect((await db.select(db.contextTag).get()), isEmpty);
    },
  );

  test('Ölçüm oturumu: glukoz+BHB referansı + GKI + formül sürümü', () async {
    final glucoseId = await db
        .into(db.glucoseMeasurement)
        .insert(
          GlucoseMeasurementCompanion(
            rawValue: const Value(90),
            rawUnit: const Value('mg_dL'),
            mmolL: const Value(5.0),
            measuredAtUtc: Value(DateTime.utc(2026, 9, 20, 8)),
            localOffsetMinutes: const Value(180),
            sourceType: const Value('fingerstick'),
          ),
        );
    final ketoneId = await db
        .into(db.ketoneMeasurement)
        .insert(
          KetoneMeasurementCompanion(
            rawValue: const Value(2.5),
            mmolL: const Value(2.5),
            measuredAtUtc: Value(DateTime.utc(2026, 9, 20, 8)),
            localOffsetMinutes: const Value(180),
          ),
        );
    await db
        .into(db.measurementSession)
        .insert(
          MeasurementSessionCompanion(
            glucoseId: Value(glucoseId),
            ketoneId: Value(ketoneId),
            gkiValue: const Value(2.0),
            formulaVersion: const Value('gki-v1'),
            matchKind: const Value('simultaneous'),
            confirmedByUser: const Value(true),
            computedAtUtc: Value(DateTime.utc(2026, 9, 20, 8)),
          ),
        );

    final session = await db.select(db.measurementSession).getSingle();
    expect(session.gkiValue, 2.0);
    expect(session.formulaVersion, 'gki-v1');
    expect(session.isValid, isTrue);

    // Ölçüm silinince FK SET NULL referansı temizler; isValid=false
    // bayrağını MeasurementsRepository.updateGlucose/deleteGlucose uygular
    // (bkz. measurements_repository_test).
    await (db.delete(
      db.glucoseMeasurement,
    )..where((g) => g.id.equals(glucoseId))).go();
    final afterDelete = await db.select(db.measurementSession).getSingle();
    expect(afterDelete.glucoseId, isNull);
    expect(afterDelete.ketoneId, ketoneId);
  });

  test('Üç hedef türü aynı tabloda ayrık tür alanıyla saklanır', () async {
    final now = DateTime.utc(2026, 9, 20);
    for (final type in [
      'researchReference',
      'clinicianTarget',
      'personalTrackingGoal',
    ]) {
      await db
          .into(db.goal)
          .insert(
            GoalCompanion(
              goalType: Value(type),
              metric: const Value('gki'),
              targetValue: const Value(2.0),
              createdAtUtc: Value(now),
            ),
          );
    }
    final types = (await db.select(db.goal).get())
        .map((g) => g.goalType)
        .toSet();
    expect(types, {
      'researchReference',
      'clinicianTarget',
      'personalTrackingGoal',
    });
  });
}

FoodCompanion _food(String id) => FoodCompanion(
  id: Value(id),
  canonicalName: Value('Test food $id'),
  category: const Value('test'),
  kcalPer100g: const Value(100),
  proteinGPer100g: const Value(1),
  fatGPer100g: const Value(1),
  carbohydrateTotalGPer100g: const Value(1),
  netCarbGPer100g: const Value(1),
  dataSource: const Value('test-source'),
);
