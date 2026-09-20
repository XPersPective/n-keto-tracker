import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Formül tekrar yasağı (MASTER_PROMPT §2.4): GKI ve mg/dL→mmol/L
/// dönüşümü yalnızca `lib/core/units/` içinde tanımlanır; lib'in başka
/// hiçbir dosyasında aynı hesap ifadesi geçemez. UI/grafik/export motoru
/// çağırmak zorundadır.
void main() {
  test('formül ifadesi yalnız core/units içinde', () {
    final allowed = [
      'lib/core/units/gki.dart',
      'lib/core/units/glucose.dart',
      'lib/core/units/formula_version.dart',
    ];
    // Bölme ifadeleri: sabit tanımı ve kullanımı yalnız units'te.
    final patterns = [RegExp(r'/\s*18\.0\b'), RegExp(r'glucoseMgDlToMmolL')];

    final libDir = Directory('lib');
    final offenders = <String>[];
    for (final file in libDir.listSync(recursive: true).whereType<File>()) {
      final path = file.path.replaceAll('\\', '/');
      if (!path.endsWith('.dart')) continue;
      if (allowed.any(path.endsWith)) continue;
      final source = file.readAsStringSync();
      for (final p in patterns) {
        if (p.hasMatch(source)) {
          offenders.add('$path: ${p.pattern}');
        }
      }
    }
    expect(
      offenders,
      isEmpty,
      reason:
          'GKI/birim dönüşümü yalnız lib/core/units içinde olabilir; '
          'şunları lib/core/units/gki.dart API\'siyle değiştir: $offenders',
    );
  });
}
