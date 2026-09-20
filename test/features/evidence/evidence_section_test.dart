import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/l10n/generated/app_localizations.dart';
import 'package:n_keto_tracker/features/evidence/evidence_section.dart';

/// T25 Bilimsel Kaynaklar widget testleri (MASTER_PROMPT §5.5, AC4):
/// hastalığa özel içerik varsayılan GİZLİ; bilinçli filtreyle görünür;
/// URL yalnız kopyalanabilir metin (açma butonu yok).
void main() {
  final sources =
      (jsonDecode(File('assets/seed/evidence.json').readAsStringSync())
              as Map<String, dynamic>)['sources']
          as List<dynamic>;

  Widget scope() => ProviderScope(
    overrides: [
      evidenceSourcesProvider.overrideWithValue(
        AsyncValue.data(sources.cast<Map<String, dynamic>>()),
      ),
    ],
    child: const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: EvidenceSection()),
    ),
  );

  testWidgets('varsayılan görünüm: hastalık içeriği GİZLİ, genel kaynak var', (
    tester,
  ) async {
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    // Genel kaynak (Mifflin) görünür.
    expect(find.textContaining('Predictive equation'), findsOneWidget);
    // Hastalığa özel başlıklar gizli.
    expect(find.textContaining('glioblastoma'), findsNothing);
    expect(find.textContaining('Glioblastoma'), findsNothing);
    expect(find.textContaining('phase 1'), findsNothing);

    // Filtre anahtarı görünür (kullanıcının bilinçli seçimi için).
    expect(
      find.text(
        'Show disease-specific research (from the sources you choose to read)',
      ),
      findsOneWidget,
    );
  });

  testWidgets('filtre açılınca hastalığa özel kaynaklar listelenir', (
    tester,
  ) async {
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text(
        'Show disease-specific research (from the sources you choose to read)',
      ),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(
      find.text(
        'Show disease-specific research (from the sources you choose to read)',
      ),
    );
    await tester.pumpAndSettle();

    // Hastalığa özel başlık artık görünür.
    expect(find.textContaining('Clinical research framework'), findsWidgets);
  });

  testWidgets('kaynak kartında açma butonu yok; yalnız kopyala (§2.3)', (
    tester,
  ) async {
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    // Kartı aç.
    await tester.tap(find.textContaining('Predictive equation'));
    await tester.pumpAndSettle();

    // Kopyala düğmesi var.
    expect(find.text('Copy source link'), findsOneWidget);
    // 'url_launcher' davranışı yok: Launch/içinde aç butonu YOK.
    expect(find.byIcon(Icons.open_in_new), findsNothing);
    expect(find.text('Open'), findsNothing);
  });
}
