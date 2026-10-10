import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/generated/app_localizations.dart';
import '../../app/theme/surfaces.dart';
import '../../core/database/database.dart';
import '../../core/units/walking_plan.dart';
import 'walking_plan_view_model.dart';

/// Kişiye uygun 8 haftalık yürüyüş planı sayfası (MASTER §4.8).
/// Onboarding'den alınan profile göre hesaplar; kanıt referanslarını
/// listeler; günlük dakikaları kart şeklinde gösterir.
class WalkingPlanPage extends ConsumerWidget {
  const WalkingPlanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final plan = ref.watch(walkingPlanProvider);
    final evidence = ref.watch(walkingEvidenceProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navWalking)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profil özeti
          HeroCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.walkingPersonalizedForYou,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.walkingIntensityLabel(plan.intensity),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(l10n.walkingStartMinutesLabel(plan.startMinutes)),
                Text(l10n.walkingWeeklyTargetLabel(plan.weeklyTargetMinutes)),
                if (plan.bmi.isFinite)
                  Text(l10n.walkingBmiLabel(plan.bmi.toStringAsFixed(1))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Haftalık tablo
          for (var w = 1; w <= 8; w++) ...[
            SectionCard(
              title: l10n.walkingWeekTitle(w),
              child: Row(
                children: [
                  for (var d = 1; d <= 7; d++)
                    Expanded(
                      child: _DayCell(
                        day: d,
                        minutes: plan.days
                            .firstWhere(
                              (e) => e.week == w && e.day == d,
                              orElse: () =>
                                  WalkingDay(week: w, day: d, minutes: 0),
                            )
                            .minutes,
                        l10n: l10n,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 16),
          // Kanıt referansları
          SectionCard(
            title: l10n.walkingReferencesTitle,
            child: evidence.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(8),
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              ),
              error: (e, _) => Text(e.toString()),
              data: (rows) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final EvidenceSourceRow r in rows) ...[
                    Text(
                      r.titleTr,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      '${r.authorsCsv} • ${r.journal} (${r.year})',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                  ],
                  Text(l10n.walkingReferencesHint),
                ],
              ),
            ),
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

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.minutes,
    required this.l10n,
  });

  final int day;
  final int minutes;
  final AppLocalizations l10n;

  // Pzt=1 .. Paz=7 — MaterialLocalizations'tan lokalize kısa etiketler.
  // narrowWeekdays: Pzt=index 0, ..., Paz=index 6.
  static String _label(BuildContext context, int day) {
    final ml = MaterialLocalizations.of(context);
    final list = ml.narrowWeekdays;
    if (list.length == 7) return list[day - 1];
    return const ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'][day - 1];
  }

  @override
  Widget build(BuildContext context) {
    final isRest = minutes == 0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        children: [
          Text(
            _label(context, day),
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: 4),
          Container(
            height: 36,
            decoration: BoxDecoration(
              color: isRest
                  ? Theme.of(context).colorScheme.surfaceContainerHighest
                  : Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              isRest ? '–' : '$minutes',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
