import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/l10n/generated/app_localizations.dart';
import 'package:n_keto_tracker/features/evidence/guide_page.dart';

/// T17 Rehber ekranı testleri (MASTER_PROMPT §9): üç grup başlığı
/// görünür; kart açılınca Neden? + porsiyon + kaynak gösterilir; alt
/// bilgi vardır.

/// FutureBuilder yüklemesi bitene kadar pump (spinner sonsuz animasyonu
/// pumpAndSettle'ı engellediği için sabit döngü).
Future<void> pumpUntilFound(WidgetTester tester, Finder finder) async {
  for (var i = 0; i < 30; i++) {
    await tester.pump(const Duration(milliseconds: 100));
    if (finder.evaluate().isNotEmpty) return;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final cards =
      (jsonDecode(File('assets/seed/food_guide.json').readAsStringSync())
              as Map<String, dynamic>)['cards']
          as List<dynamic>;

  Widget scope() => ProviderScope(
    overrides: [
      guideCardsProvider.overrideWithValue(
        AsyncValue.data(cards.cast<Map<String, dynamic>>()),
      ),
    ],
    child: const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: GuidePage(),
    ),
  );

  testWidgets('üç grup başlığı ve kartlar render ediliyor', (tester) async {
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    expect(find.text('Generally a good fit'), findsOneWidget);
    expect(find.text('May need portion or frequency limits'), findsOneWidget);
    // İlk kart üstte (kaydırmadan önce doğrulanır).
    expect(find.text('Meat, fish, and eggs'), findsOneWidget);
    // Son grup başlığı kıvrım altında — kaydırıp kur.
    final avoidHeading = find.text(
      'Generally incompatible with ketogenic targets',
    );
    await tester.scrollUntilVisible(
      avoidHeading,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(avoidHeading, findsOneWidget);
    // Kart başlıkları (son).
    final sweets = find.text('Sugary drinks');
    await tester.scrollUntilVisible(
      sweets,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(sweets, findsOneWidget);
    // Sonraki testi etkilemesin: ağacı sök.
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });

  testWidgets('kart açılınca Neden? + tipik porsiyon + veri kaynağı görünür', (
    tester,
  ) async {
    await tester.pumpWidget(scope());
    // Ardışık test koşumunda rootBundle önbelleği FakeAsync içinde
    // çözünmeyebilir: gerçek zamanlı kısa bekleme + settle.
    await tester.pumpAndSettle();

    final sweets = find.text('Sugary drinks');
    await tester.dragUntilVisible(
      sweets,
      find.byType(ListView),
      const Offset(0, -200),
    );
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(sweets);
    // ExpansionTile animasyonu: sabit pump (settle zaman aşımına
    // düşebilir).
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();

    expect(find.text('Why?'), findsOneWidget);
    expect(find.textContaining('Liquid sugar'), findsOneWidget);
    expect(find.textContaining('Typical portion'), findsOneWidget);
    expect(find.textContaining('Data source: USDA'), findsOneWidget);
    // Kanıt etiketi (E6 görünür etiket).
    expect(find.text('General information'), findsWidgets);
    // Alt bilgi.
    final disclaimer = find.text(
      'For general information only; not medical advice.',
    );
    await tester.dragUntilVisible(
      disclaimer,
      find.byType(ListView),
      const Offset(0, -200),
    );
    expect(disclaimer, findsOneWidget);
  });
}
