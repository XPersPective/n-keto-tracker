import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/core/database/activity_repository.dart';
import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/export_import_repository.dart';
import 'package:n_keto_tracker/core/units/csv_safety.dart';

/// Hareket kaydı: doğrulama, aralık sorgusu, silme, dışa/içe aktarma ve
/// delete-all kapsamı.
void main() {
  late AppDatabase db;
  late ActivityRepository repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = ActivityRepository(db);
  });

  tearDown(() async => db.close());

  test('geçersiz tür, süre ve mesafe reddedilir', () async {
    await expectLater(
      repo.add(kind: 'yuzme', durationMinutes: 10),
      throwsArgumentError,
    );
    await expectLater(
      repo.add(kind: 'run', durationMinutes: 0),
      throwsArgumentError,
    );
    await expectLater(
      repo.add(kind: 'run', durationMinutes: 601),
      throwsArgumentError,
    );
    await expectLater(
      repo.add(kind: 'run', durationMinutes: 10, distanceKm: 0),
      throwsArgumentError,
    );
    expect(await db.select(db.activitySession).get(), isEmpty);
  });

  test('aralık sorgusu yalnız istenen aralığı getirir; sil çalışır', () async {
    final day = DateTime(2026, 10, 20, 7);
    final id = await repo.add(
      kind: 'run',
      durationMinutes: 30,
      distanceKm: 5,
      at: day,
      note: 'sabah',
    );
    await repo.add(
      kind: 'walk',
      durationMinutes: 20,
      at: day.add(const Duration(days: 3)),
    );

    final inRange = await repo.between(
      day.subtract(const Duration(hours: 1)).toUtc(),
      day.add(const Duration(hours: 1)).toUtc(),
    );
    expect(inRange, hasLength(1));
    expect(inRange.single.kind, 'run');
    expect(inRange.single.distanceKm, 5);
    expect(inRange.single.note, 'sabah');

    await repo.delete(id);
    expect(await db.select(db.activitySession).get(), hasLength(1));
  });

  test('dışa aktarım hareketleri içerir; içe aktarım geri yükler; delete-all siler', () async {
    await repo.add(kind: 'run', durationMinutes: 45, distanceKm: 7.5);
    final exporter = ExportImportRepository(db, appVersion: 'test');

    final json = await exporter.exportJson();
    final doc = jsonDecode(json) as Map<String, dynamic>;
    expect(doc['schemaVersion'], 2);
    expect(doc['activitySessions'] as List, hasLength(1));

    final deleted = await exporter.deleteAllData();
    expect(deleted, greaterThanOrEqualTo(1));
    expect(await db.select(db.activitySession).get(), isEmpty);

    final result = await exporter.importJson(json);
    expect(result.activityCount, 1);
    final restored = await db.select(db.activitySession).getSingle();
    expect(restored.kind, 'run');
    expect(restored.durationMinutes, 45);
    expect(restored.distanceKm, 7.5);
  });

  test(
    'geçersiz hareket satırı içe aktarımda reddedilir, hiçbir şey yazılmaz',
    () async {
      final exporter = ExportImportRepository(db, appVersion: 'test');
      final doc =
          jsonDecode(await exporter.exportJson()) as Map<String, dynamic>;
      doc['activitySessions'] = [
        {
          'kind': 'run',
          'startedAtUtc': DateTime.utc(2026, 10, 20).toIso8601String(),
          'localOffsetMinutes': 0,
          'durationMinutes': 9999,
        },
      ];
      await expectLater(
        exporter.importJson(jsonEncode(doc)),
        throwsA(isA<ImportValidationException>()),
      );
      expect(await db.select(db.activitySession).get(), isEmpty);
    },
  );
}
