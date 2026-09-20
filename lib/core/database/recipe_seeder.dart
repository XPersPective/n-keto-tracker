import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'database.dart';

/// Seed tarif yükleyici (T19, MASTER_PROMPT §10.1). Idempotent;
/// malzemeler foods.json kayıtlarına referanslıdır — FoodSeeder'dan
/// SONRA koşturulmalıdır (FK).
class RecipeSeeder {
  RecipeSeeder(this._db);

  final AppDatabase _db;

  static const String contentId = 'recipes';

  Future<int> seedFromAssets() async {
    final raw = await rootBundle.loadString('assets/seed/recipes.json');
    return seedFromJsonString(raw);
  }

  Future<int> seedFromJsonString(String raw) async {
    final doc = jsonDecode(raw) as Map<String, dynamic>;
    final recipes = (doc['recipes'] as List).cast<Map<String, dynamic>>();
    final version = doc['contentVersion'] as String;

    return _db.transaction(() async {
      var inserted = 0;
      for (final r in recipes) {
        final id = r['id'] as String;
        final exists = await (_db.select(
          _db.recipe,
        )..where((t) => t.id.equals(id))).getSingleOrNull();
        if (exists != null) continue;
        await _db
            .into(_db.recipe)
            .insert(
              RecipeCompanion.insert(
                id: id,
                titleTr: Value(r['titleTr'] as String?),
                titleEn: Value(r['titleEn'] as String?),
                servings: r['servings'] as int,
                prepMinutes: Value(r['prepMinutes'] as int?),
                allergensCsv: Value((r['allergens'] as List?)?.join(',')),
                stepsTr: Value(r['stepsTr'] as String?),
                stepsEn: Value(r['stepsEn'] as String?),
                storageNoteTr: Value(r['storageTr'] as String?),
                storageNoteEn: Value(r['storageEn'] as String?),
                netCarbMethodNote: Value(r['netCarbMethodNote'] as String?),
                createdAtUtc: DateTime.now().toUtc(),
              ),
            );
        for (final i
            in (r['ingredients'] as List).cast<Map<String, dynamic>>()) {
          await _db
              .into(_db.recipeIngredient)
              .insert(
                RecipeIngredientCompanion.insert(
                  recipeId: id,
                  foodId: i['foodId'] as String,
                  grams: (i['grams'] as num).toDouble(),
                ),
              );
        }
        inserted++;
      }
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
