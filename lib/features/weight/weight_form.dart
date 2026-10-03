import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/generated/app_localizations.dart';
import '../../core/database/database.dart';
import '../../core/database/providers.dart';
import '../../core/units/weight.dart';
import '../measurements/log_view_model.dart';

/// Ağırlık kayıt formu (MASTER_PROMPT §11.1, T22): kg/lb giriş (normalize
/// kg saklanır), tarih-saat, not, ölçüm koşulu. Rozet/seri/kilo baskısı
/// YOK; sade kayıt.
class WeightForm extends ConsumerStatefulWidget {
  const WeightForm({super.key});

  @override
  ConsumerState<WeightForm> createState() => _WeightFormState();
}

class _WeightFormState extends ConsumerState<WeightForm> {
  final _valueController = TextEditingController();
  final _noteController = TextEditingController();
  final _conditionController = TextEditingController();
  String _unit = 'kg';
  final DateTime _at = DateTime.now();
  String? _error;

  @override
  void dispose() {
    _valueController.dispose();
    _noteController.dispose();
    _conditionController.dispose();
    super.dispose();
  }

  Future<void> _save(AppLocalizations l10n) async {
    final value = double.tryParse(
      _valueController.text.trim().replaceAll(',', '.'),
    );
    if (value == null || value <= 0) {
      setState(() => _error = l10n.formInvalidValue);
      return;
    }
    final w = WeightValue.fromRaw(value, _unit);
    final db = ref.read(appDatabaseProvider);
    await db
        .into(db.weightEntry)
        .insert(
          WeightEntryCompanion.insert(
            rawValue: w.rawValue,
            rawUnit: w.unit,
            kg: w.kg,
            measuredAtUtc: _at.toUtc(),
            localOffsetMinutes: _at.timeZoneOffset.inMinutes,
            conditionNote: Value(
              _conditionController.text.isEmpty
                  ? null
                  : _conditionController.text,
            ),
            note: Value(
              _noteController.text.isEmpty ? null : _noteController.text,
            ),
          ),
        );
    if (!mounted) return;
    // Ağırlık serisi önbelleğini tazele (IndexedStack sekme canlılığı,
    // PB-010).
    ref.invalidate(weightSeriesProvider);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.todayAddWeight)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'kg', label: Text('kg')),
              ButtonSegment(value: 'lb', label: Text('lb')),
            ],
            selected: {_unit},
            onSelectionChanged: (s) => setState(() => _unit = s.first),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _valueController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.weightValueLabel(_unit),
              errorText: _error,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _conditionController,
            decoration: InputDecoration(labelText: l10n.weightConditionLabel),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _noteController,
            decoration: InputDecoration(labelText: l10n.formNote),
          ),
          const SizedBox(height: 16),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(48, 48)),
            onPressed: () => _save(l10n),
            child: Text(l10n.weightSave),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.generalInfoDisclaimer,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
