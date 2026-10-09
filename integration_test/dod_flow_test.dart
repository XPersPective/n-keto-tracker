import 'dart:async';

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
  // PB-024: `fullyLive` altında sürekli bir animasyon (örn. küçük bir
  // spinner) varsa `pumpAndSettle` hiç durulmuş saymıyor ve 10+ dakika
  // askıda kalıyordu. `fadePointers` yeterli canlılığı korurken
  // sürekli animasyonları 1 saniyelik bir sınırda durdurarak testin
  // ilerlemesini sağlar.
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fadePointers;

  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async => db.close());

  // PB-024: `pumpAndSettle` 10 dakikalık varsayılan zaman aşımıyla
  // sonsuz döngüde kalabiliyor. Burada 3 saniyelik bir koruma uygula;
  // zaman aşımında `pump` ile düz ileri sar.
  Future<void> settleBounded(WidgetTester tester) async {
    try {
      await tester.pumpAndSettle(const Duration(seconds: 3));
    } on TimeoutException {
      // Animasyon durulmadı; düz pump ile birkaç kare ilerle.
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  testWidgets('DoD: onboarding → today → ölçüm → GKI 2.0 → günlük', (
    tester,
  ) async {
    // PB-024: emülatörde Flutter view attach + splash → ilk frame
    // geçişi zaman alabiliyor. `Width is zero` logları bu dönemde
    // geliyor; pumpWidget hemen ardından 3 saniyelik düz pump'la
    // renderer'ın gerçek boyutlara ulaşmasını bekle.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: const NKetoApp(),
      ),
    );
    for (var i = 0; i < 30; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    await settleBounded(tester);

    // 1-3) Onboarding 8 adım: Next ×7.
    for (var i = 0; i < 7; i++) {
      await tester.tap(find.text('Next'));
      await settleBounded(tester);
    }
    // 4) Onam kutusu + bitir.
    await tester.tap(find.text('I accept'));
    await settleBounded(tester);
    await tester.tap(find.text('Start using the app'));
    await settleBounded(tester);

    // 5) Bugün ekranı: hızlı eylemler görünür.
    expect(find.text('Add measurement'), findsOneWidget);
    await tester.tap(find.text('Add measurement'));
    await settleBounded(tester);

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
    await settleBounded(tester);

    // 7) GKI kartı: hesap + formül sürümü görünür (MASTER §6.2).
    expect(find.textContaining('GKI: 2.0'), findsOneWidget);
    expect(find.textContaining('5.0 mmol/L'), findsOneWidget);
    expect(find.textContaining('gki-v1'), findsOneWidget);

    // 8) Günlük sekmesi: alt navigasyondan 'Log' sekmesine dokun;
    // grafik bölümü üstte, çizelge altta. Liste hafifçe kaydırılır.
    await tester.tap(find.text('Log'));
    await settleBounded(tester);
    expect(find.byType(ListView), findsOneWidget);
    final scrollable = tester.state<ScrollableState>(
      find.byType(Scrollable).first,
    );
    scrollable.position.jumpTo(scrollable.position.maxScrollExtent);
    await settleBounded(tester);
    // Timeline girişi (GKI kartı) veya en azından boş-olmayan liste kanıtı.
    expect(
      find.textContaining('GKI'),
      findsWidgets,
      reason: 'Günlükte GKI girdisi görünmeli',
    );
  });
}
