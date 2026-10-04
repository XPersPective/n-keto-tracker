import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/generated/app_localizations.dart';
import '../../app/theme/surfaces.dart';
import '../../core/database/database.dart';
import '../../core/database/plan_repository.dart';
import '../../core/database/providers.dart';
import '../../core/privacy/risk_lock.dart';
import '../../core/units/plan_generator.dart';
import '../../core/units/meal_plan_models.dart';

/// Plan kataloğu (üretici için): assets/seed/recipes.json ->
/// RecipeSummary. Testlerde provider override edilir.
final recipeCatalogProvider = FutureProvider.autoDispose<List<RecipeSummary>>((
  ref,
) async {
  final db = ref.watch(appDatabaseProvider);
  final rows = await db.select(db.recipe).get();
  return rows
      .map(
        (r) => RecipeSummary(
          id: r.id,
          title: r.titleTr ?? r.titleEn ?? r.id,
          category: 'meal',
          allergens: (r.allergensCsv ?? '')
              .split(',')
              .where((a) => a.isNotEmpty)
              .toSet(),
          netCarbPerServingG: 0,
          kcalPerServing: 0,
        ),
      )
      .toList();
});

/// Plan + alışveriş sekmesi (MASTER_PROMPT §5.3, §10.2–10.3, T35):
/// haftalık plan görünümü, deterministik taslak üretme (risk kilidi
/// kontrollü), plandan alışveriş listesi.
class PlanPage extends ConsumerStatefulWidget {
  const PlanPage({super.key});

  @override
  ConsumerState<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends ConsumerState<PlanPage> {
  MealPlanRow? _plan;
  List<MealPlanEntryRow> _entries = [];
  Map<String, String> _recipeTitles = const {};

  Future<void> _load() async {
    final db = ref.read(appDatabaseProvider);
    final plans = await db.select(db.mealPlan).get();
    if (plans.isEmpty) return;
    final latest = plans.last;
    final entries = await (db.select(
      db.mealPlanEntry,
    )..where((e) => e.mealPlanId.equals(latest.id))).get();
    final titles = <String, String>{
      for (final r in await db.select(db.recipe).get())
        r.id: (r.titleTr ?? r.titleEn ?? r.id),
    };
    if (!mounted) return;
    setState(() {
      _plan = latest;
      _entries = entries;
      _recipeTitles = titles;
    });
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _generateDraft(AppLocalizations l10n) async {
    final lock = ref.read(riskLockProvider);
    if (lock.locked) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.planDraftLockedNote)));
      return;
    }
    final recipes = await ref.read(recipeCatalogProvider.future);
    if (recipes.isEmpty) return;
    final plan = PlanGenerator.generate(
      recipes: recipes,
      days: 7,
      mealsPerDay: 2,
    );
    if (plan == null) return;
    final db = ref.read(appDatabaseProvider);
    final today = DateTime.now().toLocal();
    final start = today.subtract(Duration(days: today.weekday - 1));
    final slotMap = <int, String>{
      for (final e in plan.entries) e.slot: e.recipeId,
    };
    await PlanRepository(db).savePlan(
      startDateIso:
          '${start.year}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}',
      plan: plan,
      slotToRecipeId: slotMap,
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(l10n.planCreatedToast)));
    await _load();
  }

  Future<void> _toShoppingList(AppLocalizations l10n) async {
    final plan = _plan;
    if (plan == null) return;
    final repo = PlanRepository(ref.read(appDatabaseProvider));
    final items = await repo.collectIngredients(
      dateStartIso: plan.startDateIso,
      dateEndIso: plan.startDateIso,
    );
    final merged = ShoppingMerger.merge(items);
    await repo.createShoppingList(
      title: plan.name ?? plan.startDateIso,
      merged: merged,
      categoryByFoodId: {},
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(l10n.planCreatedToast)));
  }

  /// Gün gün kartlar: tarih + öğün adı + porsiyon. İç jeton ('slot-0') ve
  /// ham sayı gösterilmez.
  List<Widget> _buildDays(
    BuildContext context,
    AppLocalizations l10n,
    MealPlanRow plan,
  ) {
    final loc = MaterialLocalizations.of(context);
    final start = DateTime.tryParse(plan.startDateIso);
    final byDay = <int, List<MealPlanEntryRow>>{};
    for (final e in _entries) {
      (byDay[e.dayOffset] ??= []).add(e);
    }
    final days = byDay.keys.toList()..sort();
    String slotLabel(String mealType) => switch (mealType) {
      'slot-0' => l10n.mealTypeLunch,
      'slot-1' => l10n.mealTypeDinner,
      _ => l10n.mealTypeSnack,
    };
    String servings(double v) =>
        v == v.roundToDouble() ? v.toInt().toString() : v.toString();
    return [
      for (final d in days)
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: SectionCard(
            title: start == null
                ? l10n.planItemDay((d + 1).toString())
                : '${l10n.planItemDay((d + 1).toString())} · '
                      '${loc.formatMediumDate(start.add(Duration(days: d)))}',
            child: Column(
              children: [
                for (final e
                    in (byDay[d]!
                      ..sort((a, b) => a.mealType.compareTo(b.mealType))))
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.restaurant_outlined),
                    // Tarif başlığı okunur etiket; eksikse kısa id (PB-011).
                    title: Text(_recipeTitles[e.recipeId] ?? e.recipeId ?? ''),
                    subtitle: Text(
                      '${slotLabel(e.mealType)} · '
                      '${l10n.recipePerServing(servings(e.servings))}',
                    ),
                  ),
              ],
            ),
          ),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final plan = _plan;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.planTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            tooltip: l10n.planToShopping,
            // Yalnızca plan varken etkin.
            onPressed: _plan == null ? null : () => _toShoppingList(l10n),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FilledButton.icon(
            icon: const Icon(Icons.auto_awesome),
            label: Text(l10n.planGenerateDraft),
            onPressed: () => _generateDraft(l10n),
          ),
          const SizedBox(height: 12),
          if (plan == null)
            Text(l10n.planEmpty)
          else
            ..._buildDays(context, l10n, plan),
        ],
      ),
    );
  }
}
