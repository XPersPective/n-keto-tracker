import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/generated/app_localizations.dart';

/// Rehber kartları: rootBundle'dan bir kez yüklenir; testlerde
/// override edilir (FutureProvider, FutureBuilder'ın FakeAsync
/// asset-önbelleği tuzağını yaşamaz).
final guideCardsProvider =
    FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
      final raw = await rootBundle.loadString('assets/seed/food_guide.json');
      final doc = jsonDecode(raw) as Map<String, dynamic>;
      return (doc['cards'] as List).cast<Map<String, dynamic>>();
    });

/// Gıda rehberi (MASTER_PROMPT §9): üç grup; her kartta Neden? + tipik
/// porsiyon + yaklaşık net karb + veri kaynağı + alternatifler + kanıt
/// etiketi. Ahlaki/korkutucu dil kullanılmaz (içerik lint testi var).
class GuidePage extends ConsumerWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardsAsync = ref.watch(guideCardsProvider);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navGuide)),
      body: cardsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const Center(child: CircularProgressIndicator()),
        data: (cards) {
          final groups = <String, List<Map<String, dynamic>>>{};
          for (final c in cards) {
            groups.putIfAbsent(c['group'] as String, () => []).add(c);
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              for (final group in ['prefer', 'limit', 'avoid']) ...[
                Text(switch (group) {
                  'prefer' => l10n.guideGroupPrefer,
                  'limit' => l10n.guideGroupLimit,
                  _ => l10n.guideGroupAvoid,
                }, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                ...groups[group]!.map((c) => _GuideCard(card: c, l10n: l10n)),
                const SizedBox(height: 16),
              ],
              Text(
                l10n.generalInfoDisclaimer,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _GuideCard extends StatelessWidget {
  const _GuideCard({required this.card, required this.l10n});

  final Map<String, dynamic> card;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final isTr = Localizations.localeOf(context).languageCode == 'tr';
    return Card(
      child: ExpansionTile(
        title: Text(switch (card['id'] as String) {
          'guide-prefer-meat-fish-eggs' => l10n.guideCardMeatFishEggs,
          'guide-prefer-low-carb-vegetables' => l10n.guideCardLowCarbVegetables,
          'guide-prefer-fats-oils' => l10n.guideCardFatsOils,
          'guide-prefer-nuts-seeds' => l10n.guideCardNutsSeeds,
          'guide-prefer-berries' => l10n.guideCardBerries,
          'guide-prefer-dairy-full-fat' => l10n.guideCardDairy,
          'guide-limit-fruit' => l10n.guideCardFruit,
          'guide-limit-legumes' => l10n.guideCardLegumes,
          'guide-limit-milk-drinks' => l10n.guideCardMilkDrinks,
          'guide-avoid-sugary-drinks' => l10n.guideCardSugaryDrinks,
          'guide-avoid-starches' => l10n.guideCardStarches,
          _ => l10n.guideCardSweets,
        }),
        subtitle: Text(
          isTr
              ? (card['evidenceLabelTr'] as String)
              : (card['evidenceLabelEn'] as String),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.guideWhyHeading,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  isTr
                      ? (card['reasonTr'] as String)
                      : (card['reasonEn'] as String),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.guideTypicalPortion(
                    isTr
                        ? (card['portionTr'] as String)
                        : (card['portionEn'] as String),
                    (card['typicalGrams'] as num).toString(),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.guideAlternatives(
                    isTr
                        ? (card['alternativesTr'] as String)
                        : (card['alternativesEn'] as String),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.guideDataSource('USDA FoodData Central'),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
