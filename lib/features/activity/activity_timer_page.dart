import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/generated/app_localizations.dart';
import '../../core/database/activity_repository.dart';
import 'activity_view_model.dart';

/// Hareket zamanlayıcısı: tür seç, başlat, duraklat, bitir. Süre otomatik
/// kaydedilir; konum kullanılmaz (C-001). En az 1 dakika kaydedilir.
class ActivityTimerPage extends ConsumerStatefulWidget {
  const ActivityTimerPage({super.key, this.clock});

  /// Testlerde sahte saat; üretimde null (gerçek saat).
  final DateTime Function()? clock;

  @override
  ConsumerState<ActivityTimerPage> createState() => _ActivityTimerPageState();
}

class _ActivityTimerPageState extends ConsumerState<ActivityTimerPage> {
  final _distanceController = TextEditingController();
  Timer? _ticker;
  DateTime? _startedAt;
  // Duraklatma süresi hariç biriken süre.
  Duration _accumulated = Duration.zero;
  DateTime? _runningSince;
  String _kind = 'walk';
  bool _saving = false;

  bool get _running => _runningSince != null;

  DateTime _now() => widget.clock?.call() ?? DateTime.now();

  Duration get _elapsed {
    final live = _runningSince == null
        ? Duration.zero
        : _now().difference(_runningSince!);
    return _accumulated + live;
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _distanceController.dispose();
    super.dispose();
  }

  void _start() {
    _startedAt ??= _now();
    _runningSince = _now();
    _ticker ??= Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
    setState(() {});
  }

  void _pause() {
    if (_runningSince != null) {
      _accumulated += _now().difference(_runningSince!);
    }
    _runningSince = null;
    setState(() {});
  }

  Future<void> _finish(AppLocalizations l10n) async {
    if (_saving) return;
    _pause();
    final seconds = _elapsed.inSeconds;
    if (seconds < 1) return;
    final minutes = (seconds / 60).ceil().clamp(1, 600);
    final distanceText = _distanceController.text.trim().replaceAll(',', '.');
    final distance = distanceText.isEmpty
        ? null
        : double.tryParse(distanceText);
    setState(() => _saving = true);
    await ref
        .read(activityRepositoryProvider)
        .add(
          kind: _kind,
          durationMinutes: minutes,
          at: _startedAt ?? _now(),
          distanceKm: distance != null && distance > 0 ? distance : null,
        );
    if (!mounted) return;
    ref.invalidate(todayActivityProvider);
    ref.invalidate(weekActivityProvider);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(l10n.activitySavedToast)));
    Navigator.of(context).pop();
  }

  static String _format(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    return h > 0 ? '$h:${two(m)}:${two(s)}' : '${two(m)}:${two(s)}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final elapsed = _elapsed;
    final hasTime = elapsed.inSeconds > 0;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.timerTitle)),
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
            onSelectionChanged: _running
                ? null
                : (s) => setState(() => _kind = s.first),
          ),
          const SizedBox(height: 24),
          Center(
            child: Semantics(
              liveRegion: true,
              label: _format(elapsed),
              child: Text(
                _format(elapsed),
                style: theme.textTheme.displayLarge?.copyWith(
                  fontFeatures: const [FontFeature.tabularFigures()],
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              l10n.timerHint,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 64),
              textStyle: theme.textTheme.titleMedium,
            ),
            onPressed: _saving ? null : (_running ? _pause : _start),
            icon: Icon(_running ? Icons.pause : Icons.play_arrow),
            label: Text(
              _running
                  ? l10n.timerPause
                  : (hasTime ? l10n.timerResume : l10n.timerStart),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 56),
            ),
            onPressed: !hasTime || _saving ? null : () => _finish(l10n),
            icon: const Icon(Icons.check),
            label: Text(l10n.timerFinish),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _distanceController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: l10n.activityDistanceLabel),
          ),
          const SizedBox(height: 24),
          Text(l10n.activityDisclaimer, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
