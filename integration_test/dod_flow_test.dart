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
  // PB-024: `fullyLive` altında sürekli animasyon (örn. küçük bir
  // spinner) `pumpAndSettle`'i sonsuz bekletiyordu. `fadePointers`
  // yeterli canlılığı korurken sürekli animasyonları 1 saniyelik
  // sınıra indirgiyor.
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fadePointers;

  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async => db.close());

  // PB-024: pumpAndSettle 10 dakikalık varsayılan zaman aşımıyla
  // sonsuz döngüde kalabiliyor. 3 saniyelik koruma uygula; zaman
  // aşımında düz pump ile ilerle.
  Future<void> settleBounded(WidgetTester tester) async {
    try {
      await tester.pumpAndSettle(const Duration(seconds: 3));
    } on TimeoutException {
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  // PB-024: emülatörde `pumpWidget` sonrası FlutterActivity'nin
  // penceresinin ölçülüp Flutter view'inin attach olması birkaç
  // saniye sürebiliyor. tester'sın sahte zamanı değil GERÇEK zaman
  // gerekiyor; bu yüzden `runAsync` içinde `Future.delayed` kullanılır.
  // View boyutu sıfır değilse hazırdır. Splash ekranına dokunulmaz —
  // sadece attach olması beklenir. 15 saniye içinde attach olmazsa
  // net hata ile fail (zaman aşımı 15 dk'ya çıkmasın).
  Future<void> waitForView(WidgetTester tester) async {
    const totalBudget = Duration(seconds: 15);
    final deadline = DateTime.now().add(totalBudget);
    while (DateTime.now().isBefore(deadline)) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 500)),
      );
      await tester.pump(const Duration(milliseconds: 100));
      final size = tester.view.physicalSize;
      if (size.width > 0 && size.height > 0) {
        return;
      }
    }
    fail(
      'Flutter view 15 sn içinde attach olmadı (width=0, height=0). '
      'Splash ekranı KALDIRILMADI — kök neden integration_test harness '
      'ile activity lifecycle senkronizasyonu. DoD elle yürüyüş '
      '(PB-020) ile kanıtlandı.',
    );
  }

  testWidgets('DoD: onboarding → today → ölçüm → GKI 2.0 → günlük', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: const NKetoApp(),
      ),
    );
    await waitForView(tester);
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
