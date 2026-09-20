import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/app.dart';

void main() {
  testWidgets('Bugün sekmesi ilk ekran; 5 sekmeli navigasyon var', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: NKetoApp()));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);
    // EN varsayılan test yerel ayarı: 5 sekme etiketi görünür.
    expect(find.text('Today'), findsWidgets);
    expect(find.text('Log'), findsWidgets);
    expect(find.text('Plan'), findsWidgets);
    expect(find.text('Trends'), findsOneWidget);
    expect(find.text('Guide'), findsOneWidget);
    // Bugün placeholder'ı yerinde.
    expect(find.text('This screen is being built.'), findsOneWidget);
  });

  testWidgets('Her sekme dokunuşla açılır', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: NKetoApp()));
    await tester.pumpAndSettle();

    // Sıra, turun 'Today' ile bitmesiyle router durumunu geri bırakır.
    for (final label in ['Log', 'Plan', 'Trends', 'Guide', 'Today']) {
      await tester.tap(find.text(label).first);
      await tester.pumpAndSettle();
      expect(find.text(label), findsWidgets);
    }
  });

  testWidgets('TR yerel ayarında sekmeler Türkçe', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: NKetoApp(localeOverride: Locale('tr'))),
    );
    await tester.pumpAndSettle();

    expect(find.text('Bugün'), findsWidgets);
    expect(find.text('Günlük'), findsWidgets);
    expect(find.text('Trendler'), findsWidgets);
    expect(find.text('Rehber'), findsWidgets);
    // IndexedStack ziyaret edilmiş dalları ağaçta tutabildiğinden en-az-bir
    // eşleşme kullanılır.
    expect(find.text('Bu ekran geliştiriliyor.'), findsWidgets);
  });
}
