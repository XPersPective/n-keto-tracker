import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'database.dart';

/// Seed besin verisi yükleyici (T15, MASTER_PROMPT §8.1, §13).
///
/// Idempotent: aynı id'li kayıt zaten varsa atlanır; kullanıcı besinleri
/// (`user:` önekli) hiçbir koşulda dokunulmaz. İçerik sürümü
/// ContentVersion tablosuna yazılır.
class FoodSeeder {
  FoodSeeder(this._db);

  final AppDatabase _db;

  static const String contentId = 'foods';

  /// assets/seed/foods.json'ı okuyup eksik kayıtları ekler.
  /// Dönen değer: eklenen kayıt sayısı (idempotentte 0).
  Future<int> seedFromAssets() async {
    final raw = await rootBundle.loadString('assets/seed/foods.json');
    return seedFromJsonString(raw);
  }

  /// Testlerde doğrudan JSON metniyle koşturulabilir.
  Future<int> seedFromJsonString(String raw) async {
    final doc = jsonDecode(raw) as Map<String, dynamic>;
    final foods = (doc['foods'] as List).cast<Map<String, dynamic>>();
    final version = doc['contentVersion'] as String;

    return _db.transaction(() async {
      var inserted = 0;
      for (final f in foods) {
        final id = f['id'] as String;
        if (id.startsWith('user:')) {
          // Kullanıcı id alanı seed'de yasak (MASTER §13 çakışma kuralı).
          throw StateError('seed id user-namespace kullanamaz: $id');
        }
        final exists = await (_db.select(
          _db.food,
        )..where((t) => t.id.equals(id))).getSingleOrNull();
        if (exists != null) continue;
        final servings = (f['servingOptions'] as List)
            .cast<Map<String, dynamic>>();
        await _db
            .into(_db.food)
            .insert(
              FoodCompanion.insert(
                id: id,
                canonicalName: f['canonicalName'] as String,
                nameTr: Value(f['nameTr'] as String?),
                nameEn: Value(f['nameEn'] as String?),
                category: f['category'] as String,
                kcalPer100g: (f['kcalPer100g'] as num).toDouble(),
                proteinGPer100g: (f['proteinGPer100g'] as num).toDouble(),
                fatGPer100g: (f['fatGPer100g'] as num).toDouble(),
                carbohydrateTotalGPer100g:
                    (f['carbohydrateTotalGPer100g'] as num).toDouble(),
                fiberGPer100g: Value(
                  (f['fiberGPer100g'] as num?)?.toDouble() ?? 0,
                ),
                netCarbGPer100g: (f['netCarbGPer100g'] as num).toDouble(),
                dataSource: f['dataSource'] as String,
                sourceVersion: Value(f['sourceVersion'] as String?),
                sourceRecordId: Value(f['sourceRecordId'] as String?),
                license: Value(f['license'] as String?),
                lastReviewedAtIso: Value(f['lastReviewedAt'] as String?),
                isUserCreated: const Value(false),
              ),
            );
        for (final s in servings) {
          await _db
              .into(_db.servingOption)
              .insert(
                ServingOptionCompanion.insert(
                  foodId: id,
                  labelTr: Value(s['labelTr'] as String?),
                  labelEn: Value(s['labelEn'] as String?),
                  gramsPerServing: (s['grams'] as num).toDouble(),
                  isDefault: Value(s['default'] as bool? ?? false),
                ),
              );
        }
        inserted++;
      }

      // İçerik sürümü kaydı (idempotent: aynı sürüm tekrar yazılmaz).
      final versionExists =
          await (_db.select(_db.contentVersion)..where(
                (c) => c.id.equals(contentId) & c.version.equals(version),
              ))
              .getSingleOrNull();
      if (versionExists == null) {
        await _db
            .into(_db.contentVersion)
            .insert(
              ContentVersionCompanion.insert(
                id: contentId,
                version: version,
                releasedAtIso: doc['releasedAt'] as String? ?? '',
              ),
            );
      }
      return inserted;
    });
  }
}
