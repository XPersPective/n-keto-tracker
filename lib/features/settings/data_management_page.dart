import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/l10n/generated/app_localizations.dart';
import '../../core/database/export_import_repository.dart';
import '../../core/database/providers.dart';
import '../../core/units/csv_safety.dart';

/// Veri yönetimi (MASTER_PROMPT §14.3, PB-004): dışa aktar (JSON+CSV,
/// sistem paylaşım sayfasıyla), içe aktar (yapıştırılan JSON, tek
/// transaction), tüm verileri sil (iki onay + kapsam raporu).
class DataManagementPage extends ConsumerStatefulWidget {
  const DataManagementPage({super.key});

  @override
  ConsumerState<DataManagementPage> createState() => _DataManagementPageState();
}

class _DataManagementPageState extends ConsumerState<DataManagementPage> {
  final _importController = TextEditingController();
  String? _message;

  @override
  void dispose() {
    _importController.dispose();
    super.dispose();
  }

  ExportImportRepository _repo() =>
      ExportImportRepository(ref.read(appDatabaseProvider));

  Future<void> _exportJson() async {
    final raw = await _repo().exportJson();
    final dir = await getApplicationDocumentsDirectory();
    final file = File(
      '${dir.path}/n-keto-tracker-export-${DateTime.now().millisecondsSinceEpoch}.json',
    );
    await file.writeAsString(raw, flush: true);
    await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
  }

  Future<void> _exportCsv() async {
    final csv = await _repo().exportMeasurementsCsv();
    final dir = await getApplicationDocumentsDirectory();
    final file = File(
      '${dir.path}/n-keto-tracker-measurements-${DateTime.now().millisecondsSinceEpoch}.csv',
    );
    await file.writeAsString(csv, flush: true);
    await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
  }

  Future<void> _importJson(AppLocalizations l10n) async {
    try {
      final result = await _repo().importJson(_importController.text);
      if (!mounted) return;
      setState(() {
        _message = l10n.dataImportSuccess(
          result.glucoseCount.toString(),
          result.weightCount.toString(),
        );
      });
    } on ImportValidationException {
      if (!mounted) return;
      setState(() => _message = l10n.dataImportInvalid);
    }
  }

  Future<void> _deleteAll(AppLocalizations l10n) async {
    // İkinci onay: yazılı DELETE ile (MASTER §14.3).
    final controller = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.dataDeleteAll),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.dataDeleteConfirm1),
            const SizedBox(height: 12),
            Text(l10n.dataDeleteConfirm2),
            TextField(
              controller: controller,
              decoration: InputDecoration(labelText: l10n.dataDeleteTypeDelete),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.onboardingBack),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(context, controller.text.trim() == 'DELETE'),
            child: Text(l10n.dataDeleteAll),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    final count = await _repo().deleteAllData();
    if (!mounted) return;
    setState(() => _message = l10n.dataDeleteDone(count.toString()));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.dataManagementTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.ios_share),
            title: Text(l10n.dataExportJson),
            onTap: _exportJson,
          ),
          ListTile(
            leading: const Icon(Icons.table_chart_outlined),
            title: Text(l10n.dataExportCsv),
            onTap: _exportCsv,
          ),
          const Divider(height: 32),
          TextField(
            controller: _importController,
            maxLines: 6,
            decoration: InputDecoration(
              labelText: l10n.dataImportLabel,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.tonal(
            onPressed: () => _importJson(l10n),
            child: Text(l10n.dataImportButton),
          ),
          if (_message != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(_message!),
            ),
          const Divider(height: 32),
          ListTile(
            leading: Icon(
              Icons.delete_forever,
              color: Theme.of(context).colorScheme.error,
            ),
            title: Text(l10n.dataDeleteAll),
            onTap: () => _deleteAll(l10n),
          ),
        ],
      ),
    );
  }
}
