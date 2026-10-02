import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/l10n/generated/app_localizations.dart';
import 'package:n_keto_tracker/features/settings/about_page.dart';

/// PB-002 Hakkında sayfası testleri (ORTAK §3.3): ad+sürüm, açık kaynak
/// (GPL-3.0), gizlilik özeti, feragat, Lisanslar/Paylaş girişleri;
/// ağ çağrısı yok — bağlantılar yalnız kopyalanabilir.
void main() {
  Widget scope() => const MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: AboutPage(),
  );

  testWidgets('ad, sürüm, açık kaynak ve gizlilik bölümleri render', (
    tester,
  ) async {
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    expect(find.text('N Keto Tracker'), findsOneWidget);
    expect(find.text('Fully offline keto journal'), findsOneWidget);
    expect(find.text('Version dev'), findsOneWidget);
    expect(find.textContaining('GPL-3.0'), findsOneWidget);
    expect(
      find.textContaining('All data stays on this device'),
      findsOneWidget,
    );
    expect(find.textContaining('not medical advice'), findsOneWidget);
    // Lisanslar + Paylaş girişleri kıvrım altında — kaydırıp kur.
    final licenses = find.text('Licenses');
    await tester.scrollUntilVisible(
      licenses,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(licenses, findsOneWidget);
    final share = find.text('Share this app');
    await tester.scrollUntilVisible(
      share,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(share, findsOneWidget);
    // ORTAK §3.6: Diğer uygulamalar girişi canlı (PB-009).
    final otherApps = find.text('Other apps');
    await tester.scrollUntilVisible(
      otherApps,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(otherApps, findsOneWidget);
    // Repo bağlantısı kopyalanabilir metin olarak görünür.
    expect(
      find.textContaining('github.com/XPersPective/n-keto-tracker'),
      findsOneWidget,
    );
    // Açma butonu yok (url_launcher kullanılmıyor): open_in_new simgesi.
    expect(find.byIcon(Icons.open_in_new), findsNothing);
  });

  testWidgets('repo bağlantısını kopyalar ve bildirim gösterir', (
    tester,
  ) async {
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    await tester.tap(find.textContaining('github.com/XPersPective'));
    await tester.pumpAndSettle();

    expect(find.text('Copied to clipboard.'), findsOneWidget);
  });
}
