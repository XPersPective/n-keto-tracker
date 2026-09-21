import 'dart:convert';

import 'package:drift/drift.dart';

import '../../core/units/csv_safety.dart';
import 'database.dart';

/// Dışa/içe aktarma ve tüm verileri silme (MASTER_PROMPT §14.3, T26).
///
/// - Export yalnız kullanıcı eylemiyle: JSON başlığında uygulama/şema
///   sürümü, birimler, zaman dilimi, uyarı ve formatVersion bulunur.
/// - Import: başlık doğrulama, tip/range kontrolü, bilinmeyen alan yok
///   sayma, tek transaction (hatada SIFIR kısmi yazı).
/// - ExportHistory yalnız metadata saklar (dosya içeriği asla).
/// - deleteAllData: kapsam açıkça raporlanır; UI ikinci onay ister.
class ExportImportRepository {
  ExportImportRepository(this._db, {this.appVersion = '0.0.0-dev'});

  final AppDatabase _db;
  final String appVersion;

  static const String formatVersion = '1.0';
  static const int schemaVersion = 1;

  /// Tüm kullanıcı verilerini okunabilir JSON olarak dışa aktarır.
  Future<String> exportJson() async {
    final doc = <String, dynamic>{
      'formatVersion': formatVersion,
      'schemaVersion': schemaVersion,
      'appVersion': appVersion,
      'exportedAtUtc': DateTime.now().toUtc().toIso8601String(),
      'timezoneOffsetMinutes': DateTime.now().timeZoneOffset.inMinutes,
      'units': {'glucose': 'raw+mmol/L', 'weight': 'raw+kg'},
      'warning':
          'Kişisel sağlık verisi içerir. Yalnız güvendiğiniz kanallarla '
          'paylaşın. Bu dosya hiçbir sunucuya gönderilmez.',
      // Okunabilir JSON: tarihler ISO-8601, salt alanlar açıkça.
      'glucoseMeasurements': [
        for (final g in await _db.select(_db.glucoseMeasurement).get())
          {
            'rawValue': g.rawValue,
            'rawUnit': g.rawUnit,
            'mmolL': g.mmolL,
            'measuredAtUtc': g.measuredAtUtc.toIso8601String(),
            'localOffsetMinutes': g.localOffsetMinutes,
            'sourceType': g.sourceType,
            'note': g.note,
          },
      ],
      'weightEntries': [
        for (final w in await _db.select(_db.weightEntry).get())
          {
            'rawValue': w.rawValue,
            'rawUnit': w.rawUnit,
            'kg': w.kg,
            'measuredAtUtc': w.measuredAtUtc.toIso8601String(),
            'localOffsetMinutes': w.localOffsetMinutes,
            'conditionNote': w.conditionNote,
          },
      ],
    };
    return jsonEncode(doc);
  }

  /// Ölçümleri CSV olarak dışa aktarır (formül enjeksiyonu korumalı).
  Future<String> exportMeasurementsCsv() async {
    final glucose = await _db.select(_db.glucoseMeasurement).get();
    final buffer = StringBuffer()
      ..writeln(
        csvRow([
          'type',
          'rawValue',
          'rawUnit',
          'mmolL',
          'measuredAtUtc',
          'localOffsetMinutes',
          'sourceType',
        ]),
      );
    for (final g in glucose) {
      buffer.writeln(
        csvRow([
          'glucose',
          g.rawValue,
          g.rawUnit,
          g.mmolL,
          g.measuredAtUtc.toIso8601String(),
          g.localOffsetMinutes,
          g.sourceType,
        ]),
      );
    }
    return buffer.toString();
  }

