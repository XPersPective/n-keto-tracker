import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:n_keto_tracker/app/l10n/generated/app_localizations.dart';
import 'package:n_keto_tracker/app/l10n/language_names.dart';

/// ARB anahtar bütünlüğü (MASTER_PROMPT §3.3/§16.3): TR ve EN çeviri
/// dosyalarının anahtar kümeleri eşit olmalı; hiçbir anahtar boş olmamalı.
void main() {
  final en = _readKeys('lib/app/l10n/app_en.arb');
  final tr = _readKeys('lib/app/l10n/app_tr.arb');

  test('TR ve EN ARB anahtar kümeleri eşit', () {
    final onlyInTr = tr.keys.toSet().difference(en.keys.toSet());
    final onlyInEn = en.keys.toSet().difference(tr.keys.toSet());
    expect(
      onlyInTr.isEmpty && onlyInEn.isEmpty,
      isTrue,
      reason: 'Sadece TR: $onlyInTr / Sadece EN: $onlyInEn',
    );
  });

  test('Hiçbir anahtar boş değer taşımaz', () {
    for (final entry in en.entries) {
      expect(
        entry.value.trim().isNotEmpty,
        isTrue,
        reason: 'EN boş değer: ${entry.key}',
      );
    }
    for (final entry in tr.entries) {
      expect(
        entry.value.trim().isNotEmpty,
        isTrue,
        reason: 'TR boş değer: ${entry.key}',
      );
    }
  });

  test('Tüm diller EN ile aynı anahtar kümesine sahip', () {
    final files = Directory('lib/app/l10n')
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.arb'));
    expect(files.length, greaterThanOrEqualTo(68));
    for (final f in files) {
      final keys = _readKeys(f.path);
      expect(
        keys.keys.toSet(),
        en.keys.toSet(),
        reason: '${f.path} anahtarları EN ile eşit olmalı',
      );
      expect(keys.values.every((v) => v.trim().isNotEmpty), isTrue);
    }
  });

  test('Her ARB dili endonym haritasında ve desteklenen yerel ayarlarda', () {
    final codes = Directory('lib/app/l10n')
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.arb'))
        .map((f) => RegExp(r'app_(.+)\.arb').firstMatch(f.path)!.group(1)!)
        .toSet();
    expect(languageEndonyms.keys.toSet(), codes);
    for (final c in codes) {
      expect(
        AppLocalizations.supportedLocales.contains(localeFromCode(c)),
        isTrue,
        reason: c,
      );
    }
  });

  test('Marka adı her iki dilde aynı', () {
    expect(en['appTitle'], 'N Keto Tracker');
    expect(tr['appTitle'], 'N Keto Tracker');
  });
}

Map<String, String> _readKeys(String path) {
  final raw = jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
  return {
    for (final e in raw.entries)
      if (!e.key.startsWith('@') && e.key != '@@locale')
        e.key: e.value as String,
  };
}
