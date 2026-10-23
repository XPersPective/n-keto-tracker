import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/l10n/generated/app_localizations.dart';
import '../activity/activity_view_model.dart';
import '../measurements/log_view_model.dart';
import 'today_view_model.dart';

/// Bugünün üç adımı: öğün, hareket, ölçüm. Her satır ilgili kayda gider;
/// tamamlanan adım işaretli görünür. Adımlar veriden türetilir, elle
/// işaretlenmez.
class DailyChecklist extends ConsumerWidget {
  const DailyChecklist({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final meals = ref.watch(todayMealsProvider).value ?? const [];
    final activity = ref.watch(todayActivityProvider).value ?? const [];
    final timeline = ref.watch(timelineProvider).value ?? const [];

    final now = DateTime.now();
    final measuredToday = timeline.any((e) {
      final local = e.atUtc.add(Duration(minutes: e.offsetMinutes));
      return local.year == now.year &&
          local.month == now.month &&
          local.day == now.day;
    });

    final steps = <_Step>[
      _Step(
        done: meals.isNotEmpty,
        label: l10n.todayStepMeal,
        icon: Icons.restaurant,
        route: '/meals/new',
      ),
      _Step(
        done: activity.isNotEmpty,
        label: l10n.todayStepActivity,
        icon: Icons.directions_run,
        route: '/activity/timer',
      ),
      _Step(
        done: measuredToday,
        label: l10n.todayStepMeasure,
        icon: Icons.bloodtype_outlined,
        route: '/log/session',
      ),
    ];
    final doneCount = steps.where((s) => s.done).length;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.todayStepsProgress(doneCount),
          style: theme.textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(value: doneCount / steps.length, minHeight: 8),
        const SizedBox(height: 8),
        for (final s in steps)
          ListTile(
            contentPadding: EdgeInsets.zero,
            minTileHeight: 56,
            leading: Icon(
              s.done ? Icons.check_circle : Icons.radio_button_unchecked,
              color: s.done ? theme.colorScheme.primary : null,
            ),
            title: Text(s.label),
            trailing: Icon(s.icon),
            onTap: () => context.push(s.route),
          ),
        if (doneCount == steps.length)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(l10n.todayStepsDone, style: theme.textTheme.bodyMedium),
          ),
      ],
    );
  }
}

class _Step {
  const _Step({
    required this.done,
    required this.label,
    required this.icon,
    required this.route,
  });

  final bool done;
  final String label;
  final IconData icon;
  final String route;
}
