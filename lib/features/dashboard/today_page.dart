import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/l10n/generated/app_localizations.dart';
import '../../app/theme/surfaces.dart';
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
      appBar: AppBar(
        title: Text(l10n.navToday),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: l10n.settingsTitle,
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          HeroCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.todayLatestTitle,
                  style: Theme.of(context).textTheme.labelLarge
                      ?.copyWith(color: Colors.white70, letterSpacing: 0.4),
                ),
                const SizedBox(height: 10),
                timeline.when(
                  loading: () => const SizedBox(
                    height: 48,
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
                  error: (e, _) => Text(l10n.todayLatestEmpty),
                  data: (list) {
                    final latest = list
                        .whereType<MeasurementTimelineEntry>()
                        .take(1)
                        .toList();
                    if (latest.isEmpty) {
                      return Text(
                        l10n.todayLatestEmpty,
                        style: Theme.of(context).textTheme.bodyLarge
                            ?.copyWith(color: Colors.white),
                      );
                    }
                    final e = latest.first;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GKI ${e.gki.toStringAsFixed(1)}',
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${e.glucoseMmolL.toStringAsFixed(1)} mmol/L · '
                          '${e.bhbMmolL.toStringAsFixed(1)} mmol/L',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          e.matchKind == 'simultaneous'
                              ? l10n.logMatchSimultaneous
                              : l10n.logMatchApproximate,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.white70),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(title: l10n.todayQuickActions, child: _QuickActions()),
          const SizedBox(height: 16),
          SectionCard(
            title: l10n.todayNutritionTitle,
            child: Text(l10n.todayNutritionEmpty),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: l10n.todayWeightTitle,
            child: Text(l10n.todayWeightEmpty),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: l10n.todaySymptomsTitle,
            child: Text(l10n.todaySymptomsEmpty),
          ),
          const SizedBox(height: 16),
          SectionCard(
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

/// 4 hızlı eylem: ana ekrandan tek dokunuşta ilgili forma gider
/// (≤3 dokunuş şartının ilk adımı).
class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = [
      (Icons.add_chart, l10n.todayAddMeasurement, '/log/session'),
      (Icons.restaurant, l10n.todayAddMeal, '/meals/new'),
      (Icons.monitor_weight_outlined, l10n.todayAddWeight, '/weight/new'),
      (Icons.healing, l10n.todayAddSymptom, '/symptoms/new'),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1.9,
      children: [
        for (final (icon, label, route) in items)
          _Action(icon: icon, label: label, route: route),
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
    final s = Theme.of(context).colorScheme;
    return Material(
      color: s.primary.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => context.push(route),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: s.primary),
              const SizedBox(height: 6),
              Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelLarge
                    ?.copyWith(color: s.onSurface, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
