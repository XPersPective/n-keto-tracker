import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/symptom_repository.dart';

/// T23 semptom CRUD testleri (MASTER_PROMPT §11.2): seed tanımlar (11
/// madde), kullanıcı tanımı, giriş ekleme/silme, şiddet aralığı.
void main() {
  late AppDatabase db;
  late SymptomRepository repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = SymptomRepository(db);
  });

  tearDown(() async => db.close());

  test('seed tanımlar: 11 varsayılan semptom idempotent eklenir', () async {
    await repo.seedDefinitions();
    await repo.seedDefinitions(); // ikinci koşum değişiklik yapmaz
    final defs = await repo.definitions();
    expect(defs, hasLength(11));
    expect(
      defs.map((d) => d.id).toSet(),
      containsAll(['nausea', 'seizure-event', 'other']),
    );
  });

  test('kullanıcı tanımı eklenir ve isUserCreated işaretlenir', () async {
    await repo.seedDefinitions();
    final user = await repo.addUserDefinition(
      nameTr: 'Özel belirti',
      nameEn: 'Custom symptom',
    );
    expect(user.isUserCreated, isTrue);
    expect((await repo.definitions()).length, 12);
  });

  test('giriş ekleme + listeleme + silme', () async {
    await repo.seedDefinitions();
    final id = await repo.addEntry(
      symptomDefinitionId: 'nausea',
      severity: 4,
      note: 'öğleden sonra',
    );
    final entries = await repo.entries();
    expect(entries, hasLength(1));
    expect(entries.single.definition.id, 'nausea');
    expect(entries.single.entry.severity, 4);
    await repo.deleteEntry(id);
    expect((await repo.entries()), isEmpty);
  });

  test('şiddet 0–10 dışı reddedilir', () async {
    await repo.seedDefinitions();
    expect(
      () => repo.addEntry(symptomDefinitionId: 'nausea', severity: 11),
      throwsA(isA<ArgumentError>()),
    );
    expect(
      () => repo.addEntry(symptomDefinitionId: 'nausea', severity: -1),
      throwsA(isA<ArgumentError>()),
    );
  });

  test(
    'yönlendirme kuralı: nöbet olayı veya şiddet ≥7 mesaj tetikler',
    () async {
      await repo.seedDefinitions();
      // Nöbet olayı: şiddetten bağımsız yönlendirme.
      expect(
        SymptomRepository.needsGuidance(
          definitionId: 'seizure-event',
          severity: 2,
        ),
        isTrue,
      );
      // Şiddet 7+: diğer semptomlarda da yönlendirme.
      expect(
        SymptomRepository.needsGuidance(definitionId: 'headache', severity: 8),
        isTrue,
      );
      // Düşük şiddetli sıradan belirti: yönlendirme yok.
      expect(
        SymptomRepository.needsGuidance(definitionId: 'headache', severity: 3),
        isFalse,
      );
    },
  );
}
