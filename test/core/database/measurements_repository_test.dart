import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/measurements_repository.dart';
import 'package:n_keto_tracker/core/units/glucose.dart';

/// T12 oturum iş akışı testleri (MASTER_PROMPT §6.3): onaysız GKI yok,
/// düzenlemede deterministik yeniden hesap, silmede geçersizleştirme.
void main() {
  late AppDatabase db;
  late MeasurementsRepository repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = MeasurementsRepository(db);
  });

  tearDown(() async => db.close());

  test('onaylı oturum GKI üretir; onaysız çağrı reddedilir', () async {
    final glucose = GlucoseValue.fromRaw(90, GlucoseUnit.mgDl);
    expect(
      () => repo.createSession(
        glucose: glucose,
        glucoseAtUtc: DateTime.utc(2026, 9, 20, 8),
        glucoseOffsetMinutes: 180,
        glucoseSourceType: 'fingerstick',
        bhbMmolL: 2.5,
        ketoneAtUtc: DateTime.utc(2026, 9, 20, 8),
        ketoneOffsetMinutes: 180,
        matchKind: 'simultaneous',
        confirmedByUser: false,
      ),
      throwsA(isA<StateError>()),
    );
    final id = await repo.createSession(
      glucose: glucose,
      glucoseAtUtc: DateTime.utc(2026, 9, 20, 8),
      glucoseOffsetMinutes: 180,
      glucoseSourceType: 'fingerstick',
      bhbMmolL: 2.5,
      ketoneAtUtc: DateTime.utc(2026, 9, 20, 8),
      ketoneOffsetMinutes: 180,
      matchKind: 'simultaneous',
      confirmedByUser: true,
    );
    final session = await (db.select(
      db.measurementSession,
    )..where((s) => s.id.equals(id))).getSingle();
    expect(session.gkiValue, 2.0);
    expect(session.isValid, isTrue);
  });

  test('düzenlemede GKI deterministik yeniden hesaplanır', () async {
    final sessionId = await repo.createSession(
      glucose: GlucoseValue.fromRaw(90, GlucoseUnit.mgDl),
      glucoseAtUtc: DateTime.utc(2026, 9, 20, 8),
      glucoseOffsetMinutes: 180,
      glucoseSourceType: 'fingerstick',
      bhbMmolL: 2.5,
      ketoneAtUtc: DateTime.utc(2026, 9, 20, 8),
      ketoneOffsetMinutes: 180,
      matchKind: 'simultaneous',
      confirmedByUser: true,
    );
    final glucoseId = (await db.select(db.glucoseMeasurement).get()).single.id;
    final affected = await repo.updateGlucose(
      glucoseId,
      newValue: GlucoseValue.fromRaw(180, GlucoseUnit.mgDl),
      measuredAtUtc: DateTime.utc(2026, 9, 20, 8),
      localOffsetMinutes: 180,
    );
    expect(affected, [sessionId]);
    final session = await (db.select(
      db.measurementSession,
    )..where((s) => s.id.equals(sessionId))).getSingle();
    expect(session.gkiValue, 4.0); // 10.0 / 2.5
    expect(session.formulaVersion, 'gki-v1');
  });

  test(
    'silmede oturum geçersizleştirilir ve bildirilir; satır korunur',
    () async {
      final sessionId = await repo.createSession(
        glucose: GlucoseValue.fromRaw(90, GlucoseUnit.mgDl),
        glucoseAtUtc: DateTime.utc(2026, 9, 20, 8),
        glucoseOffsetMinutes: 180,
        glucoseSourceType: 'fingerstick',
        bhbMmolL: 2.5,
        ketoneAtUtc: DateTime.utc(2026, 9, 20, 8),
        ketoneOffsetMinutes: 180,
        matchKind: 'simultaneous',
        confirmedByUser: true,
      );
      final glucoseId =
          (await db.select(db.glucoseMeasurement).get()).single.id;
      final affected = await repo.deleteGlucose(glucoseId);
      expect(affected, [sessionId]);
      final session = await (db.select(
        db.measurementSession,
      )..where((s) => s.id.equals(sessionId))).getSingle();
      expect(session.isValid, isFalse, reason: 'geçersiz oturum satırı kalır');
      expect(session.glucoseId, isNull, reason: 'FK SET NULL');
    },
  );

  test('çift kayıt uyarısı: benzer zaman+değer bulunur', () async {
    await repo.createSession(
      glucose: GlucoseValue.fromRaw(90, GlucoseUnit.mgDl),
      glucoseAtUtc: DateTime.utc(2026, 9, 20, 8, 0),
      glucoseOffsetMinutes: 180,
      glucoseSourceType: 'fingerstick',
      bhbMmolL: 2.5,
      ketoneAtUtc: DateTime.utc(2026, 9, 20, 8, 0),
      ketoneOffsetMinutes: 180,
      matchKind: 'simultaneous',
      confirmedByUser: true,
    );
    // Aynı dakika ±5 ve aynı değer → uyarı adayı.
    final duplicates = await (db.select(
      db.glucoseMeasurement,
    )..where((t) => t.mmolL.equals(5.0))).get();
    expect(duplicates, hasLength(1));
    // Yine de kaydedilebilir: kullanıcı onayıyla yeni oturum açılır.
    final second = await repo.createSession(
      glucose: GlucoseValue.fromRaw(90, GlucoseUnit.mgDl),
      glucoseAtUtc: DateTime.utc(2026, 9, 20, 8, 2),
      glucoseOffsetMinutes: 180,
      glucoseSourceType: 'fingerstick',
      bhbMmolL: 2.5,
      ketoneAtUtc: DateTime.utc(2026, 9, 20, 8, 2),
      ketoneOffsetMinutes: 180,
      matchKind: 'simultaneous',
      confirmedByUser: true,
    );
    expect(second, greaterThan(0));
  });
}
