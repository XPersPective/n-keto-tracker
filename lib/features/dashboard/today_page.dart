import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/l10n/generated/app_localizations.dart';
import '../measurements/log_view_model.dart';

/// Bugün ekranı (MASTER_PROMPT §5.1): son ölçümler, günlük toplamlar,
/// hızlı eylemler (≤3 dokunuş), tıbbi-olmayan alt bilgisi. Öğün toplamları
/// T16'dan, ağırlık T22'den, semptom T23'ten, planlı öğünler T20'den
/// dolar; o ana kadar dürüst boş durumlar.
class TodayPage extends ConsumerWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final timeline = ref.watch(timelineProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navToday)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Section(title: l10n.todayQuickActions, child: _QuickActions()),
          const SizedBox(height: 16),
          _Section(
            title: l10n.todayLatestTitle,
            child: timeline.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text(l10n.todayLatestEmpty),
              data: (list) {
                final latest = list
                    .whereType<MeasurementTimelineEntry>()
                    .take(1)
                    .toList();
                if (latest.isEmpty) {
                  return Text(l10n.todayLatestEmpty);
                }
                final e = latest.first;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'GKI ${e.gki.toStringAsFixed(1)} · '
                      '${e.glucoseMmolL.toStringAsFixed(1)} mmol/L · '
                      '${e.bhbMmolL.toStringAsFixed(1)} mmol/L',
                    ),
                    const SizedBox(height: 4),
                    Text(
                      e.matchKind == 'simultaneous'
                          ? l10n.logMatchSimultaneous
                          : l10n.logMatchApproximate,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          _Section(
            title: l10n.todayNutritionTitle,
            child: Text(l10n.todayNutritionEmpty),
          ),
          const SizedBox(height: 16),
          _Section(
            title: l10n.todayWeightTitle,
            child: Text(l10n.todayWeightEmpty),
          ),
          const SizedBox(height: 16),
          _Section(
            title: l10n.todaySymptomsTitle,
            child: Text(l10n.todaySymptomsEmpty),
          ),
          const SizedBox(height: 16),
          _Section(
            title: l10n.todayPlansTitle,
            child: Text(l10n.todayPlansEmpty),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.generalInfoDisclaimer,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

/// 4 hızlı eylem: ana ekrandan tek dokunuşta ilgili forma gider
/// (≤3 dokunuş şartının ilk adımı).
class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _Action(
          icon: Icons.add_chart,
          label: l10n.todayAddMeasurement,
          route: '/log/session',
        ),
        _Action(
          icon: Icons.restaurant,
          label: l10n.todayAddMeal,
          route: '/meals/new',
        ),
        _Action(
          icon: Icons.monitor_weight_outlined,
          label: l10n.todayAddWeight,
          route: '/weight/new',
        ),
        _Action(
          icon: Icons.healing,
          label: l10n.todayAddSymptom,
          route: '/symptoms/new',
        ),
      ],
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({required this.icon, required this.label, required this.route});

  final IconData icon;
  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 64,
      child: OutlinedButton.icon(
        icon: Icon(icon),
        label: Text(label, textAlign: TextAlign.center),
        onPressed: () => context.push(route),
      ),
    );
  }
}
