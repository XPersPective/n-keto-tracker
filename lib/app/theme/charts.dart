import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Ortak çizgi grafik stili: ince kesikli ızgara, çerçevesiz, vurgu renkli
/// çizgi + alt gradyan, noktalar yüzey renkli halkalı. Renkler yalnız
/// temadan (açık/koyu otomatik). Eksik gün sıfır sayılmaz; noktalar arası
/// doğal çizgi korunur, eğri yumuşatma YOK (aykırı değerler bozulmaz).
class TrendLineChart extends StatelessWidget {
  const TrendLineChart({
    super.key,
    required this.values,
    this.height = 150,
    this.color,
    this.showBand = false,
  });

  final List<double> values;
  final double height;
  final Color? color;

  /// Araştırma bandı açıkken çizgi altı yumuşak dolgu biraz güçlenir.
  final bool showBand;

  @override
  Widget build(BuildContext context) {
    final s = Theme.of(context).colorScheme;
    final c = color ?? s.primary;
    final lo = values.reduce(math.min);
    final hi = values.reduce(math.max);
    final span = hi - lo;
    final pad = span == 0 ? (hi.abs() * 0.2 + 0.5) : span * 0.25;
    final minY = lo - pad;
    final maxY = hi + pad;
    final interval = (maxY - minY) / 3;
    final label = Theme.of(context).textTheme.labelSmall
        ?.copyWith(color: s.onSurfaceVariant);

    return SizedBox(
      height: height,
      child: LineChart(
        LineChartData(
          minX: -0.5,
          maxX: values.length - 0.5,
          minY: minY,
          maxY: maxY,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            drawVerticalLine: false,
            horizontalInterval: interval,
            getDrawingHorizontalLine: (_) => FlLine(
              color: s.outlineVariant,
              strokeWidth: 1,
              dashArray: const [4, 4],
            ),
          ),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
            bottomTitles: const AxisTitles(),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 36,
                interval: interval,
                getTitlesWidget: (v, meta) {
                  if (v == meta.min || v == meta.max) {
                    return const SizedBox.shrink();
                  }
                  return Text(v.toStringAsFixed(1), style: label);
                },
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (var i = 0; i < values.length; i++)
                  FlSpot(i.toDouble(), values[i]),
              ],
              color: c,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: values.length <= 45,
                getDotPainter: (spot, percent, bar, index) =>
                    FlDotCirclePainter(
                      radius: 4.5,
                      color: c,
                      strokeWidth: 2.5,
                      strokeColor: s.surfaceContainerLow,
                    ),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    c.withValues(alpha: showBand ? 0.34 : 0.22),
                    c.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
