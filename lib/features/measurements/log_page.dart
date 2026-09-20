import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/generated/app_localizations.dart';
import '../../core/units/meal_measurement_relation.dart';
import 'log_view_model.dart';

/// Günlük ekranı (MASTER_PROMPT §5.2): tek kronolojik zaman çizelgesi +
/// ayrı küçük grafikler + varsayılan kapalı araştırma bantları.
class LogPage extends ConsumerWidget {
  const LogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final entries = ref.watch(timelineProvider);
    final series = ref.watch(chartSeriesProvider);
    final bandsOn = ref.watch(researchBandsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navLog)),
      body: entries.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l10n.logEmptyTitle)),
        data: (list) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              l10n.logChartsHeading,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            series.when(
              loading: () => const SizedBox.shrink(),
              error: (e, _) => const SizedBox.shrink(),
              data: (s) => Column(
                children: [
                  _MetricChart(title: l10n.logGlucoseChart, points: s.glucose),
                  _MetricChart(title: l10n.logBhbChart, points: s.bhb),
                  // Bantlar yalnız bu GKI grafiğinde ve varsayılan kapalı.
                  _MetricChart(
                    title: l10n.logGkiChart,
                    points: s.gki,
                    bandsOn: bandsOn,
                    // Kalıcı açıklama: bantlar kapalıyken de bu grafiğin
                    // altında görünür (§6.4).
                    showDisclaimer: true,
                    disclaimerText: l10n.bandsDisclaimer,
                  ),
                ],
              ),
            ),
            SwitchListTile(
              title: Text(l10n.logBandsToggle),
              value: bandsOn,
              onChanged: (_) =>
                  ref.read(researchBandsProvider.notifier).toggle(),
            ),
            const Divider(height: 32),
            Text(
              l10n.logTimelineHeading,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            // Karıştırıcı etkenler eğitim kartı (MASTER §8.3).
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.logConfoundersHeading,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    for (final (tr, en) in confoundingFactors)
                      Text(
                        Localizations.localeOf(context).languageCode == 'tr'
                            ? tr
                            : en,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            if (list.isEmpty)
              Column(
                children: [
                  Text(
                    l10n.logEmptyTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(l10n.logEmptyBody),
                ],
              )
            else
              ...list.whereType<MeasurementTimelineEntry>().map(
                (e) => _EntryCard(entry: e, l10n: l10n),
              ),
          ],
        ),
      ),
    );
  }
}

class _EntryCard extends StatelessWidget {
  const _EntryCard({required this.entry, required this.l10n});

  final MeasurementTimelineEntry entry;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final matchLabel = entry.matchKind == 'simultaneous'
        ? l10n.logMatchSimultaneous
        : l10n.logMatchApproximate;
    final relationLine = entry.relatedMealType == null
        ? l10n.logNoMealRelation
        : l10n.logMealRelation(
            (entry.relatedMealHoursAfter ?? 0).toStringAsFixed(1),
            switch (entry.relatedMealType) {
              'breakfast' => l10n.mealTypeShortBreakfast,
              'lunch' => l10n.mealTypeShortLunch,
              'dinner' => l10n.mealTypeShortDinner,
              'snack' => l10n.mealTypeShortSnack,
              _ => l10n.mealTypeShortCustom,
            },
          );
    return Card(
      child: ListTile(
        // Renk tek başına anlam taşımaz; metin etiketi var (§12).
        title: Text('GKI ${entry.gki.toStringAsFixed(1)}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${entry.glucoseMmolL.toStringAsFixed(1)} mmol/L · '
              '${entry.bhbMmolL.toStringAsFixed(1)} mmol/L · $matchLabel',
            ),
            const SizedBox(height: 4),
            Text(relationLine, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

/// Ayrı küçük grafik (§22.4): bağımsız eksen, eksik gün boşluk.
class _MetricChart extends StatelessWidget {
  const _MetricChart({
    required this.title,
    required this.points,
    this.bandsOn = false,
    this.showDisclaimer = false,
    this.disclaimerText,
  });

  final String title;
  final List<ChartPoint> points;
  final bool bandsOn;
  final bool showDisclaimer;
  final String? disclaimerText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 4),
        SizedBox(
          height: 120,
          child: points.isEmpty
              ? Center(child: Text(AppLocalizations.of(context)!.logEmptyTitle))
              : LineChart(
                  LineChartData(
                    // Eksik veri için çizgi uydurma yok: noktalar arası
                    // doğal boşluk korunur (§12).
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          for (var i = 0; i < points.length; i++)
                            FlSpot(i.toDouble(), points[i].value),
                        ],
                        dotData: const FlDotData(show: true),
                      ),
                    ],
                    // Araştırma bantları yalnız GKI grafiğinde, açık ve
                    // yumuşak tonlu (§6.4).
                    betweenBarsData: bandsOn
                        ? [
                            BetweenBarsData(
                              fromIndex: 0,
                              toIndex: 0,
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerHighest,
                            ),
                          ]
                        : const [],
                  ),
                ),
        ),
        if (showDisclaimer && disclaimerText != null)
          Text(disclaimerText!, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 12),
      ],
    );
  }
}

/// Kaynak bağlantısı: yalnız kopyalanabilir metin, uygulama açmaz (§2.3).
Future<void> copySourceLink(String url) =>
    Clipboard.setData(ClipboardData(text: url));
