import 'package:drift/drift.dart';

import 'database.dart';

/// Hareket kaydı (koşu, yürüyüş, kuvvet, diğer). Yalnız cihazda saklanır.
class ActivityRepository {
  ActivityRepository(this._db);

  final AppDatabase _db;

  /// Türler: 'walk' | 'run' | 'strength' | 'other'.
  static const List<String> kinds = ['walk', 'run', 'strength', 'other'];

  /// Süre 1–600 dk arasında olmalı; mesafe varsa pozitif olmalı.
  Future<int> add({
    required String kind,
    required int durationMinutes,
    DateTime? at,
    double? distanceKm,
    String? note,
  }) async {
    if (!kinds.contains(kind)) {
      throw ArgumentError('bilinmeyen hareket türü: $kind');
    }
    if (durationMinutes < 1 || durationMinutes > 600) {
      throw ArgumentError('süre 1–600 dakika olmalı');
    }
    if (distanceKm != null && distanceKm <= 0) {
      throw ArgumentError('mesafe pozitif olmalı');
    }
    final when = at ?? DateTime.now();
    return _db
        .into(_db.activitySession)
        .insert(
          ActivitySessionCompanion.insert(
            kind: kind,
            startedAtUtc: when.toUtc(),
            localOffsetMinutes: when.timeZoneOffset.inMinutes,
            durationMinutes: durationMinutes,
            distanceKm: Value(distanceKm),
            note: Value(note == null || note.isEmpty ? null : note),
            createdAtUtc: DateTime.now().toUtc(),
          ),
        );
  }

  /// [fromUtc, toUtc) aralığındaki kayıtlar, en yeni önce.
  Future<List<ActivitySessionRow>> between(DateTime fromUtc, DateTime toUtc) {
    return (_db.select(_db.activitySession)
          ..where((a) => a.startedAtUtc.isBetweenValues(fromUtc, toUtc))
          ..orderBy([(a) => OrderingTerm.desc(a.startedAtUtc)]))
        .get();
  }

  Future<void> delete(int id) =>
      (_db.delete(_db.activitySession)..where((a) => a.id.equals(id))).go();
}
