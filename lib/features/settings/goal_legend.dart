import 'package:flutter/material.dart';

import '../../app/l10n/generated/app_localizations.dart';

/// Üç hedef türünün grafik lejantı (MASTER_PROMPT §6.5, AC9):
/// türler asla birleşmez; günlük dilde ayrı etiket/renk/desen.
///
/// Etiketler: "Araştırmada kullanılan bölge" (kaynaklı, salt okunur),
/// "Uzmanımın hedefi" (kullanıcı girer, kim/ne zaman alanlı),
/// "Kişisel takip hedefim" (tıbbi değildir).
class GoalLegend extends StatelessWidget {
  const GoalLegend({super.key, this.visibleTypes = const {}});

  /// Hangi türlerin kayıtlı olduğu (yalnız onlar gösterilir).
  /// researchReference | clinicianTarget | personalTrackingGoal
  final Set<String> visibleTypes;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final entries = <(String, String, Color)>[
      ('researchReference', l10n.goalLegendResearch, scheme.tertiaryContainer),
      ('clinicianTarget', l10n.goalLegendClinician, scheme.secondaryContainer),
      (
        'personalTrackingGoal',
        l10n.goalLegendPersonal,
        scheme.surfaceContainerHighest,
      ),
    ];
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: [
        for (final (type, label, color) in entries)
          if (visibleTypes.isEmpty || visibleTypes.contains(type))
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: color,
                    // Renk tek başına anlam taşımaz: tür simgesi var (§12).
                    border: Border.all(color: scheme.outline),
                    shape: type == 'clinicianTarget'
                        ? BoxShape.circle
                        : BoxShape.rectangle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(label, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
      ],
    );
  }
}
