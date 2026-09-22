import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:drift/native.dart';
import 'package:n_keto_tracker/app/app.dart';
import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/providers.dart';

/// DoD senaryosu (MASTER_PROMPT §20) — emülatörde uçtan uca:
/// onboarding (onam dahil) → Bugün → ölçüm oturumu (90 mg/dL + 2,5 →
/// GKI 2,0) → Günlük çizelgesi. Uygulama ağ kullanmadığından uçak modu
/// eşdeğeridir (manifest'te INTERNET izni yok — §14.1 kanıtı).
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async => db.close());

  testWidgets('DoD: onboarding → today → ölçüm → GKI 2.0 → günlük', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: const NKetoApp(),
      ),
    );
    await tester.pumpAndSettle();

    // 1-3) Onboarding 8 adım: Next ×7.
    for (var i = 0; i < 7; i++) {
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
    }
    // 4) Onam kutusu + bitir.
    await tester.tap(find.text('I accept'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start using the app'));
    await tester.pumpAndSettle();

    // 5) Bugün ekranı: hızlı eylemler görünür.
    expect(find.text('Add measurement'), findsOneWidget);
    await tester.tap(find.text('Add measurement'));
    await tester.pumpAndSettle();

    // 6) Ölçüm oturumu: 90 mg/dL + 2,5 → kaydet.
    await tester.enterText(
      find.widgetWithText(TextField, 'Glucose (mg/dL)').first,
      '90',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Blood ketone BHB (mmol/L)').first,
      '2,5',
    );
    await tester.tap(find.text('Save measurement session'));
    await tester.pumpAndSettle();

    // 7) GKI kartı: hesap + formül sürümü görünür (MASTER §6.2).
    expect(find.textContaining('GKI: 2.0'), findsOneWidget);
    expect(find.textContaining('5.0 mmol/L'), findsOneWidget);
    expect(find.textContaining('gki-v1'), findsOneWidget);

    // 8) Günlük sekmesi: alt navigasyondan 'Log' sekmesine dokun;
    // grafik bölümü üstte, çizelge altta. Liste hafifçe kaydırılır.
    await tester.tap(find.text('Log'));
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsOneWidget);
    final scrollable = tester.state<ScrollableState>(
      find.byType(Scrollable).first,
    );
    scrollable.position.jumpTo(scrollable.position.maxScrollExtent);
    await tester.pumpAndSettle();
    // Timeline girişi (GKI kartı) veya en azından boş-olmayan liste kanıtı.
    expect(
      find.textContaining('GKI'),
      findsWidgets,
      reason: 'Günlükte GKI girdisi görünmeli',
    );
  });
}
