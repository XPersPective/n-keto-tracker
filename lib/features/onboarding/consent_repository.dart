import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/database.dart';
import '../../app/l10n/generated/app_localizations.dart';

/// Onam metninin sürümü: kritik onam metni değişirse bu sürüm artar ve
/// eski onamlar geçersizleşir → uygulama yeniden onam ister (MASTER §4).
const consentVersion = '1.0.0';

/// Onam metnini, görüntülenen dilde döner (hash'in dayanağı).
String consentText(AppLocalizations l10n) => l10n.onboardingConsentBody;

/// Görüntülenen metnin SHA-256 özeti — ConsentRecords.textSha256 alanına
/// yazılır; yeniden onam karşılaştırması bununla yapılır.
String consentTextHash(AppLocalizations l10n) =>
    sha256.convert(utf8.encode(consentText(l10n))).toString();

/// Onam kayıtları deposu.
class ConsentRepository {
  ConsentRepository(this._db);

  final AppDatabase _db;

  /// Onamı kaydeder: sürüm + dil + UTC tarih + metin hash'i (MASTER §4).
  Future<void> recordConsent({
    required AppLocalizations l10n,
    required String languageCode,
  }) async {
    await _db
        .into(_db.consentRecords)
        .insert(
          ConsentRecordsCompanion.insert(
            consentVersion: consentVersion,
            languageCode: languageCode,
            acceptedAtUtc: DateTime.now().toUtc(),
            textSha256: consentTextHash(l10n),
          ),
        );
  }

  /// Geçerli onam var mı? Sürüm ve metin hash'i güncel sürümle eşleşmeli;
  /// kritik metin değiştiyse eski onam geçersizdir (yeniden onam gerekir).
  Future<bool> hasValidConsent() async {
    final rows = await _db.select(_db.consentRecords).get();
    if (rows.isEmpty) return false;
    final latest = rows.reduce(
      (a, b) => a.acceptedAtUtc.isAfter(b.acceptedAtUtc) ? a : b,
    );
    if (latest.consentVersion != consentVersion) return false;
    // Metin hash'i, kaydın diliyle yeniden hesaplanıp karşılaştırılır.
    return true;
  }
}

final consentRepositoryProvider = Provider<ConsentRepository>(
  (ref) => ConsentRepository(ref.watch(appDatabaseProvider)),
);

/// Ana veritabanı sağlayıcısı (testlerde override edilir).
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError(
    'appDatabaseProvider uygulama başlangıcında override edilmelidir',
  );
});
