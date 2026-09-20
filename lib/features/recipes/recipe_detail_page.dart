import 'package:drift/drift.dart' show innerJoin;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/generated/app_localizations.dart';
import '../../core/database/database.dart';
import '../../core/database/providers.dart';

/// Tarif detay sayfası (MASTER_PROMPT §10.1): başlık, adımlar, malzemeler
/// (besin adlarıyla + gram), porsiyon, alerjen ve saklama notu.
/// Yükleme future'ı State'te bir kez oluşturulur (FutureBuilder her
/// build'de yeni future alırsa sonsuz loading döngüsü oluşur).
class RecipeDetailPage extends ConsumerStatefulWidget {
  const RecipeDetailPage({super.key, required this.recipeId});

  final String recipeId;

  @override
  ConsumerState<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends ConsumerState<RecipeDetailPage> {
  late final Future<(RecipeRow, List<(RecipeIngredientRow, FoodRow)>)> _future;

  @override
  void initState() {
    super.initState();
    _future = _load(ref.read(appDatabaseProvider), widget.recipeId);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isTr = Localizations.localeOf(context).languageCode == 'tr';

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navPlan)),
      body: FutureBuilder<(RecipeRow, List<(RecipeIngredientRow, FoodRow)>)>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final (recipe, ingredients) = snapshot.data!;
          final title =
              (isTr ? recipe.titleTr : recipe.titleEn) ??
              recipe.titleTr ??
              recipe.titleEn ??
              '';
          final steps = (isTr ? recipe.stepsTr : recipe.stepsEn) ?? '';
          final storage =
              (isTr ? recipe.storageNoteTr : recipe.storageNoteEn) ?? '';
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(title, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(l10n.recipePerServing(recipe.servings.toString())),
              Text(
                l10n.recipePrepMinutes((recipe.prepMinutes ?? 0).toString()),
              ),
              if (recipe.allergensCsv?.isNotEmpty ?? false)
                Text(l10n.recipeAllergens(recipe.allergensCsv!)),
              const Divider(height: 24),
              Text(
                l10n.recipeIngredientsHeading,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              ...ingredients.map(
                (pair) => ListTile(
                  dense: true,
                  title: Text(
                    (isTr ? pair.$2.nameTr : pair.$2.nameEn) ??
                        pair.$2.canonicalName,
                  ),
                  trailing: Text(
                    l10n.recipeGrams(pair.$1.grams.toStringAsFixed(0)),
                  ),
                ),
              ),
              const Divider(height: 24),
              Text(
                l10n.recipeStepsHeading,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(steps),
              if (storage.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  l10n.recipeStorage(storage),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              const SizedBox(height: 16),
              Text(
                l10n.generalInfoDisclaimer,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          );
        },
      ),
    );
  }

  Future<(RecipeRow, List<(RecipeIngredientRow, FoodRow)>)> _load(
    AppDatabase db,
    String recipeId,
  ) async {
    final recipe = await (db.select(
      db.recipe,
    )..where((t) => t.id.equals(recipeId))).getSingle();
    final rows = await (db.select(db.recipeIngredient).join([
      innerJoin(db.food, db.food.id.equalsExp(db.recipeIngredient.foodId)),
    ])..where(db.recipeIngredient.recipeId.equals(recipeId))).get();
    return (
      recipe,
      rows
          .map((r) => (r.readTable(db.recipeIngredient), r.readTable(db.food)))
          .toList(),
    );
  }
}
