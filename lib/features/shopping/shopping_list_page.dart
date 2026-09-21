import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/generated/app_localizations.dart';
import '../../core/database/database.dart';
import '../../core/database/providers.dart';

/// Alışveriş listesi görünümü (MASTER §10.3): madde işaretle + manuel ekle.
class ShoppingListPage extends ConsumerStatefulWidget {
  const ShoppingListPage({super.key, this.listId});

  /// Boşsa en son liste gösterilir (en kolay test/UI yolu).
  final int? listId;

  @override
  ConsumerState<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends ConsumerState<ShoppingListPage> {
  List<ShoppingListItemRow> _items = [];

  Future<void> _load() async {
    final db = ref.read(appDatabaseProvider);
    final effectiveId = widget.listId ?? await _latestListId(db);
    if (effectiveId == null) {
      if (mounted) setState(() => _items = []);
      return;
    }
    final rows = await (db.select(
      db.shoppingListItem,
    )..where((i) => i.shoppingListId.equals(effectiveId))).get();
    if (!mounted) return;
    setState(() => _items = rows);
  }

  Future<int?> _latestListId(AppDatabase db) async {
    final lists = await db.select(db.shoppingList).get();
    return lists.isEmpty ? null : lists.last.id;
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _toggle(
    AppLocalizations l10n,
    ShoppingListItemRow item,
    bool? checked,
  ) async {
    final db = ref.read(appDatabaseProvider);
    await (db.update(db.shoppingListItem)..where((i) => i.id.equals(item.id)))
        .write(ShoppingListItemCompanion(isChecked: Value(checked ?? false)));
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.shoppingTitle)),
      body: _items.isEmpty
          ? Center(child: Text(l10n.shoppingEmpty))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return CheckboxListTile(
                  title: Text(item.label ?? item.foodId ?? ''),
                  subtitle: item.quantityGrams != null
                      ? Text('${item.quantityGrams!.toStringAsFixed(0)} g')
                      : null,
                  value: item.isChecked,
                  onChanged: (v) => _toggle(l10n, item, v),
                );
              },
            ),
    );
  }
}
