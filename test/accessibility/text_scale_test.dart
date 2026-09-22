import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/l10n/generated/app_localizations.dart';
import 'package:n_keto_tracker/features/onboarding/onboarding_page.dart';

/// PB-004 erişilebilirlik (MASTER §12, §16.3): Metin ölçeği
/// 1.15x/1.3x'te hata yok; alt dokunma hedefleri ≥48dp.
void main() {
  Widget scope() => const ProviderScope(
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: OnboardingPage(),
    ),
  );

  testWidgets('1.15x yazı ölçeğinde taşma yok', (tester) async {
    tester.view.platformDispatcher.textScaleFactorTestValue = 1.15;
    addTearDown(tester.view.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('1.3x yazı ölçeğinde taşma yok', (tester) async {
    tester.view.platformDispatcher.textScaleFactorTestValue = 1.3;
    addTearDown(tester.view.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('Next düğmesi ≥48dp', (tester) async {
    tester.view.platformDispatcher.textScaleFactorTestValue = 1.0;
    addTearDown(tester.view.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();
    final next = tester.getSize(
      find.ancestor(of: find.text('Next'), matching: find.byType(FilledButton)),
    );
    expect(next.height, greaterThanOrEqualTo(48));
    expect(next.width, greaterThanOrEqualTo(48));
  });
}
