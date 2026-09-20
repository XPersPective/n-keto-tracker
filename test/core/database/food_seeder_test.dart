import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/food_seeder.dart';

/// T15 seeder testleri (MASTER_PROMPT §8.1, §13, §16.2): şema doğrulama,
/// idempotency, kullanıcı id çakışma yasağı, netCarb kuralı.
void main() {
  late AppDatabase db;
  late FoodSeeder seeder;

  /// Gerçek seed dosyası (asset bundle testte rootBundle ister; burada
  /// dosyadan okunup metin olarak beslenir).
  final seedJson = File('assets/seed/foods.json').readAsStringSync();

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    seeder = FoodSeeder(db);
  });

  tearDown(() async => db.close());

  test(
    'seed dosyası şemayı geçer: ≥150 besin, zorunlu provenance alanları',
    () {
      final doc = jsonDecode(seedJson) as Map<String, dynamic>;
      final foods = (doc['foods'] as List).cast<Map<String, dynamic>>();
      expect(foods.length, greaterThanOrEqualTo(150));
      for (final f in foods) {
        for (final key in [
          'id',
          'canonicalName',
          'category',
          'dataSource',
          'license',
          'lastReviewedAt',
        ]) {
          expect(
            (f[key] ?? '') as Object,
            isNotEmpty,
            reason: '${f['id']}: $key boş',
          );
        }
        expect(
          f['netCarbGPer100g'],
          isA<num>(),
          reason: '${f['id']}: netCarb sayısal olmalı',
        );
        expect(f['id'], startsWith('seed-'));
        // netCarb = max(0, total − fiber); tolerans 0.01
        final carb = (f['carbohydrateTotalGPer100g'] as num).toDouble();
        final fiber = (f['fiberGPer100g'] as num?)?.toDouble() ?? 0;
        final net = (f['netCarbGPer100g'] as num).toDouble();
        expect(net, closeTo((carb - fiber).clamp(0, double.infinity), 0.01));
      }
    },
  );

  test('seeder tüm kayıtları ekler ve porsiyon seçeneklerini yazar', () async {
    final inserted = await seeder.seedFromJsonString(seedJson);
    expect(inserted, greaterThanOrEqualTo(150));
    expect((await db.select(db.food).get()).length, inserted);
    expect(
      (await db.select(db.servingOption).get()).length,
      greaterThanOrEqualTo(inserted * 2),
    );
  });

  test('seeder idempotent: ikinci koşum 0 ekler, veri tekrarlanmaz', () async {
    await seeder.seedFromJsonString(seedJson);
    final second = await seeder.seedFromJsonString(seedJson);
    expect(second, 0);
    expect((await db.select(db.food).get()).length, greaterThanOrEqualTo(150));
  });

  test('kullanıcı besini seeder tarafından korunur ve ezilmez', () async {
    await db
        .into(db.food)
        .insert(
          FoodCompanion.insert(
            id: 'user:00000000-0000-4000-8000-00000000000a',
            canonicalName: 'Anne köftesi',
            category: 'user',
            kcalPer100g: 250,
            proteinGPer100g: 15,
            fatGPer100g: 18,
            carbohydrateTotalGPer100g: 6,
            netCarbGPer100g: 5,
            dataSource: 'user-typed',
            isUserCreated: const Value(true),
          ),
        );
    await seeder.seedFromJsonString(seedJson);
    final userFood =
        await (db.select(db.food)..where(
              (t) => t.id.equals('user:00000000-0000-4000-8000-00000000000a'),
            ))
            .getSingle();
    expect(userFood.canonicalName, 'Anne köftesi');
  });

  test('seed id user-namespace kullanamaz', () async {
    final doc = jsonDecode(seedJson) as Map<String, dynamic>;
    final foods = (doc['foods'] as List).cast<Map<String, dynamic>>();
    final bad = Map<String, dynamic>.from(foods.first);
    bad['id'] = 'user:evil';
    final tampered = jsonEncode({
      ...doc,
      'foods': [bad],
    });
    expect(
      () => seeder.seedFromJsonString(tampered),
      throwsA(isA<StateError>()),
    );
  });

  test('içerik sürümü ContentVersion tablosuna idempotent yazılır', () async {
    await seeder.seedFromJsonString(seedJson);
    await seeder.seedFromJsonString(seedJson);
    final versions = await db.select(db.contentVersion).get();
    expect(versions.where((v) => v.id == 'foods'), hasLength(1));
  });
}
