import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/l10n/generated/app_localizations.dart';
import 'package:n_keto_tracker/app/router.dart';
import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/providers.dart';

/// T14 Bugün ekranı testleri (MASTER_PROMPT §5.1, §22.6): her hızlı eylem
/// ana ekrandan ≤3 dokunuşta ilgili formu açar; tüm boş durumlar render
/// edilir; tıbbi-olmayan alt bilgisi görünür.
void main() {
  late AppDatabase db;

  Widget scope() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    // Gerçek router: hızlı eylemler context.push ile yol açar.
    appRouter.go('/today');
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
    await tester.pumpAndSettle();

    expect(
      find.text(
        'No measurements yet. Use \'Add measurement\' to record glucose and ketone BHB together.',
      ),
      findsOneWidget,
    );
    expect(
      find.text('No meals recorded today. Meals are logged from the Plan tab.'),
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
}
