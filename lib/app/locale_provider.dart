import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/database/settings_repository.dart';
import 'l10n/generated/app_localizations.dart';
import 'l10n/language_names.dart';

/// Kayıtlı dil tercihinin yerel ayara çözümlenmesi (ORTAK §3.1).
///
/// Onboarding'de seçilen dil AppSettings'e yazılır; buradan okunup
/// [Locale]'e çevrilir. Kayıt yokken null döner — MaterialApp o zaman
/// cihaz dilini kullanır (ilk açılış: cihaz dili; ORTAK §3.1).
/// Desteklenmeyen bir kayıt gelirse de cihaz diline düşer.
final appLocaleProvider = Provider<Locale?>((ref) {
  final settings = ref.watch(appSettingsProvider).value;
  final code = settings?.languageCode;
  if (code == null || code.isEmpty) return null;
  final locale = localeFromCode(code);
  if (!AppLocalizations.supportedLocales.contains(locale)) return null;
  return locale;
});

/// Kayıtlı tema tercihi ('light' | 'dark'; kayıt yoksa sistem).
final appThemeModeProvider = Provider<ThemeMode>((ref) {
  final mode = ref.watch(appSettingsProvider).value?.themeMode;
  return switch (mode) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };
});
