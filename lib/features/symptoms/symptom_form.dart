import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/generated/app_localizations.dart';
import '../../core/database/database.dart';
import '../../core/database/providers.dart';
import '../../core/database/symptom_repository.dart';

/// Semptom kayıt formu (MASTER_PROMPT §11.2, T23): yerel düzenlenebilir
/// liste, şiddet 0–10, not. Teşhis YOK — ciddi/yeni belirtide kendi
/// sağlık planı + acil yönlendirme mesajı gösterilir.
class SymptomForm extends ConsumerStatefulWidget {
  const SymptomForm({super.key});

  @override
  ConsumerState<SymptomForm> createState() => _SymptomFormState();
}

class _SymptomFormState extends ConsumerState<SymptomForm> {
  late final SymptomRepository _repo = SymptomRepository(
    ref.read(appDatabaseProvider),
  );
  final _noteController = TextEditingController();
  double _severity = 3;
  String? _selectedId;
  bool _saved = false;
  // Tanımlar tohumlandıktan SONRA yüklenir (FutureBuilder tek future).
  late final Future<List<SymptomDefinitionRow>> _definitions = _load();

  Future<List<SymptomDefinitionRow>> _load() async {
    await _repo.seedDefinitions();
    return _repo.definitions();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isTr = Localizations.localeOf(context).languageCode == 'tr';
    return Scaffold(
      appBar: AppBar(title: Text(l10n.symptomFormTitle)),
      body: FutureBuilder<List<SymptomDefinitionRow>>(
        future: _definitions,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final defs = snapshot.data!;
          final selected = defs
              .where((d) => d.id == (_selectedId ?? defs.first.id))
              .first;
          final guidance = SymptomRepository.needsGuidance(
            definitionId: selected.id,
            severity: _severity.round(),
          );
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              DropdownButtonFormField<SymptomDefinitionRow>(
                initialValue: selected,
                items: defs
                    .map(
                      (d) => DropdownMenuItem(
                        value: d,
                        child: Text(isTr ? d.nameTr : d.nameEn),
                      ),
                    )
                    .toList(),
                onChanged: (d) => setState(() => _selectedId = d?.id),
                decoration: InputDecoration(
                  labelText: l10n.symptomDefinitionLabel,
                ),
              ),
              const SizedBox(height: 12),
              Text(l10n.symptomSeverityLabel(_severity.round().toString())),
              Slider(
                value: _severity,
                min: 0,
                max: 10,
                divisions: 10,
                label: _severity.round().toString(),
                onChanged: (v) => setState(() => _severity = v),
              ),
              TextField(
                controller: _noteController,
                decoration: InputDecoration(labelText: l10n.symptomNoteLabel),
              ),
              const SizedBox(height: 12),
              if (guidance)
                Card(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      selected.id == 'seizure-event'
                          ? l10n.symptomSeizureGuidance
                          : l10n.symptomGuidance,
                    ),
                  ),
                ),
              FilledButton(
                style: FilledButton.styleFrom(minimumSize: const Size(48, 48)),
                onPressed: () async {
                  await _repo.addEntry(
                    symptomDefinitionId: selected.id,
                    severity: _severity.round(),
                    note: _noteController.text.isEmpty
                        ? null
                        : _noteController.text,
                  );
                  if (!mounted) return;
                  setState(() => _saved = true);
                },
                child: Text(l10n.symptomSave),
              ),
              if (_saved)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(l10n.symptomSavedToast),
                ),
            ],
          );
        },
      ),
    );
  }
}
