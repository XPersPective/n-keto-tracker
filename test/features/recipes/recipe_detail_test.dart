import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/l10n/generated/app_localizations.dart';
import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/food_seeder.dart';
import 'package:n_keto_tracker/core/database/providers.dart';
import 'package:n_keto_tracker/core/database/recipe_seeder.dart';

import 'dart:io';

import 'package:n_keto_tracker/features/recipes/recipe_detail_page.dart';

/// T19 tarif detay widget testi (MASTER_PROMPT §10.1): başlık, adım,
/// malzemeler (besin adlarıyla + gram), porsiyon, alerjen, saklama.
void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async => db.close());

  Widget scope() {
    return ProviderScope(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: RecipeDetailPage(recipeId: 'seed-recipe-cheese-omelette'),
      ),
    );
  }

  testWidgets('tarif detayı: başlık, adım, malzeme adı+gram, porsiyon', (
    tester,
  ) async {
    await FoodSeeder(db)
        .seedFromJsonString(File('assets/seed/foods.json').readAsStringSync());
    await RecipeSeeder(
      db,
    ).seedFromJsonString(File('assets/seed/recipes.json').readAsStringSync());
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    // Başlık (EN ortam).
    expect(find.text('Cheese omelette'), findsOneWidget);
    // Adım metni.
    expect(find.textContaining('Whisk eggs'), findsOneWidget);
    // Malzeme adı ve gram.
    expect(find.text('Egg, whole'), findsOneWidget); // EN: nameEn
    expect(find.text('100 g'), findsOneWidget);
    // Porsiyon + alerjen.
    expect(find.textContaining('1 serving'), findsOneWidget);
    expect(find.textContaining('Allergens:'), findsOneWidget);
    // Saklama.
    expect(find.textContaining('Storage:'), findsOneWidget);
  });
}
