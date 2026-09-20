/// Plan üretici ve alışveriş birleştirme modelleri (T20).
library;

/// Üreticiye giren tarif özeti (DB bağımsız saf model).
class RecipeSummary {
  const RecipeSummary({
    required this.id,
    required this.title,
    required this.category,
    required this.allergens,
    required this.netCarbPerServingG,
    required this.kcalPerServing,
  });

  final String id;
  final String title;
  final String category;
  final Set<String> allergens;
  final double netCarbPerServingG;
  final double kcalPerServing;
}

/// Üretilen plan girdisi.
class PlanEntryDraft {
  const PlanEntryDraft({
    required this.dayOffset,
    required this.slot,
    required this.recipeId,
    required this.servings,
  });

  final int dayOffset; // 0..6
  final int slot; // gün içinde sıra
  final String recipeId;
  final double servings;
}

/// Üretilen plan.
class GeneratedPlan {
  const GeneratedPlan({required this.days, required this.entries});

  final int days;
  final List<PlanEntryDraft> entries;
}

/// Alışveriş maddesi birleştirme girdisi.
class ShoppingInputItem {
  const ShoppingInputItem({
    required this.foodId,
    required this.grams,
    this.unitLabel,
    this.display,
  });

  final String foodId;
  final double grams;

  /// Uyumlu olmayan birim (adet/dilim gibi) gram'a çevrilemez; ayrı satır
  /// olarak taşınır (MASTER §10.3).
  final String? unitLabel;
  final String? display;
}

/// Birleştirilmiş alışveriş satırı.
class MergedShoppingItem {
  const MergedShoppingItem({
    required this.foodId,
    required this.grams,
    this.unitLabel,
  });

  final String foodId;
  final double grams;
  final String? unitLabel;
}

/// Alışveriş birleştirme (MASTER_PROMPT §10.3): aynı besin gram bazında
/// toplanır; birimi gram olmayan (adet/dilim) satırlar besin+birim
/// başına ayrı toplanır. Manuel maddeler merge dışıdır (repository
/// korur).
abstract final class ShoppingMerger {
  static List<MergedShoppingItem> merge(Iterable<ShoppingInputItem> items) {
    final gramTotals = <String, double>{};
    final unitTotals = <String, double>{};
    for (final item in items) {
      if (item.unitLabel == null) {
        gramTotals[item.foodId] = (gramTotals[item.foodId] ?? 0) + item.grams;
      } else {
        final key = '${item.foodId}::${item.unitLabel}';
        unitTotals[key] = (unitTotals[key] ?? 0) + 1;
      }
    }
    final merged = <MergedShoppingItem>[
      for (final e in gramTotals.entries)
        MergedShoppingItem(foodId: e.key, grams: e.value),
      for (final e in unitTotals.entries)
        MergedShoppingItem(
          foodId: e.key.split('::').first,
          grams: e.value,
          unitLabel: e.key.split('::')[1],
        ),
    ]..sort((a, b) => a.foodId.compareTo(b.foodId));
    return merged;
  }
}
