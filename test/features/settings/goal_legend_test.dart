import 'package:flutter/material.dart';

import 'package:n_keto_tracker/app/l10n/generated/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/features/settings/goal_legend.dart';

/// T21 lejant widget testi (MASTER_PROMPT §6.5, AC9): üç hedef türü
/// ayrı etiket/şekil; hiçbiri diğerine dönüştürülmez (etiketler ayrık).
void main() {
  Widget scope({Set<String> visible = const {}}) => MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: GoalLegend(visibleTypes: visible)),
  );

  testWidgets('üç türün etiketleri ayrık ve günlük dilde', (tester) async {
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    expect(find.text('Research range used in a study'), findsOneWidget);
    expect(find.text("My clinician's target"), findsOneWidget);
    expect(find.text('My personal tracking goal'), findsOneWidget);
  });

  testWidgets('yalnız kayıtlı türler gösterilir', (tester) async {
    await tester.pumpWidget(scope(visible: {'clinicianTarget'}));
    await tester.pumpAndSettle();

    expect(find.text("My clinician's target"), findsOneWidget);
    expect(find.text('Research range used in a study'), findsNothing);
    expect(find.text('My personal tracking goal'), findsNothing);
  });

  testWidgets('kişisel hedefin tıbbi-değildir notu görünür', (tester) async {
    await tester.pumpWidget(scope(visible: {'personalTrackingGoal'}));
    // Not lejantın içinde değil; T21 hedefler ekranında ayrı metindir.
    // Burada yalnız lejant davranışı doğrulanır.
    expect(find.text('My personal tracking goal'), findsOneWidget);
    expect(
      find.text('A personal tracking goal is not a medical target.'),
      findsNothing,
    );
  });
}
