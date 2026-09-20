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

  Future<void> gracefulTeardown(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await db.close();
  }

  testWidgets('boş durumlar + tıbbi-olmayan alt bilgisi render ediliyor', (
    tester,
  ) async {
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

  testWidgets('Öğün/Ağırlık/Semptom ekle: hedef sayfaları açılır (≤3)', (
    tester,
  ) async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(() => gracefulTeardown(tester));
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    for (final label in ['Add meal', 'Add weight', 'Add symptom']) {
      await tester.tap(find.text(label));
      await tester.pumpAndSettle();
      // Dürüst yer tutucu: form T16/T22/T23'te gelir.
      expect(find.text('Coming in an upcoming update'), findsOneWidget);
      // Geri dön, sıradaki eylem için.
      await tester.pageBack();
      await tester.pumpAndSettle();
    }
  });
}
