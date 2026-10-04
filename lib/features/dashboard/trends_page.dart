import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/generated/app_localizations.dart';
import '../../app/theme/charts.dart';
import '../../app/theme/surfaces.dart';
import '../measurements/log_view_model.dart';

/// Trendler ekranı (MASTER_PROMPT §5.4 + §12, T24):
/// - 7/30/90 gün aralık seçimi;
/// - GKI/glukoz/BHB/ağırlık ayrı küçük grafikler (bağımsız eksen);
/// - ham noktalar gösterilir, veri yoksa çizgi UYDURULMAZ;
/// - her grafikte metinsel özet (ekran okuyucu için);
/// - "ne anlatır/ne anlatmaz" kalıcı açıklaması.
class TrendsPage extends ConsumerStatefulWidget {
  const TrendsPage({super.key});

  @override
  ConsumerState<TrendsPage> createState() => _TrendsPageState();
}

class _TrendsPageState extends ConsumerState<TrendsPage> {
  int _rangeDays = 7;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final series = ref.watch(chartSeriesProvider);
    final weights = ref.watch(weightSeriesProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navTrends)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: 7, label: Text('7')),
              ButtonSegment(value: 30, label: Text('30')),
              ButtonSegment(value: 90, label: Text('90')),
            ],
            selected: {_rangeDays},
            onSelectionChanged: (s) => setState(() => _rangeDays = s.first),
          ),
          const SizedBox(height: 12),
          series.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text(l10n.trendsEmpty),
            data: (s) => Column(
              children: [
                _TrendChart(
                  title: l10n.logGkiChart,
                  points: _inRange(s.gki),
                  emptyText: l10n.trendsEmpty,
                  summary: _summary(_inRange(s.gki), l10n),
                ),
                _TrendChart(
                  title: l10n.logGlucoseChart,
                  points: _inRange(s.glucose),
                  emptyText: l10n.trendsEmpty,
                  summary: _summary(_inRange(s.glucose), l10n),
                ),
                _TrendChart(
                  title: l10n.logBhbChart,
                  points: _inRange(s.bhb),
                  emptyText: l10n.trendsEmpty,
                  summary: _summary(_inRange(s.bhb), l10n),
                ),
              ],
            ),
          ),
          weights.when(
            loading: () => const SizedBox.shrink(),
            error: (e, _) => const SizedBox.shrink(),
            data: (w) => _TrendChart(
              title: l10n.trendsWeightChart,
              points: _inRange(w),
              emptyText: l10n.trendsEmpty,
              summary: _summary(_inRange(w), l10n),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.trendsBandsNote,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          // "Ne anlatır / ne anlatmaz" kalıcı açıklaması (MASTER §12).
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.trendsExplainsTitle,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(l10n.trendsExplainsBody),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<ChartPoint> _inRange(List<ChartPoint> points) {
    final cutoff = DateTime.now().toUtc().subtract(Duration(days: _rangeDays));
    return points.where((p) => p.atUtc.isAfter(cutoff)).toList();
  }

  /// Metinsel özet: ekran okuyucu için grafiğin eşdeğeri (MASTER §12).
  String? _summary(List<ChartPoint> points, AppLocalizations l10n) {
    if (points.isEmpty) return null;
    final latest = points.last.value;
    final avg =
        points.map((p) => p.value).reduce((a, b) => a + b) / points.length;
    return l10n.trendsSummary(
      points.length.toString(),
      _rangeDays.toString(),
      latest.toStringAsFixed(1),
      avg.toStringAsFixed(1),
    );
  }
}

class _TrendChart extends StatelessWidget {
  const _TrendChart({
    required this.title,
    required this.points,
    required this.emptyText,
    required this.summary,
  });

  final String title;
  final List<ChartPoint> points;
  final String emptyText;
  final String? summary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SectionCard(
        title: title,
        // Eksik gün sıfır kabul edilmez; veri yoksa grafik yerine dürüst boş
        // durum (§12). Aykırı değerler korunur (filtre yok).
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (points.isEmpty)
              SizedBox(height: 80, child: Center(child: Text(emptyText)))
            else
              TrendLineChart(values: [for (final p in points) p.value]),
            if (summary != null) ...[
              const SizedBox(height: 8),
              Text(summary!, style: Theme.of(context).textTheme.bodySmall),
            ],
          ],
        ),
      ),
    );
  }
}
