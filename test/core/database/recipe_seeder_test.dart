import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/food_seeder.dart';
import 'package:n_keto_tracker/core/database/recipe_seeder.dart';

/// T19 tarif seed testleri (MASTER_PROMPT §10.1, §16.5):
/// - her malzemenin foodId'si foods.json'da VAR (kontrol scripti);
/// - seeder idempotent; FK gereği besinlerden sonra koşar;
/// - porsiyon başı değerler = toplam/servings.
void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async => db.close());

  final foodsJson = File('assets/seed/foods.json').readAsStringSync();
  final recipesJson = File('assets/seed/recipes.json').readAsStringSync();

  Future<void> seedBoth() async {
    await FoodSeeder(db).seedFromJsonString(foodsJson);
    await RecipeSeeder(db).seedFromJsonString(recipesJson);
  }

  test('tarif dosyası: ≥20 tarif; her malzeme foods.json\'da var', () {
    final foods = (jsonDecode(foodsJson)['foods'] as List)
        .cast<Map<String, dynamic>>();
    final foodIds = foods.map((f) => f['id'] as String).toSet();
    final recipes = (jsonDecode(recipesJson)['recipes'] as List)
        .cast<Map<String, dynamic>>();
    expect(recipes.length, greaterThanOrEqualTo(20));
    for (final r in recipes) {
      for (final i in (r['ingredients'] as List).cast<Map<String, dynamic>>()) {
        expect(
          foodIds,
          contains(i['foodId']),
          reason: '${r['id']}: malzeme foods.json dışı',
        );
      }
      expect((r['stepsTr'] as String).trim(), isNotEmpty);
      expect((r['stepsEn'] as String).trim(), isNotEmpty);
      expect((r['servings'] as num), greaterThanOrEqualTo(1));
    }
  });

  test('seeder: besinlerden sonra koşar, tüm tarifleri ekler', () async {
    await seedBoth();
    expect((await db.select(db.recipe).get()).length, greaterThanOrEqualTo(20));
    expect(
      (await db.select(db.recipeIngredient).get()).length,
      greaterThanOrEqualTo(20 * 2),
    );
  });

  test('seeder idempotent: ikinci koşum 0 ekler', () async {
    await seedBoth();
    final second = await RecipeSeeder(db).seedFromJsonString(recipesJson);
    expect(second, 0);
  });

  test('porsiyon başı değerler malzeme toplamının servings bölümü', () async {
    await seedBoth();
    final r = await (db.select(
      db.recipe,
    )..where((t) => t.id.equals('seed-recipe-cheese-omelette'))).getSingle();
    final ingredients = await (db.select(
      db.recipeIngredient,
    )..where((i) => i.recipeId.equals(r.id))).get();
    var kcal = 0.0;
    for (final i in ingredients) {
      final f = await (db.select(
        db.food,
      )..where((t) => t.id.equals(i.foodId))).getSingle();
      kcal += f.kcalPer100g * i.grams / 100;
    }
    final perServing = jsonDecode(recipesJson)['recipes'] as List;
    final expected =
        (perServing.cast<Map<String, dynamic>>().firstWhere(
                  (x) => x['id'] == 'seed-recipe-cheese-omelette',
                )['perServing']
                as Map)['kcal']
            as num;
    expect(r.servings, 1);
    expect(kcal, closeTo(expected.toDouble(), 0.1));
  });

  test('FK: tarif malzemesi olmayan besine eklenemez', () async {
    await seedBoth();
    expect(
      () => db
          .into(db.recipeIngredient)
          .insert(
            RecipeIngredientCompanion.insert(
              recipeId: 'seed-recipe-menemen',
              foodId: 'seed-nonexistent',
              grams: 100,
            ),
          ),
      throwsA(isA<Exception>()),
    );
  });
}
