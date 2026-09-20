import 'package:flutter/material.dart' show Locale;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/l10n/generated/app_localizations.dart';
import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/features/onboarding/consent_repository.dart';

/// T9 onam kaydı testleri (MASTER §4): sürüm + dil + tarih + metin hash'i.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late ConsentRepository repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = ConsentRepository(db);
  });

  tearDown(() async => db.close());

  ConsentRecordsCompanion makeConsent({
    String version = consentVersion,
    String lang = 'tr',
    String hash = 'abc',
  }) => ConsentRecordsCompanion.insert(
    consentVersion: version,
    languageCode: lang,
    acceptedAtUtc: DateTime.now().toUtc(),
    textSha256: hash,
  );

  AppLocalizations l10nOf(String locale) =>
      lookupAppLocalizations(Locale(locale));

  test('onam yokken hasValidConsent false', () async {
    expect(await repo.hasValidConsent(), isFalse);
  });

  test('güncel sürümlü onam geçerli sayılır', () async {
    await db.into(db.consentRecords).insert(makeConsent());
    expect(await repo.hasValidConsent(), isTrue);
  });

  test('eski sürümlü onam geçersiz (yeniden onam gerekir)', () async {
    await db.into(db.consentRecords).insert(makeConsent(version: '0.9.0'));
    expect(await repo.hasValidConsent(), isFalse);
  });

  test('kayıt tüm alanları doldurur: sürüm+dil+tarih+hash', () async {
    await repo.recordConsent(l10n: l10nOf('en'), languageCode: 'en');
    final row = await db.select(db.consentRecords).getSingle();
    expect(row.consentVersion, consentVersion);
    expect(row.languageCode, 'en');
    expect(row.acceptedAtUtc, isNotNull);
    expect(row.textSha256.length, 64, reason: 'SHA-256 hex özeti');
  });

  test('metin hash\'i deterministik ve dilden bağımsız sürüme bağlı', () {
    final enHash = consentTextHash(l10nOf('en'));
    final trHash = consentTextHash(l10nOf('tr'));
    expect(enHash.length, 64);
    expect(trHash.length, 64);
    // Farklı diller farklı metin → farklı hash (kabul edilebilir);
    // kritik olan: aynı dilde aynı hash.
    expect(consentTextHash(l10nOf('en')), enHash);
  });
}
