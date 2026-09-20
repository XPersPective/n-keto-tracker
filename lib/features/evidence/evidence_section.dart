import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show Clipboard, ClipboardData, rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/generated/app_localizations.dart';

/// Rehber > Bilimsel Kaynaklar ve Makaleler bölümü (MASTER_PROMPT §5.5,
/// T25).
///
/// - Genel kaynaklar varsayılan görünür.
/// - Hastalığa özel araştırmalar yalnız kullanıcının BİLİİNCİ açtığı
///   filtreyle listelenir (ana sayfada öneri gösterilmez).
/// - URL yalnız KOPYALANABİLİR metindir; uygulama bağlantıyı AÇMAZ (§2.3).
/// - Kart katmanları: sade özet → sınırlılıklar → künye (§2.1).
///
/// Yükleme FutureProvider ile: build'de future yeniden yaratmanın yol
/// açtığı sonsuz loading döngüsünden kaçınılır; testlerde override edilir.
final evidenceSourcesProvider =
    FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
      final raw = await rootBundle.loadString('assets/seed/evidence.json');
      final doc = jsonDecode(raw) as Map<String, dynamic>;
      return (doc['sources'] as List).cast<Map<String, dynamic>>();
    });

class EvidenceSection extends ConsumerWidget {
  const EvidenceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final sourcesAsync = ref.watch(evidenceSourcesProvider);
    final showDisease = ref.watch(diseaseResearchFilterProvider);

    return sourcesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Text(l10n.trendsEmpty),
      data: (sources) {
        final general = sources.where(
          (s) => !(s['diseaseSpecific'] as bool? ?? false),
        );
        final disease = sources.where(
          (s) => (s['diseaseSpecific'] as bool? ?? false),
        );
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ...general.map((s) => _SourceCard(source: s)),
            const SizedBox(height: 16),
            SwitchListTile(
              title: Text(l10n.evidenceDiseaseFilter),
              value: showDisease,
              onChanged: (_) =>
                  ref.read(diseaseResearchFilterProvider.notifier).toggle(),
            ),
            if (showDisease) ...[
              const SizedBox(height: 8),
              ...disease.map((s) => _SourceCard(source: s)),
            ],
          ],
        );
      },
    );
  }
}

/// Hastalığa özel araştırmalar filtresi: varsayılan KAPALI.
class DiseaseResearchFilter extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle() => state = !state;
}

final diseaseResearchFilterProvider =
    NotifierProvider<DiseaseResearchFilter, bool>(DiseaseResearchFilter.new);

class _SourceCard extends StatelessWidget {
  const _SourceCard({required this.source});

  final Map<String, dynamic> source;

  @override
  Widget build(BuildContext context) {
    final isTr = Localizations.localeOf(context).languageCode == 'tr';
    final summary = isTr ? source['plainSummaryTr'] : source['plainSummaryEn'];
    return Card(
      child: ExpansionTile(
        title: Text(isTr ? source['titleTr'] : source['titleEn']),
        subtitle: Text(
          isTr ? source['evidenceLabelTr'] : source['evidenceLabelEn'],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(summary),
                const SizedBox(height: 8),
                Text(
                  isTr ? source['limitationsTr'] : source['limitationsEn'],
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Text('${source['journal']}, ${source['year']}'),
                // URL yalnız KOPYALANIR; açma butonu yok (§2.3).
                TextButton.icon(
                  icon: const Icon(Icons.copy),
                  label: Text(AppLocalizations.of(context)!.guideCopyLink),
                  onPressed: () => Clipboard.setData(
                    ClipboardData(text: source['canonicalUrl'] as String),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
