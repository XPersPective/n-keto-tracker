import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/export_import_repository.dart';
import 'package:n_keto_tracker/core/units/csv_safety.dart';

/// T26 export/import testleri (MASTER_PROMPT §14.3, §16.2, §16.4):
/// round-trip eşitliği, rollback (hatada sıfır kısmi yazı), CSV enjeksiyon
/// koruması, delete-all kapsamı.
void main() {
  late AppDatabase db;
  late ExportImportRepository repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = ExportImportRepository(db, appVersion: '0.0.0-dev');
  });

  tearDown(() async => db.close());

  Future<void> seedData() async {
    await db
        .into(db.glucoseMeasurement)
        .insert(
          GlucoseMeasurementCompanion.insert(
            rawValue: 90,
            rawUnit: 'mg_dL',
            mmolL: 5.0,
            measuredAtUtc: DateTime.utc(2026, 9, 20, 8),
            localOffsetMinutes: 180,
            sourceType: 'fingerstick',
          ),
        );
    final kId = await db
        .into(db.ketoneMeasurement)
        .insert(
          KetoneMeasurementCompanion.insert(
            rawValue: 2.5,
            mmolL: 2.5,
            measuredAtUtc: DateTime.utc(2026, 9, 20, 8),
            localOffsetMinutes: 180,
          ),
        );
    final gId = (await db.select(db.glucoseMeasurement).get()).first.id;
    await db
        .into(db.measurementSession)
        .insert(
          MeasurementSessionCompanion.insert(
            glucoseId: Value(gId),
            ketoneId: Value(kId),
            gkiValue: 2.0,
            formulaVersion: 'gki-v1',
            matchKind: 'simultaneous',
            confirmedByUser: true,
            computedAtUtc: DateTime.utc(2026, 9, 20, 8),
          ),
        );
    await db
        .into(db.weightEntry)
        .insert(
          WeightEntryCompanion.insert(
            rawValue: 72.5,
            rawUnit: 'kg',
            kg: 72.5,
            measuredAtUtc: DateTime.utc(2026, 9, 20, 8),
            localOffsetMinutes: 180,
          ),
        );
  }

  test('export JSON başlığı: sürüm/birim/uyarı/uyarı metni dolu', () async {
    await seedData();
    final raw = await repo.exportJson();
    final doc = jsonDecode(raw) as Map<String, dynamic>;
    expect(doc['formatVersion'], '1.0');
    expect(doc['schemaVersion'], 1);
    expect(doc['appVersion'], '0.0.0-dev');
    expect(doc['units'], isNotNull);
    expect((doc['warning'] as String).isNotEmpty, isTrue);
    // 7 kaynak tablosu var; örnek olarak ikisini kontrol et.
    expect((doc['glucoseMeasurements'] as List).length, 1);
    expect((doc['weightEntries'] as List).length, 1);
  });

  test(
    'CSV: başlık + satırlar; değerler formül enjeksiyonu korumalı',
    () async {
      await seedData();
      final csv = await repo.exportMeasurementsCsv();
      final lines = csv.trim().split('\n');
      expect(lines.first.startsWith('type,rawValue,rawUnit'), isTrue);
      expect(lines.length, 2); // başlık + 1 glukoz
      // FORMÜL KORUMASI: hiçbir hücre = ile başlamaz.
      for (final cell in lines.skip(1).expand((l) => l.split(','))) {
        expect(cell.startsWith('='), isFalse, reason: cell);
      }
      // Proactive: eşit işareti lecorally handle edilir.
      expect(csvCell('='), "'="); // csvCell fonksiyonel doğrulaması
    },
  );

  test('import round-trip: export → silme → import → değer eşitliği', () async {
    await seedData();
    final exported = await repo.exportJson();
    await repo.deleteAllData();
    expect((await db.select(db.weightEntry).get()), isEmpty);

    final result = await repo.importJson(exported);
    expect(result.glucoseCount, 1);
    expect(result.weightCount, 1);

    final weights = await db.select(db.weightEntry).get();
    expect(weights.single.kg, 72.5); // değer eşitliği
  });

  test('hatalı import: hatada sıfır kısmi yazı (rollback)', () async {
    final badRows = <Map<String, dynamic>>[
      {
        'rawValue': 90,
        'rawUnit': 'mg_dL',
        'mmolL': 5.0,
        'measuredAtUtc': '2026-09-20T08:00:00Z',
        'localOffsetMinutes': 180,
        'sourceType': 'fingerstick',
      },
      {
        'rawValue': -1, // range hatası: negatif glukoz
        'rawUnit': 'mg_dL',
        'mmolL': -0.06,
        'measuredAtUtc': '2026-09-20T08:00:00Z',
        'localOffsetMinutes': 180,
        'sourceType': 'fingerstick',
      },
    ];
    final doc = jsonEncode({
      'formatVersion': '1.0',
      'schemaVersion': 1,
      'glucoseMeasurements': badRows,
    });
    expect(
      () => repo.importJson(doc),
      throwsA(isA<ImportValidationException>()),
    );
    // Hatanın ardından HEÇ bir kayıt yazılmadı.
    expect((await db.select(db.glucoseMeasurement).get()), isEmpty);
    expect((await db.select(db.weightEntry).get()), isEmpty);
  });

  test('güvencesiz başlık ve boyut limiti reddedilir', () async {
    expect(
      () => repo.importJson(jsonEncode({'formatVersion': '9.9'})),
      throwsA(isA<ImportValidationException>()),
    );
    // Boyut limiti: header + içerik toplamı 5 MB'ı aşan girdi yasak.
    final huge = Map<String, dynamic>.from(
      jsonDecode(jsonEncode({'formatVersion': '1.0', 'schemaVersion': 1}))
          as Map,
    );
    huge['padding'] = List.filled(6000000, 'x');
    expect(
      () => repo.importJson(jsonEncode(huge)),
      throwsA(isA<ImportValidationException>()),
    );
  });

  test('bilinmeyen alanlar sessizce yok sayılır', () async {
    await seedData();
    final exported = await repo.exportJson();
    await repo.deleteAllData();
    final doc = jsonDecode(exported) as Map<String, dynamic>;
    doc['unknownCustomField'] = 'surprise';
    doc['unknownTable'] = [
      {'hack': true},
    ];
    // Bilinmeyen alan dokümanı bozmasın.
    final result = await repo.importJson(jsonEncode(doc));
    expect(result.weightCount, 1);
  });

  test('tüm verileri sil: kapsamlı tarama döner', () async {
    await seedData();
    final deleted = await repo.deleteAllData();
    // 1 glukoz + 1 keton + 1 session + 1 weight = 4 kayıt
    expect(deleted, 4);
    expect((await db.select(db.glucoseMeasurement).get()), isEmpty);
    expect((await db.select(db.measurementSession).get()), isEmpty);
    expect((await db.select(db.weightEntry).get()), isEmpty);
  });
}
