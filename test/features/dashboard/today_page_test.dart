import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/l10n/generated/app_localizations.dart';
import 'package:n_keto_tracker/app/router.dart';
import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/providers.dart';

/// T14 Bugün ekranı testleri (MASTER_PROMPT §5.1, §22.6) + PB-021:
/// her hızlı eylem ana ekrandan ≤3 dokunuşta ilgili formu açar; tüm
/// boş durumlar render edilir; tıbbi-olmayan alt bilgisi görünür; bugün
/// ekranı DB'deki günün kayıtlarını (PB-021) canlı gösterir.
void main() {
  late AppDatabase db;

  Widget scope({Future<void> Function(AppDatabase db)? seed}) {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    // Gerçek router: hızlı eylemler context.push ile yol açar.
    appRouter.go('/today');
    if (seed != null) {
      // seed çağrısı widget kurulmadan ÖNCE veriyi yazar; provider aynı
      // db örneğini kullandığı için ilk frame'de veri hazırdır.
      // ignore: discarded_futures
      seed(db);
    }
    return ProviderScope(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
      child: MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: appRouter,
      ),
    );
  }

  // Premium hero kartı içeriği aşağı iter; lazy ListView'in tüm bölümleri
  // kurması için yüksek ekran kullanılır.
  void tallScreen(WidgetTester tester) {
    tester.view.physicalSize = const Size(800, 3200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  Future<void> gracefulTeardown(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await db.close();
  }

  testWidgets('boş durumlar + tıbbi-olmayan alt bilgisi render ediliyor', (
    tester,
  ) async {
    tallScreen(tester);
    db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(() => gracefulTeardown(tester));
    await tester.pumpWidget(scope());
    // FutureProvider.autoDispose sonuçlarının mikro görev olarak
    // çözülmesi için ek bir pump.
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pumpAndSettle();

    expect(
      find.text(
        'No measurements yet. Use \'Add measurement\' to record glucose and ketone BHB together.',
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        'No meals recorded today. Use the quick actions above to add one.',
      ),
      findsOneWidget,
    );
    expect(find.text('No weight entries yet.'), findsOneWidget);
    // 4 hızlı eylem ilk ekranda tek bakışta görünür (kaydırma ÖNCE).
    expect(find.text('Add measurement'), findsOneWidget);
    expect(find.text('Add meal'), findsOneWidget);
    expect(find.text('Add weight'), findsOneWidget);
    expect(find.text('Add symptom'), findsOneWidget);
    // Kıvrım altındaki bölümler için kaydır (lazy ListView).
    final symptoms = find.text('No symptoms recorded today.');
    await tester.scrollUntilVisible(
      symptoms,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(symptoms, findsOneWidget);
    final plans = find.text('No meal plan for today.');
    await tester.scrollUntilVisible(
      plans,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(plans, findsOneWidget);
    final disclaimer = find.text(
      'For general information only; not medical advice.',
    );
    await tester.scrollUntilVisible(
      disclaimer,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(disclaimer, findsOneWidget);
  });

  testWidgets('Ölçüm ekle: 2. dokunuşta oturum formu açılır (≤3)', (
    tester,
  ) async {
    tallScreen(tester);
    db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(() => gracefulTeardown(tester));
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Add measurement')); // dokunuş 2 (görme 1)
    await tester.pumpAndSettle();

    expect(find.text('Glucose (mg/dL)'), findsOneWidget);
    expect(find.text('Blood ketone BHB (mmol/L)'), findsOneWidget);
    expect(find.text('Save measurement session'), findsOneWidget);
  });

  testWidgets('Öğün: gerçek form; Ağırlık/Semptom: dürüst coming-soon (≤3)', (
    tester,
  ) async {
    tallScreen(tester);
    db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(() => gracefulTeardown(tester));
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    // Öğün artık gerçek form (T16).
    await tester.tap(find.text('Add meal'));
    await tester.pumpAndSettle();
    expect(find.text('Log a meal'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Ağırlık gerçek form (T22).
    await tester.tap(find.text('Add weight'));
    await tester.pumpAndSettle();
    expect(find.text('Weight (kg)'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Semptom gerçek form (T23).
    await tester.tap(find.text('Add symptom'));
    await tester.pumpAndSettle();
    expect(find.text('Log a symptom'), findsOneWidget);
  });

  // PB-021: Bugün ekranı DB'deki bugünün kayıtlarını canlı gösterir.
  testWidgets(
    'PB-021: bugünün öğün/ağırlık/semptom/plan kayıtları gösterilir',
    (tester) async {
      tallScreen(tester);
      addTearDown(() => gracefulTeardown(tester));

      // Sahte veriyi scope() içindeki db'ye yaz ki provider aynı örneği
      // kullansın. Yerel "bugün" provider içinde hesaplanıyor.
      Future<void> seedToday(AppDatabase db) async {
        final now = DateTime.now();
        final localOffset = now.timeZoneOffset.inMinutes;
        final startOfDayLocal = DateTime(now.year, now.month, now.day);
        final eatenAtUtc = startOfDayLocal
            .add(const Duration(hours: 8))
            .subtract(now.timeZoneOffset);
        final weightAtUtc = startOfDayLocal
            .add(const Duration(hours: 7))
            .subtract(now.timeZoneOffset);
        final symptomAtUtc = startOfDayLocal
            .add(const Duration(hours: 9))
            .subtract(now.timeZoneOffset);

        // 1) Bir öğün: 1 besin (Yumurta) ile "breakfast".
        await db
            .into(db.food)
            .insert(
              FoodCompanion.insert(
                id: 'test-egg',
                canonicalName: 'Egg',
                nameTr: const Value('Yumurta'),
                nameEn: const Value('Egg'),
                category: 'protein',
                kcalPer100g: 155,
                proteinGPer100g: 13,
                fatGPer100g: 11,
                carbohydrateTotalGPer100g: 1.1,
                fiberGPer100g: const Value(0),
                netCarbGPer100g: 1.1,
                dataSource: 'seed',
              ),
            );
        final mealId = await db
            .into(db.meal)
            .insert(
              MealCompanion.insert(
                mealType: 'breakfast',
                eatenAtUtc: eatenAtUtc,
                localOffsetMinutes: localOffset,
              ),
            );
        await db
            .into(db.mealItem)
            .insert(
              MealItemCompanion.insert(
                mealId: mealId,
                foodId: 'test-egg',
                grams: 100,
              ),
            );

        // 2) Bir ağırlık kaydı: 79,5 kg.
        await db
            .into(db.weightEntry)
            .insert(
              WeightEntryCompanion.insert(
                rawValue: 79.5,
                rawUnit: 'kg',
                kg: 79.5,
                measuredAtUtc: weightAtUtc,
                localOffsetMinutes: localOffset,
              ),
            );

        // 3) Bir semptom kaydı: Baş ağrısı 3/10.
        await db
            .into(db.symptomDefinition)
            .insert(
              SymptomDefinitionCompanion.insert(
                id: 'headache',
                nameTr: 'Baş ağrısı',
                nameEn: 'Headache',
              ),
            );
        await db
            .into(db.symptomEntry)
            .insert(
              SymptomEntryCompanion.insert(
                symptomDefinitionId: 'headache',
                severity: 3,
                createdAtUtc: symptomAtUtc,
              ),
            );

        // 4) Bir haftalık plan + 1 girdi (day 0 = bugün).
        const recipeId = 'test-recipe';
        await db
            .into(db.recipe)
            .insert(
              RecipeCompanion.insert(
                id: recipeId,
                titleTr: const Value('Test Kahvaltısı'),
                titleEn: const Value('Test Breakfast'),
                servings: 1,
                createdAtUtc: DateTime.now().toUtc(),
              ),
            );
        final planId = await db
            .into(db.mealPlan)
            .insert(
              MealPlanCompanion.insert(
                startDateIso: '2026-10-09',
                createdAtUtc: DateTime.now().toUtc(),
              ),
            );
        await db
            .into(db.mealPlanEntry)
            .insert(
              MealPlanEntryCompanion.insert(
                mealPlanId: planId,
                dayOffset: 0,
                mealType: 'slot-breakfast',
                servings: 1,
                recipeId: const Value(recipeId),
              ),
            );
      }

      await tester.pumpWidget(scope(seed: seedToday));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 50));
      await tester.pumpAndSettle();

      // Besin kartı: "Breakfast" etiketi görünür (EN locale).
      final breakfast = find.text('Breakfast');
      await tester.scrollUntilVisible(
        breakfast,
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(breakfast, findsOneWidget);

      // Ağırlık kartı: 79,5 kg görünür.
      final weightText = find.text('79.5 kg');
      await tester.scrollUntilVisible(
        weightText,
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(weightText, findsOneWidget);

      // Semptom kartı: "Headache 3/10" görünür.
      final symptomText = find.text('Headache 3/10');
      await tester.scrollUntilVisible(
        symptomText,
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(symptomText, findsOneWidget);

      // Plan kartı: tarif başlığı görünür.
      final planText = find.text('Test Breakfast');
      await tester.scrollUntilVisible(
        planText,
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(planText, findsOneWidget);

      // Boş durum metinleri artık yok.
      expect(
        find.text(
          'No meals recorded today. Use the quick actions above to add one.',
        ),
        findsNothing,
      );
      expect(find.text('No weight entries yet.'), findsNothing);
      expect(find.text('No symptoms recorded today.'), findsNothing);
      expect(find.text('No meal plan for today.'), findsNothing);
    },
  );
}
