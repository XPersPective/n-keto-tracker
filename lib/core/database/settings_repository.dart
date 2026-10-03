import 'package:drift/drift.dart' show OrderingTerm, Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database.dart';
import 'providers.dart';

/// Uygulama geneli ayarlar deposu (AppSettings tablosu; tek satır id=1).
///
/// Onboarding bitişinde dil tercihi ve tamamlanma bayrağı buraya yazılır
/// (ORTAK §3.1: dil uygulama içinden seçilebilir ve seçim kalıcıdır);
/// değişiklik, ayar sağlayıcısını invalidate eden onboarding bitişiyle
/// yerel ayara yansır.
class SettingsRepository {
  SettingsRepository(this._db);

  final AppDatabase _db;

  /// Dil tercihi + onboarding tamamlandı bilgisini tek satıra yazar.
  Future<void> saveOnboardingResult({required String languageCode}) async {
    final updated =
        await (_db.update(_db.appSettings)..where((s) => s.id.equals(1))).write(
          AppSettingsCompanion(
            languageCode: Value(languageCode),
            onboardingCompleted: const Value(true),
          ),
        );
    if (updated == 0) {
      await _db
          .into(_db.appSettings)
          .insert(
            AppSettingsCompanion.insert(
              languageCode: Value(languageCode),
              onboardingCompleted: const Value(true),
            ),
          );
    }
  }

  /// Ayar satırını okur; satır yoksa null (kurulum öncesi).
  /// Tabloda birden çok satır olsa da çökmez (en küçük id alınır).
  Future<AppSettingsRow?> readSettings() {
    final query = _db.select(_db.appSettings)
      ..orderBy([(s) => OrderingTerm.asc(s.id)])
      ..limit(1);
    return query.getSingleOrNull();
  }
}

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(appDatabaseProvider)),
);

/// Ayar satırının tek okumalı önbelleği; onboarding bitişinde invalidate
/// edilir (canlı veritabanı akışı yerine — FakeAsync test bölgesinde
/// zamanlayıcı güvenliği, PB-010).
final appSettingsProvider = FutureProvider<AppSettingsRow?>(
  (ref) => ref.watch(settingsRepositoryProvider).readSettings(),
);
