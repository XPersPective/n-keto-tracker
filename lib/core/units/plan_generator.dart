import 'meal_plan_models.dart';

/// Deterministik haftalık plan taslağı üretici (MASTER_PROMPT §10.2, T20).
///
/// - Tamamen yerel ve deterministiktir: aynı girdi → birebir aynı çıktı
///   (rastgelelik yok; tarif sırası id'ye göre sabittir).
/// - Filtreler: alerjen hariç tutma, hariç tutulan kategoriler, günlük
///   öğün sayısı. Kullanıcının kayıtlı kişisel/uzman hedefleri UI'da
///   bilgi olarak sunulur; üretici KENDİSİ enerji açığı, fasting
///   penceresi veya terapötik oran ÜRETMEZ.
/// - Uygun tarif yoksa kural gevşetilmez: [generate] null döner ve UI
///   dürüstçe "uygun plan oluşturulamadı" gösterir.
abstract final class PlanGenerator {
  static const int maxDays = 7;

  static List<RecipeSummary> _sorted(Iterable<RecipeSummary> recipes) =>
      recipes.toList()..sort((a, b) => a.id.compareTo(b.id));

  /// Uygun planı üretir; uygun tarif yoksa null.
  static GeneratedPlan? generate({
    required Iterable<RecipeSummary> recipes,
    required int days,
    required int mealsPerDay,
    Set<String> excludeAllergens = const {},
    Set<String> excludeCategories = const {},
  }) {
    assert(days >= 1 && days <= maxDays, '1–7 gün');
    assert(mealsPerDay >= 1 && mealsPerDay <= 3);

    final eligible = _sorted(recipes).where((r) {
      final allergens = r.allergens.map((a) => a.toLowerCase()).toSet();
      if (allergens.intersection(excludeAllergens).isNotEmpty) return false;
      if (excludeCategories.contains(r.category)) return false;
      return true;
    }).toList();
    if (eligible.length < mealsPerDay) return null; // yeterli tarif yok

    final entries = <PlanEntryDraft>[];
    var index = 0;
    var day = 0;
    while (day < days) {
      for (var slot = 0; slot < mealsPerDay; slot++) {
        final recipe = eligible[index % eligible.length];
        entries.add(
          PlanEntryDraft(
            dayOffset: day,
            slot: slot,
            recipeId: recipe.id,
            servings: 1,
          ),
        );
        index++;
      }
      day++;
    }
    return GeneratedPlan(days: days, entries: entries);
  }
}
