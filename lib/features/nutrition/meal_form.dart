import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/generated/app_localizations.dart';
import '../../core/database/database.dart';
import '../../core/database/meal_repository.dart';
import '../../core/database/providers.dart';
import '../dashboard/today_view_model.dart';

/// Öğün kayıt sağlayıcıları (test override'ı için).
final mealRepositoryProvider = Provider<MealRepository>(
  (ref) => MealRepository(ref.watch(appDatabaseProvider)),
);

/// Besin arama (yerel, TR/EN).
Future<List<FoodRow>> searchFoods(WidgetRef ref, String query) =>
    ref.read(mealRepositoryProvider).searchFoods(query);

/// Öğün kayıt formu (MASTER_PROMPT §8.2): besin arama, porsiyon/gram,
/// öğün türü, çoklu besin, saat, not, favori + hızlı tekrar.
class MealForm extends ConsumerStatefulWidget {
  const MealForm({super.key});

  @override
  ConsumerState<MealForm> createState() => _MealFormState();
}

class _DraftItem {
  _DraftItem({required this.food, required this.grams});

  final FoodRow food;
  double grams;
}

class _MealFormState extends ConsumerState<MealForm> {
  final _searchController = TextEditingController();
  final _noteController = TextEditingController();
  String _mealType = 'breakfast';
  final DateTime _at = DateTime.now();
  bool _favorite = false;
  List<FoodRow> _results = [];
  final List<_DraftItem> _items = [];
  String? _errorKey;
  List<MealRow> _recents = [];
  List<MealRow> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadQuickRepeat();
  }

  Future<void> _loadQuickRepeat() async {
    final candidates = await ref
        .read(mealRepositoryProvider)
        .quickRepeatCandidates();
    if (!mounted) return;
    setState(() {
      _recents = candidates.recent;
      _favorites = candidates.favorites;
    });
  }

  Future<void> _search(String query) async {
    final results = await ref.read(mealRepositoryProvider).searchFoods(query);
    if (!mounted) return;
    setState(() => _results = results);
  }

  Future<void> _save(AppLocalizations l10n) async {
    setState(() => _errorKey = null);
    if (_items.isEmpty) {
      setState(() => _errorKey = 'needsItem');
      return;
    }
    final offset = _at.timeZoneOffset.inMinutes;
    await ref
        .read(mealRepositoryProvider)
        .createMeal(
          mealType: _mealType,
          eatenAtUtc: _at.toUtc(),
          localOffsetMinutes: offset,
          note: _noteController.text.isEmpty ? null : _noteController.text,
          isFavorite: _favorite,
          items: _items
              .map((i) => MealItemInput(foodId: i.food.id, grams: i.grams))
              .toList(),
        );
    if (!mounted) return;
    // Bugün ekranı önbelleğini tazele (PB-021).
    ref.invalidate(todayMealsProvider);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(l10n.mealSavedToast)));
    Navigator.of(context).pop();
  }

  void _repeat(MealRow meal) {
    // Tekrar kaydı: repository kopyalar; form öğelerini göstermek için
    // basitçe kaydı hemen yapar (hızlı tekrar, MASTER §8.2).
    final l10n = AppLocalizations.of(context)!;
    final offset = DateTime.now().timeZoneOffset.inMinutes;
    ref
        .read(mealRepositoryProvider)
        .repeatMeal(
          sourceMealId: meal.id,
          eatenAtUtc: DateTime.now().toUtc(),
          localOffsetMinutes: offset,
        )
        .then((_) {
          if (!mounted) return;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(l10n.mealSavedToast)));
        });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    String typeLabel(String t) => switch (t) {
      'breakfast' => l10n.mealTypeBreakfast,
      'lunch' => l10n.mealTypeLunch,
      'dinner' => l10n.mealTypeDinner,
      'snack' => l10n.mealTypeSnack,
      _ => l10n.mealTypeCustom,
    };

    return Scaffold(
      appBar: AppBar(title: Text(l10n.mealFormTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SegmentedButton<String>(
            segments: MealRepository.mealTypes
                .map((t) => ButtonSegment(value: t, label: Text(typeLabel(t))))
                .toList(),
            selected: {_mealType},
            onSelectionChanged: (s) => setState(() => _mealType = s.first),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(labelText: l10n.mealSearchLabel),
            onChanged: _search,
          ),
          ..._results.map(
            (f) => ListTile(
              title: Text(f.nameTr ?? f.canonicalName),
              subtitle: Text(
                '${f.kcalPer100g.toStringAsFixed(0)} kcal · '
                'net ${f.netCarbGPer100g.toStringAsFixed(1)} g/100 g',
              ),
              trailing: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => setState(() {
                  _items.add(_DraftItem(food: f, grams: 100));
                  _results = [];
                  _searchController.clear();
                }),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.mealItemsHeading,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ..._items.asMap().entries.map(
            (e) => ListTile(
              title: Text(e.value.food.nameTr ?? e.value.food.canonicalName),
              trailing: SizedBox(
                width: 110,
                child: TextField(
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(labelText: l10n.mealGramsLabel),
                  controller: TextEditingController(
                    text: e.value.grams.toStringAsFixed(0),
                  ),
                  onChanged: (v) {
                    final g = double.tryParse(v.replaceAll(',', '.'));
                    if (g != null) setState(() => e.value.grams = g);
                  },
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () => setState(() => _items.removeAt(e.key)),
              ),
            ),
          ),
          if (_errorKey == 'needsItem')
            Text(
              l10n.mealNeedsItem,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          const SizedBox(height: 12),
          TextField(
            controller: _noteController,
            decoration: InputDecoration(labelText: l10n.mealNoteLabel),
          ),
          CheckboxListTile(
            title: Text(l10n.mealFavoriteToggle),
            value: _favorite,
            onChanged: (v) => setState(() => _favorite = v ?? false),
          ),
          const SizedBox(height: 12),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(48, 48)),
            onPressed: () => _save(l10n),
            child: Text(l10n.mealSave),
          ),
          if (_recents.isNotEmpty || _favorites.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text(
              l10n.mealRepeatSection,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (_favorites.isNotEmpty) ...[
              Text(l10n.mealRepeatFavorites),
              ..._favorites.map(
                (m) => ListTile(
                  leading: const Icon(Icons.star),
                  title: Text(m.customName ?? typeLabel(m.mealType)),
                  onTap: () => _repeat(m),
                ),
              ),
            ],
            if (_recents.isNotEmpty) ...[
              Text(l10n.mealRepeatRecent),
              ..._recents.map(
                (m) => ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(m.customName ?? typeLabel(m.mealType)),
                  onTap: () => _repeat(m),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
