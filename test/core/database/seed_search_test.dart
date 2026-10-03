import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/food_seeder.dart';
import 'package:n_keto_tracker/core/database/meal_repository.dart';

/// PB-010: üretim açılış zinciri — tohum sonrası besin araması kayıt
/// döner (main.dart'taki _seedContent akışının depo düzeyi karşılığı).
void main() {
  late AppDatabase db;
  final seedJson = File('assets/seed/foods.json').readAsStringSync();

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async => db.close());

  test('tohum öncesi arama boş; tohum sonrası "yumurta" sonuç döner', () async {
    final repo = MealRepository(db);

    expect(await repo.searchFoods('yumurta'), isEmpty);

    await FoodSeeder(db).seedFromJsonString(seedJson);

    final results = await repo.searchFoods('yumurta');
    expect(results, isNotEmpty);
    expect(results.first.nameTr, contains('Yumurta'));
  });
}
