import 'package:drift/native.dart';
import 'package:flutter/material.dart' show Locale;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/locale_provider.dart';
import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/providers.dart';
import 'package:n_keto_tracker/core/database/settings_repository.dart';

/// PB-010: ayar deposu + yerel ayar çözümlemesi.
/// Onboarding tercihi AppSettings'e yazılır; appLocaleProvider desteklenen
/// dili Locale'e çevirir, kayıt yokken cihaz diline (null) bırakır.
void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async => db.close());

  test('saveOnboardingResult satırı yazar; ikinci çağrı günceller', () async {
    final repo = SettingsRepository(db);

    await repo.saveOnboardingResult(languageCode: 'tr');
    var row = await db.select(db.appSettings).getSingle();
    expect(row.languageCode, 'tr');
    expect(row.onboardingCompleted, isTrue);

    await repo.saveOnboardingResult(languageCode: 'en');
    row = await db.select(db.appSettings).getSingle();
    expect(row.languageCode, 'en');
  });

  test('readSettings kayıt yokken null, sonra değeri verir', () async {
    final repo = SettingsRepository(db);

    expect(await repo.readSettings(), isNull);

    await repo.saveOnboardingResult(languageCode: 'tr');
    expect((await repo.readSettings())?.languageCode, 'tr');
  });

  test(
    'appLocaleProvider: kayıt yokken null, tr kaydıyla Locale(tr)',
    () async {
      final repo = SettingsRepository(db);
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);

      // Kurulum öncesi: cihaz dili (null).
      await container.read(appSettingsProvider.future);
      expect(container.read(appLocaleProvider), isNull);

      await repo.saveOnboardingResult(languageCode: 'tr');
      container.invalidate(appSettingsProvider);
      await container.read(appSettingsProvider.future);
      expect(container.read(appLocaleProvider), const Locale('tr'));

      await repo.saveOnboardingResult(languageCode: 'en');
      container.invalidate(appSettingsProvider);
      await container.read(appSettingsProvider.future);
      expect(container.read(appLocaleProvider), const Locale('en'));
    },
  );

  test('appLocaleProvider: desteklenmeyen kayıt null döner', () async {
    final repo = SettingsRepository(db);
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(container.dispose);

    await repo.saveOnboardingResult(languageCode: 'xx');
    await container.read(appSettingsProvider.future);
    expect(container.read(appLocaleProvider), isNull);
  });
}
