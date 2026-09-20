import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/app.dart';

/// T9 onboarding widget testleri: 8 adım ilerleme + risk kilidi notu +
/// onam onayı olmadan bitirilemez (MASTER §4, §16.3).
void main() {
  Future<void> advanceTo(WidgetTester tester, int step) async {
    await tester.pumpWidget(const ProviderScope(child: NKetoApp()));
    await tester.pumpAndSettle();
    for (var i = 0; i < step; i++) {
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
    }
  }

  testWidgets('8 adımın ilki dil; Next ile ilerler', (tester) async {
    await advanceTo(tester, 0);
    expect(find.text('Step 1 of 8'), findsOneWidget);
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Your data stays on your device'), findsOneWidget);
  });

  testWidgets('amaç adımı çoklu seçim kabul eder', (tester) async {
    await advanceTo(tester, 3);
    expect(find.text('What do you want to track?'), findsOneWidget);
    await tester.tap(find.text('Track glucose, ketones and GKI'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Plan meals'));
    await tester.pumpAndSettle();
    // İlerleme hâlâ çalışır (seçim zorunlu değil).
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('About you (optional)'), findsOneWidget);
  });

  testWidgets('risk işaretlendiğinde kilit notu görünür', (tester) async {
    await advanceTo(tester, 6);
    expect(find.text('A few safety questions'), findsOneWidget);
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

  testWidgets('onam kutusu işaretlenmeden bitirilemez', (tester) async {
    await advanceTo(tester, 7);
    expect(find.text('Consent'), findsOneWidget);
    FilledButton button() => tester.widget<FilledButton>(
      find.ancestor(
        of: find.text('Start using the app'),
        matching: find.byType(FilledButton),
      ),
    );
    expect(button().onPressed, isNull);
    await tester.tap(find.text('I accept'));
    await tester.pumpAndSettle();
    expect(button().onPressed, isNotNull);
  });
}
