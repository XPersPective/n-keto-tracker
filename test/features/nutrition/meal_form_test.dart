import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/l10n/generated/app_localizations.dart';
import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/providers.dart';
import 'package:n_keto_tracker/features/nutrition/meal_form.dart';

/// T16 form widget testi (MASTER_PROMPT §16.3): arama → ekle → kaydet
/// akışı; kayıt DB'ye gerçekten yazılır.
void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async => db.close());

  Future<void> seedFood() async {
    await db
        .into(db.food)
        .insert(
          FoodCompanion.insert(
            id: 'seed-egg-test',
            canonicalName: 'Egg',
            nameTr: const Value('Yumurta'),
            category: 'test',
            kcalPer100g: 143,
            proteinGPer100g: 12.6,
            fatGPer100g: 9.5,
            carbohydrateTotalGPer100g: 0.7,
            netCarbGPer100g: 0.7,
            dataSource: 'test',
          ),
        );
  }

  Widget scope() {
    return ProviderScope(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MealForm(),
      ),
    );
  }

  testWidgets('arama → ekle → kaydet: DB\'de öğün + öğe oluşur', (
    tester,
  ) async {
    await seedFood();
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    // 1) Ara (TR isim).
    await tester.enterText(
      find.widgetWithText(TextField, 'Search food').first,
      'yumur',
    );
    await tester.pumpAndSettle();
    expect(find.text('Yumurta'), findsOneWidget);

    // 2) Ekle.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // 3) Kaydet.
    await tester.tap(find.text('Save meal'));
    await tester.pumpAndSettle();

    // Kayıt gerçek: 1 öğün + 1 öğe (100 g varsayılan). Bildirim pop
    // sonrası test ağacında yaşamaz; DB durumu asıl kanıttır.
    expect((await db.select(db.meal).get()), hasLength(1));
    final items = await db.select(db.mealItem).get();
    expect(items, hasLength(1));
    expect(items.single.grams, 100);
  });

  testWidgets('öğesiz kayıt engellenir ve mesaj gösterilir', (tester) async {
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Save meal'));
    await tester.pumpAndSettle();

    expect(find.text('Add at least one food first.'), findsOneWidget);
    expect((await db.select(db.meal).get()), isEmpty);
  });
}
