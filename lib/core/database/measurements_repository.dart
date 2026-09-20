import 'package:drift/drift.dart';

import '../../core/units/gki.dart';
import '../../core/units/glucose.dart';
import 'database.dart';

/// Ölçüm oturumu iş akışı (MASTER_PROMPT §6.3, T12):
/// - kullanıcı onayı olmadan GKI üretilmez;
/// - ölçüm düzenlenirse GKI deterministik olarak yeniden hesaplanır;
/// - ölçüm silinirse oturum geçersizleştirilir ve etkilenen oturumlar
///   bildirilir.
class MeasurementsRepository {
  MeasurementsRepository(this._db);

  final AppDatabase _db;

  /// Birleşik 'Ölçüm oturumu' formu: glukoz + kan BHB birlikte girilir.
  /// [matchKind] eşzamanlı (aynı form) veya yaklaşık (ayrı giriş onayı).
  Future<int> createSession({
    required GlucoseValue glucose,
    required DateTime glucoseAtUtc,
    required int glucoseOffsetMinutes,
    required String glucoseSourceType,
    required double bhbMmolL,
    required DateTime ketoneAtUtc,
    required int ketoneOffsetMinutes,
    required String matchKind,
    required bool confirmedByUser,
    int? matchDifferenceMinutes,
    String? note,
  }) {
    if (!confirmedByUser) {
      // Onay olmadan GKI üretilmez (MASTER §6.3).
      throw StateError('GKI requires explicit user confirmation');
    }
    return _db.transaction(() async {
      final gId = await _db
          .into(_db.glucoseMeasurement)
          .insert(
            GlucoseMeasurementCompanion.insert(
              rawValue: glucose.rawValue,
              rawUnit: glucose.unit == GlucoseUnit.mgDl ? 'mg_dL' : 'mmol_L',
              mmolL: glucose.mmolL,
              measuredAtUtc: glucoseAtUtc,
              localOffsetMinutes: glucoseOffsetMinutes,
              sourceType: glucoseSourceType,
              note: Value(note),
            ),
          );
      final kId = await _db
          .into(_db.ketoneMeasurement)
          .insert(
            KetoneMeasurementCompanion.insert(
              rawValue: bhbMmolL,
              mmolL: bhbMmolL,
              measuredAtUtc: ketoneAtUtc,
              localOffsetMinutes: ketoneOffsetMinutes,
            ),
          );
      final result = GkiEngine.fromRaw(glucose: glucose, bhbMmolL: bhbMmolL);
      return _db
          .into(_db.measurementSession)
          .insert(
            MeasurementSessionCompanion.insert(
              glucoseId: Value(gId),
              ketoneId: Value(kId),
              gkiValue: result.value,
              formulaVersion: result.formulaVersion,
              matchDifferenceMinutes: Value(matchDifferenceMinutes),
              matchKind: matchKind,
              confirmedByUser: confirmedByUser,
              computedAtUtc: DateTime.now().toUtc(),
            ),
          );
    });
  }

  /// Glukoz ölçümünü düzenler; bağlı oturumların GKI'sini deterministik
  /// yeniden hesaplar. Dönen değer: etkilenen oturum kimlikleri.
  Future<List<int>> updateGlucose(
    int glucoseId, {
    required GlucoseValue newValue,
    required DateTime measuredAtUtc,
    required int localOffsetMinutes,
  }) async {
    return _db.transaction(() async {
      await (_db.update(
        _db.glucoseMeasurement,
      )..where((t) => t.id.equals(glucoseId))).write(
        GlucoseMeasurementCompanion(
          rawValue: Value(newValue.rawValue),
          rawUnit: Value(
            newValue.unit == GlucoseUnit.mgDl ? 'mg_dL' : 'mmol_L',
          ),
          mmolL: Value(newValue.mmolL),
          measuredAtUtc: Value(measuredAtUtc),
          localOffsetMinutes: Value(localOffsetMinutes),
        ),
      );
      return _recalculateSessions(glucoseId);
    });
  }

  /// Ölçüm silinir: bağlı oturumlar SET NULL + isValid=false ile
  /// geçersizleştirilir ve dönen listede bildirilir (MASTER §6.3).
  Future<List<int>> deleteGlucose(int glucoseId) async {
    return _db.transaction(() async {
      final affected = await _invalidateSessions(glucoseId);
      await (_db.delete(
        _db.glucoseMeasurement,
      )..where((t) => t.id.equals(glucoseId))).go();
      return affected;
    });
  }

  /// Formül sürümü değişirse tüm geçerli oturumlar bu metotla yeniden
  /// hesaplanır (sürümlü tek modül garantisi).
  Future<int> recalculateAllWithCurrentFormula() async {
    var changed = 0;
    final sessions = await (_db.select(
      _db.measurementSession,
    )..where((s) => s.isValid.equals(true))).get();
    for (final s in sessions) {
      if (s.glucoseId == null || s.ketoneId == null) continue;
      final g = await (_db.select(
        _db.glucoseMeasurement,
      )..where((t) => t.id.equals(s.glucoseId!))).getSingle();
      final k = await (_db.select(
        _db.ketoneMeasurement,
      )..where((t) => t.id.equals(s.ketoneId!))).getSingle();
      final result = GkiEngine.fromMmolL(
        glucoseMmolL: g.mmolL,
        bhbMmolL: k.mmolL,
      );
      await (_db.update(
        _db.measurementSession,
      )..where((t) => t.id.equals(s.id))).write(
        MeasurementSessionCompanion(
          gkiValue: Value(result.value),
          formulaVersion: Value(result.formulaVersion),
          computedAtUtc: Value(DateTime.now().toUtc()),
        ),
      );
      changed++;
    }
    return changed;
  }

  Future<List<int>> _recalculateSessions(int glucoseId) async {
    final sessions = await (_db.select(
      _db.measurementSession,
    )..where((s) => s.glucoseId.equals(glucoseId))).get();
    final g = await (_db.select(
      _db.glucoseMeasurement,
    )..where((t) => t.id.equals(glucoseId))).getSingle();
    final affected = <int>[];
    for (final s in sessions) {
      if (!s.isValid || s.ketoneId == null) continue;
      final k = await (_db.select(
        _db.ketoneMeasurement,
      )..where((t) => t.id.equals(s.ketoneId!))).getSingle();
      final result = GkiEngine.fromMmolL(
        glucoseMmolL: g.mmolL,
        bhbMmolL: k.mmolL,
      );
      await (_db.update(
        _db.measurementSession,
      )..where((t) => t.id.equals(s.id))).write(
        MeasurementSessionCompanion(
          gkiValue: Value(result.value),
          formulaVersion: Value(result.formulaVersion),
          computedAtUtc: Value(DateTime.now().toUtc()),
        ),
      );
      affected.add(s.id);
    }
    return affected;
  }

  Future<List<int>> _invalidateSessions(int glucoseId) async {
    final sessions = await (_db.select(
      _db.measurementSession,
    )..where((s) => s.glucoseId.equals(glucoseId))).get();
    final affected = <int>[];
    for (final s in sessions) {
      if (!s.isValid) continue;
      await (_db.update(_db.measurementSession)
            ..where((t) => t.id.equals(s.id)))
          .write(const MeasurementSessionCompanion(isValid: Value(false)));
      affected.add(s.id);
    }
    return affected;
  }
}
