import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/generated/app_localizations.dart';
import '../../core/database/activity_repository.dart';
import 'activity_view_model.dart';

/// Hareket kayıt formu: tür, süre (dk), isteğe bağlı mesafe (km) ve not.
/// Konum/GPS kullanılmaz; her şey elle girilir (C-001).
class ActivityForm extends ConsumerStatefulWidget {
  const ActivityForm({super.key});

  @override
  ConsumerState<ActivityForm> createState() => _ActivityFormState();
}

class _ActivityFormState extends ConsumerState<ActivityForm> {
  final _minutesController = TextEditingController();
  final _distanceController = TextEditingController();
  final _noteController = TextEditingController();
  String _kind = 'walk';
  String? _error;

  @override
  void dispose() {
    _minutesController.dispose();
    _distanceController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _save(AppLocalizations l10n) async {
    final minutes = int.tryParse(_minutesController.text.trim());
    if (minutes == null || minutes < 1 || minutes > 600) {
      setState(() => _error = l10n.activityInvalidMinutes);
      return;
    }
    final distanceText = _distanceController.text.trim().replaceAll(',', '.');
    final distance = distanceText.isEmpty
        ? null
        : double.tryParse(distanceText);
    if (distanceText.isNotEmpty && (distance == null || distance <= 0)) {
      setState(() => _error = l10n.formInvalidValue);
      return;
    }
    await ref
        .read(activityRepositoryProvider)
        .add(
          kind: _kind,
          durationMinutes: minutes,
          distanceKm: distance,
          note: _noteController.text.trim(),
        );
    if (!mounted) return;
    ref.invalidate(todayActivityProvider);
    ref.invalidate(weekActivityProvider);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(l10n.activitySavedToast)));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.activityFormTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SegmentedButton<String>(
            segments: [
              for (final kind in ActivityRepository.kinds)
                ButtonSegment(
                  value: kind,
                  label: Text(activityKindLabel(l10n, kind)),
                  icon: Icon(activityKindIcon(kind)),
                ),
            ],
            selected: {_kind},
            onSelectionChanged: (s) => setState(() => _kind = s.first),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _minutesController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: l10n.activityDurationLabel,
              errorText: _error,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _distanceController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: l10n.activityDistanceLabel),
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
            child: Text(l10n.activitySave),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.activityDisclaimer,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
