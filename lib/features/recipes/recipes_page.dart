import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/l10n/generated/app_localizations.dart';
import '../../core/database/database.dart';
import '../../core/database/providers.dart';

/// Tarif listesi (T19+T35): seed tarifleri gösterir; dokununca detay
/// sayfasına gider.
class RecipesPage extends ConsumerWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(appDatabaseProvider);
    final l10n = AppLocalizations.of(context)!;
    final isTr = Localizations.localeOf(context).languageCode == 'tr';

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navPlan)),
      body: FutureBuilder<List<RecipeRow>>(
        future: db.select(db.recipe).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final recipes = snapshot.data!;
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: recipes.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final r = recipes[index];
              return ListTile(
                title: Text((isTr ? r.titleTr : r.titleEn) ?? r.titleTr ?? ''),
                subtitle: Text(
                  AppLocalizations.of(context)!
                      .recipePrepMinutes((r.prepMinutes ?? 0).toString()),
                ),
                onTap: () => context.push('/plan/recipes/${r.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
