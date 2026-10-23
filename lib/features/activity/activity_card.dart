import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/l10n/generated/app_localizations.dart';
import '../../core/database/database.dart';
import '../../core/units/activity_load.dart';
import 'activity_view_model.dart';

/// Bugün ekranındaki hareket kartı: bugünkü kayıtlar, son 7 gün ilerlemesi
/// (DSÖ 150 dk hedefi) ve tek dokunuşla yeni kayıt.
class ActivityCard extends ConsumerWidget {
  const ActivityCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final today = ref.watch(todayActivityProvider);
    final week = ref.watch(weekActivityProvider);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        week.when(
          loading: () => const LinearProgressIndicator(),
          error: (_, _) => const SizedBox.shrink(),
          data: (rows) {
            final minutes = totalAerobicMinutes(
              rows.map(
                (r) => (kind: r.kind, durationMinutes: r.durationMinutes),
              ),
            );
            final progress = (minutes / weeklyAerobicTargetMinutes).clamp(
              0.0,
              1.0,
            );
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.activityWeekProgress(
                    minutes,
                    weeklyAerobicTargetMinutes,
                  ),
                  style: theme.textTheme.titleSmall,
                ),
                const SizedBox(height: 6),
                LinearProgressIndicator(value: progress, minHeight: 8),
                const SizedBox(height: 6),
                Text(l10n.activityWeekNote, style: theme.textTheme.bodySmall),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        today.when(
          loading: () => const SizedBox.shrink(),
          error: (_, _) => Text(l10n.todayActivityEmpty),
          data: (rows) {
            if (rows.isEmpty) {
              return Text(
                l10n.todayActivityEmpty,
                style: theme.textTheme.bodyMedium,
              );
            }
            return Column(
              children: [
                for (final r in rows)
                  _ActivityRow(row: r, onDeleted: () => _refresh(ref)),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          style: FilledButton.styleFrom(minimumSize: const Size(48, 56)),
          onPressed: () => context.push('/activity/timer'),
          icon: const Icon(Icons.timer_outlined),
          label: Text(l10n.timerOpen),
        ),
        TextButton(
          style: TextButton.styleFrom(minimumSize: const Size(48, 48)),
          onPressed: () => context.push('/activity/new'),
          child: Text(l10n.activityAddButton),
        ),
      ],
    );
  }

  void _refresh(WidgetRef ref) {
    ref.invalidate(todayActivityProvider);
    ref.invalidate(weekActivityProvider);
  }
}

class _ActivityRow extends ConsumerWidget {
  const _ActivityRow({required this.row, required this.onDeleted});

  final ActivitySessionRow row;
  final VoidCallback onDeleted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final distance = row.distanceKm;
    final detail = distance == null
        ? l10n.activityMinutes(row.durationMinutes)
        : l10n.activityRowWithDistance(
            row.durationMinutes,
            _formatKm(distance),
          );
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minTileHeight: 48,
      leading: Icon(activityKindIcon(row.kind)),
      title: Text(activityKindLabel(l10n, row.kind)),
      subtitle: Text(detail),
      trailing: IconButton(
        tooltip: l10n.activityDeleteTooltip,
        icon: const Icon(Icons.delete_outline),
        onPressed: () async {
          await ref.read(activityRepositoryProvider).delete(row.id);
          onDeleted();
        },
      ),
    );
  }

  /// 5 → "5", 5.25 → "5.3" (tek ondalık).
  static String _formatKm(double km) =>
      km == km.roundToDouble() ? km.toStringAsFixed(0) : km.toStringAsFixed(1);
}
