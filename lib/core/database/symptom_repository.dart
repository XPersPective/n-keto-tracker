import 'package:drift/drift.dart';

import 'database.dart';

/// Semptom tanım ve kayıt iş akışı (MASTER_PROMPT §11.2, T23).
///
/// Uygulama teşhis KOYMAZ: ciddi/yeni belirtide kullanıcı kendi sağlık
/// planına ve gerektiğinde yerel acil hizmete yönlendirilir.
class SymptomRepository {
  SymptomRepository(this._db);

  final AppDatabase _db;

  /// MASTER §11.2 yerel başlangıç listesi (id sabit; TR/EN adlar).
  static const List<(String, String, String)> defaultDefinitions = [
    ('nausea', 'Bulantı', 'Nausea'),
    ('vomiting', 'Kusma', 'Vomiting'),
    ('poor-appetite', 'İştahsızlık', 'Poor appetite'),
    ('constipation', 'Kabızlık', 'Constipation'),
    ('diarrhea', 'İshal', 'Diarrhea'),
    ('fatigue', 'Yorgunluk', 'Fatigue'),
    ('headache', 'Baş ağrısı', 'Headache'),
    ('dizziness', 'Baş dönmesi', 'Dizziness'),
    ('seizure-event', 'Nöbet olayı', 'Seizure event'),
    ('sleep-issue', 'Uyku sorunu', 'Sleep problem'),
    ('other', 'Diğer', 'Other'),
  ];

  /// Varsayılan tanımları ekler (idempotent).
  Future<void> seedDefinitions() async {
    for (final (id, tr, en) in defaultDefinitions) {
      final exists = await (_db.select(
        _db.symptomDefinition,
      )..where((t) => t.id.equals(id))).getSingleOrNull();
      if (exists != null) continue;
      await _db
          .into(_db.symptomDefinition)
          .insert(
            SymptomDefinitionCompanion.insert(id: id, nameTr: tr, nameEn: en),
          );
    }
  }

  Future<List<SymptomDefinitionRow>> definitions() => (_db.select(
    _db.symptomDefinition,
  )..orderBy([(t) => OrderingTerm.asc(t.nameTr)])).get();

  /// Kullanıcı kendi tanımını ekleyebilir (düzenlenebilir liste).
  Future<SymptomDefinitionRow> addUserDefinition({
    required String nameTr,
    required String nameEn,
  }) async {
    final id =
        'user:sym-${DateTime.now().microsecondsSinceEpoch.toRadixString(36)}';
    await _db
        .into(_db.symptomDefinition)
        .insert(
          SymptomDefinitionCompanion.insert(
            id: id,
            nameTr: nameTr,
            nameEn: nameEn,
            isUserCreated: const Value(true),
          ),
        );
    return (_db.select(
      _db.symptomDefinition,
    )..where((t) => t.id.equals(id))).getSingle();
  }

  Future<int> addEntry({
    required String symptomDefinitionId,
    required int severity,
    DateTime? startedAtUtc,
    int? durationMinutes,
    String? note,
  }) {
    if (severity < 0 || severity > 10) {
      throw ArgumentError('şiddet 0–10 aralığında olmalı');
    }
    return _db
        .into(_db.symptomEntry)
        .insert(
          SymptomEntryCompanion.insert(
            symptomDefinitionId: symptomDefinitionId,
            severity: severity,
            startedAtUtc: Value(startedAtUtc),
            durationMinutes: Value(durationMinutes),
            note: Value(note),
            createdAtUtc: DateTime.now().toUtc(),
          ),
        );
  }

  Future<List<({SymptomDefinitionRow definition, SymptomEntryRow entry})>>
  entries() async {
    final query = _db.select(_db.symptomEntry).join([
      innerJoin(
        _db.symptomDefinition,
        _db.symptomDefinition.id.equalsExp(
          _db.symptomEntry.symptomDefinitionId,
        ),
      ),
    ]);
    // Join sorgusunda orderBy doğrudan OrderingTerm listesi alır.
    query.orderBy([OrderingTerm.desc(_db.symptomEntry.createdAtUtc)]);
    final rows = await query.get();
    return rows
        .map(
          (r) => (
            definition: r.readTable(_db.symptomDefinition),
            entry: r.readTable(_db.symptomEntry),
          ),
        )
        .toList();
  }

  Future<int> deleteEntry(int id) =>
      (_db.delete(_db.symptomEntry)..where((t) => t.id.equals(id))).go();

  /// Ciddi belirti kılavuzu: uygulama teşhis koymaz; kendi sağlık planına
  /// ve gerektiğinde yerel acil hizmete yönlendirir (MASTER §11.2).
  static bool needsGuidance({
    required String definitionId,
    required int severity,
  }) => definitionId == 'seizure-event' || severity >= 7;
}
