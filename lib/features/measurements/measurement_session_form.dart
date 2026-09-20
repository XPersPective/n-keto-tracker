import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/generated/app_localizations.dart';
import '../../core/database/measurements_repository.dart';
import '../../core/database/providers.dart';
import '../../core/units/gki.dart';
import '../../core/units/glucose.dart';

/// Sağlayanların kaydı: testler override eder.
final measurementsRepositoryProvider = Provider<MeasurementsRepository>(
  (ref) => MeasurementsRepository(ref.watch(appDatabaseProvider)),
);

/// Kaynak türleri (MASTER_PROMPT §6.1).
const glucoseSourceTypes = ['fingerstick', 'lab', 'cgm_manual', 'other'];

/// Birleşik ölçüm oturumu formu (MASTER_PROMPT §6.3): glukoz (mg/dL veya
/// mmol/L) + kan BHB (mmol/L) birlikte girilir; kaydet = kullanıcı onayı.
/// Kayıttan sonra GKI kartı formülü ve iki ölçümün saatini gösterir.
class MeasurementSessionForm extends ConsumerStatefulWidget {
  const MeasurementSessionForm({super.key});

  @override
  ConsumerState<MeasurementSessionForm> createState() =>
      _MeasurementSessionFormState();
}

class _MeasurementSessionFormState
    extends ConsumerState<MeasurementSessionForm> {
  final _glucoseController = TextEditingController();
  final _bhbController = TextEditingController();
  final _noteController = TextEditingController();
  GlucoseUnit _unit = GlucoseUnit.mgDl;
  String _sourceType = 'fingerstick';
  DateTime _at = DateTime.now();
  String? _errorKey;

  @override
  void dispose() {
    _glucoseController.dispose();
    _bhbController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _at,
      firstDate: _at.subtract(const Duration(days: 365)),
      lastDate: _at.add(const Duration(days: 1)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_at),
    );
    if (time == null || !mounted) return;
    setState(() {
      _at = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  Future<void> _save(AppLocalizations l10n) async {
    setState(() => _errorKey = null);
    final repo = ref.read(measurementsRepositoryProvider);
    try {
      final g = GlucoseValue.fromRaw(
        parseDecimal(_glucoseController.text),
        _unit,
      );
      final bhb = parseDecimal(_bhbController.text);
      final atUtc = _at.toUtc();
      final offset = _at.timeZoneOffset.inMinutes;
      await repo.createSession(
        glucose: g,
        glucoseAtUtc: atUtc,
        glucoseOffsetMinutes: offset,
        glucoseSourceType: _sourceType,
        bhbMmolL: bhb,
        ketoneAtUtc: atUtc,
        ketoneOffsetMinutes: offset,
        matchKind: 'simultaneous',
        confirmedByUser: true, // 'Kaydet' dokunuşu = kullanıcı onayı
        note: _noteController.text.isEmpty ? null : _noteController.text,
      );
      if (!mounted) return;
      final result = GkiEngine.fromRaw(glucose: g, bhbMmolL: bhb);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.generalInfoDisclaimer)));
      setState(() => _savedGki = result);
    } on GlucoseValidationError {
      setState(() => _errorKey = 'invalidValue');
    } on GkiValidationError {
      setState(() => _errorKey = 'invalidBhb');
    }
  }

  GkiResult? _savedGki;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SegmentedButton<GlucoseUnit>(
            segments: const [
              ButtonSegment(value: GlucoseUnit.mgDl, label: Text('mg/dL')),
              ButtonSegment(value: GlucoseUnit.mmolL, label: Text('mmol/L')),
            ],
            selected: {_unit},
            onSelectionChanged: (s) => setState(() => _unit = s.first),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _glucoseController,
            decoration: InputDecoration(
              labelText: l10n.formGlucoseLabel(
                _unit == GlucoseUnit.mgDl ? 'mg/dL' : 'mmol/L',
              ),
              errorText: _errorKey == 'invalidValue'
                  ? l10n.formInvalidValue
                  : null,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _bhbController,
            decoration: InputDecoration(
              labelText: l10n.formBhbLabel,
              errorText: _errorKey == 'invalidBhb'
                  ? l10n.formInvalidValue
                  : null,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _sourceType,
            items: glucoseSourceTypes
                .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                .toList(),
            onChanged: (v) => setState(() => _sourceType = v ?? _sourceType),
            decoration: InputDecoration(labelText: l10n.formSourceType),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _noteController,
            decoration: InputDecoration(labelText: l10n.formNote),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            style: OutlinedButton.styleFrom(minimumSize: const Size(48, 48)),
            onPressed: _pickTime,
            child: Text(l10n.formPickTime),
          ),
          const SizedBox(height: 16),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(48, 48)),
            onPressed: () => _save(l10n),
            child: Text(l10n.formSaveSession),
          ),
          if (_savedGki != null) ...[
            const SizedBox(height: 24),
            // Hesap kartı: formül + iki ölçüm saati (MASTER §6.2).
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.gkiResultHeading,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.gkiResultValue(_savedGki!.value.toStringAsFixed(1)),
                    ),
                    Text(
                      l10n.gkiFormula(
                        _savedGki!.glucoseMmolL.toStringAsFixed(1),
                        _savedGki!.bhbMmolL.toStringAsFixed(1),
                      ),
                    ),
                    Text(
                      l10n.gkiMeasurements(
                        MaterialLocalizations.of(context).formatFullDate(_at),
                      ),
                    ),
                    Text(l10n.gkiFormulaVersion(_savedGki!.formulaVersion)),
                    const SizedBox(height: 8),
                    Text(
                      l10n.generalInfoDisclaimer,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
