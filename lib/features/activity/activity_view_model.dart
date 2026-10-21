import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/generated/app_localizations.dart';
import '../../core/database/activity_repository.dart';
import '../../core/database/database.dart';
import '../../core/database/providers.dart';

final activityRepositoryProvider = Provider<ActivityRepository>(
  (ref) => ActivityRepository(ref.watch(appDatabaseProvider)),
);

/// Yerel gün aralığı [başlangıç UTC, bitiş UTC): bugün dahil [days] gün.
/// Öğün sorgularıyla aynı yerel-gün kuralı (timezone offset'iyle UTC'ye).
(DateTime, DateTime) localDayRange(DateTime now, {required int days}) {
  final startLocal = DateTime(now.year, now.month, now.day - (days - 1));
  final endLocal = DateTime(now.year, now.month, now.day + 1);
  final tzOffset = now.timeZoneOffset;
  return (startLocal.subtract(tzOffset), endLocal.subtract(tzOffset));
}

/// Bugünün hareket kayıtları (en yeni önce).
final todayActivityProvider =
    FutureProvider.autoDispose<List<ActivitySessionRow>>((ref) async {
      final repo = ref.watch(activityRepositoryProvider);
      final (from, to) = localDayRange(DateTime.now(), days: 1);
      return repo.between(from, to);
    }, dependencies: [activityRepositoryProvider]);

/// Son 7 günün hareket kayıtları (DSÖ haftalık hedefi için).
final weekActivityProvider =
    FutureProvider.autoDispose<List<ActivitySessionRow>>((ref) async {
      final repo = ref.watch(activityRepositoryProvider);
      final (from, to) = localDayRange(DateTime.now(), days: 7);
      return repo.between(from, to);
    }, dependencies: [activityRepositoryProvider]);

/// Tür kodunun yerelleştirilmiş adı.
String activityKindLabel(AppLocalizations l10n, String kind) {
  switch (kind) {
    case 'run':
      return l10n.activityKindRun;
    case 'strength':
      return l10n.activityKindStrength;
    case 'other':
      return l10n.activityKindOther;
    default:
      return l10n.activityKindWalk;
  }
}

/// Tür için simge (form ve kart aynı simgeyi kullanır).
IconData activityKindIcon(String kind) {
  switch (kind) {
    case 'run':
      return Icons.directions_run;
    case 'strength':
      return Icons.fitness_center;
    case 'other':
      return Icons.more_horiz;
    default:
      return Icons.directions_walk;
  }
}
