import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/app.dart';

/// Onboarding widget testleri (3 sayfa): hoş geldin + hedef, güvenlik + onam,
/// hazırım. Onam işaretlenmeden ileri gidilmez; risk işaretlenince kilit notu
/// görünür (MASTER §4, §16.3).
void main() {
  Future<void> advanceTo(WidgetTester tester, int step) async {
    await tester.pumpWidget(const ProviderScope(child: NKetoApp()));
    await tester.pumpAndSettle();
    for (var i = 0; i < step; i++) {
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
    }
  }

  FilledButton nextButton(WidgetTester tester) => tester.widget<FilledButton>(
    find.ancestor(of: find.text('Next'), matching: find.byType(FilledButton)),
  );

  testWidgets('3 sayfanın ilki hoş geldin; Next ile güvenlik sayfasına geçer', (
    tester,
  ) async {
    await advanceTo(tester, 0);
    expect(find.text('Step 1 of 3'), findsOneWidget);
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Safety first'), findsOneWidget);
    expect(find.text('Step 2 of 3'), findsOneWidget);
  });

  testWidgets('hedef seçimi zorunlu değil', (tester) async {
    await advanceTo(tester, 0);
    await tester.tap(find.text('Track glucose, ketones and GKI'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Step 2 of 3'), findsOneWidget);
  });

  testWidgets('risk işaretlendiğinde kilit notu görünür', (tester) async {
    await advanceTo(tester, 1);
    expect(
      find.textContaining('automatic plan and goal creation stays off'),
      findsNothing,
    );
    await tester.tap(find.text('Have diabetes'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('automatic plan and goal creation stays off'),
      findsOneWidget,
    );
  });

  testWidgets('onam işaretlenmeden güvenlik sayfasından ileri gidilmez', (
    tester,
  ) async {
    await advanceTo(tester, 1);
    expect(nextButton(tester).onPressed, isNull);
    await tester.ensureVisible(find.text('I accept'));
    await tester.tap(find.text('I accept'));
    await tester.pumpAndSettle();
    expect(nextButton(tester).onPressed, isNotNull);
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Almost there'), findsOneWidget);
    expect(find.text('Start using the app'), findsOneWidget);
  });
}
