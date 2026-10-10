import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/l10n/generated/app_localizations.dart';
import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/providers.dart';
import 'package:n_keto_tracker/features/walking/walking_plan_page.dart';

/// Yürüyüş planı sayfası widget testleri (MASTER §4.8):
/// - profil olmadan da render edilir (varsayılan değerlerle)
/// - 8 hafta × 7 gün kart yapısı görünür
/// - kanıt başlığı ve disclaimeri görünür
/// - lokalize başlık "Walking plan" / "Yürüyüş planı" çeviri tablosunda
void main() {
  late AppDatabase db;

  Widget scope({Locale? locale}) {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    return ProviderScope(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
      child: MaterialApp(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const WalkingPlanPage(),
      ),
    );
  }

  void tallScreen(WidgetTester tester) {
    tester.view.physicalSize = const Size(800, 4000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  Future<void> teardown(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await db.close();
  }

  testWidgets('profil olmadan sayfa render edilir (varsayılanlarla)', (
    tester,
  ) async {
    tallScreen(tester);
    addTearDown(() => teardown(tester));
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();
    // AppBar başlığı
    expect(find.text('Walking plan'), findsOneWidget);
    // "Personalized for you" alt başlığı
    expect(find.text('Personalized for you'), findsOneWidget);
    // Kanıt başlığı
    expect(find.text('Scientific sources'), findsOneWidget);
    // 8 hafta başlığı
    expect(find.text('Week 1'), findsOneWidget);
    expect(find.text('Week 8'), findsOneWidget);
  });

  testWidgets('TR lokalizasyonu ile Türkçe başlık görünür', (tester) async {
    tallScreen(tester);
    addTearDown(() => teardown(tester));
    await tester.pumpWidget(scope(locale: const Locale('tr')));
    await tester.pumpAndSettle();
    expect(find.text('Yürüyüş planı'), findsOneWidget);
    expect(find.text('Size özel'), findsOneWidget);
    expect(find.text('Bilimsel kaynaklar'), findsOneWidget);
  });

  testWidgets('disclaimer (genel bilgi) görünür', (tester) async {
    tallScreen(tester);
    addTearDown(() => teardown(tester));
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();
    expect(
      find.text('For general information only; not medical advice.'),
      findsOneWidget,
    );
  });
}