  /// JSON'u doğrulayıp TEK TRANSACTION'da içe aktarır. Hatada sıfır
  /// kısmi yazı; dönen değer: eklenen kayıt sayıları.
  Future<ImportResult> importJson(String raw) async {
    validateImportHeader(
      doc: jsonDecode(raw) as Map<String, dynamic>,
      rawBytes: raw.length,
    );
    final doc = jsonDecode(raw) as Map<String, dynamic>;

    // Range/tip kontrolleri (transaction ÖNCESİ): geçersiz satır varsa
    // hiçbir şey yazılmadan reddedilir.
    final glucoseRows = <GlucoseMeasurementCompanion>[];
    for (final g in (doc['glucoseMeasurements'] as List? ?? []).cast<Map>()) {
      final mmolL = (g['mmolL'] as num?)?.toDouble();
      final rawValue = (g['rawValue'] as num?)?.toDouble();
      if (mmolL == null || mmolL <= 0 || rawValue == null || rawValue <= 0) {
        throw const ImportValidationException('invalid glucose row');
      }
      glucoseRows.add(
        GlucoseMeasurementCompanion.insert(
          rawValue: rawValue,
          rawUnit: (g['rawUnit'] ?? 'mg_dL') as String,
          mmolL: mmolL,
          measuredAtUtc: DateTime.parse(g['measuredAtUtc'] as String),
          localOffsetMinutes: (g['localOffsetMinutes'] ?? 0) as int,
          sourceType: (g['sourceType'] ?? 'other') as String,
        ),
      );
    }
    final weightRows = <WeightEntryCompanion>[];
    for (final w in (doc['weightEntries'] as List? ?? []).cast<Map>()) {
      final kg = (w['kg'] as num?)?.toDouble();
      if (kg == null || kg <= 0) {
        throw const ImportValidationException('invalid weight row');
      }
      weightRows.add(
        WeightEntryCompanion.insert(
          rawValue: kg,
          rawUnit: 'kg',
          kg: kg,
          measuredAtUtc: DateTime.parse(w['measuredAtUtc'] as String),
          localOffsetMinutes: 0,
        ),
      );
    }

    return _db.transaction(() async {
      for (final row in glucoseRows) {
        await _db.into(_db.glucoseMeasurement).insert(row);
      }
      for (final row in weightRows) {
        await _db.into(_db.weightEntry).insert(row);
      }
      await _db
          .into(_db.exportHistory)
          .insert(
            ExportHistoryCompanion.insert(
              exportedAtUtc: DateTime.now().toUtc(),
              format: 'json-import',
              recordCount: Value(glucoseRows.length + weightRows.length),
              schemaVersion: schemaVersion,
              appVersion: appVersion,
            ),
          );
      return ImportResult(
        glucoseCount: glucoseRows.length,
        weightCount: weightRows.length,
      );
    });
  }

  /// Tüm kullanıcı verilerini siler (UI ikinci onay ister) ve silinen
  /// kayıt sayısını raporlar (MASTER §14.3).
  Future<int> deleteAllData() async {
    return _db.transaction(() async {
      var deleted = 0;
      deleted += await _db.delete(_db.measurementSession).go();
      deleted += await _db.delete(_db.glucoseMeasurement).go();
      deleted += await _db.delete(_db.ketoneMeasurement).go();
      deleted += await _db.delete(_db.mealItem).go();
      deleted += await _db.delete(_db.meal).go();
      deleted += await _db.delete(_db.weightEntry).go();
      deleted += await _db.delete(_db.symptomEntry).go();
      deleted += await _db.delete(_db.mealPlanEntry).go();
      deleted += await _db.delete(_db.mealPlan).go();
      deleted += await _db.delete(_db.shoppingListItem).go();
      deleted += await _db.delete(_db.shoppingList).go();
      deleted += await _db.delete(_db.consentRecords).go();
      deleted += await _db.delete(_db.riskScreening).go();
      deleted += await _db.delete(_db.exportHistory).go();
      return deleted;
    });
  }
}

class ImportResult {
  const ImportResult({required this.glucoseCount, required this.weightCount});

  final int glucoseCount;
  final int weightCount;
}
