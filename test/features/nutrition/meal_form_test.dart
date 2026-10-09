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

  // PB-023: TR yerelinde 5 öğün tipi etiketi kelime ortasından
  // kırılmadan tam görünür. Önceki SegmentedButton yapısı 1080 px
  // ekranda "Ka/hv/altı" üretiyordu.
  testWidgets('PB-023: TR yerelinde 5 öğün tipi tam etiket görünür',
      (tester) async {
    await seedFood();
    // Emülatör genişliği: 1080x2400 mantıksal 360x800.
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: const MaterialApp(
          locale: Locale('tr'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: MealForm(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // 5 tip tam etiket.
    for (final label in ['Kahvaltı', 'Öğle', 'Akşam', 'Ara öğün', 'Özel']) {
      expect(
        find.text(label),
        findsOneWidget,
        reason: 'TR "$label" etiketi bulunamadı',
      );
    }
    // "Ka", "hv", "altı" gibi kırık parçalar olmamalı.
    expect(find.text('Ka'), findsNothing);
    expect(find.text('hv'), findsNothing);
    expect(find.text('altı'), findsNothing);
  });
}
