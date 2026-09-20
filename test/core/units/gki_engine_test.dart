import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/core/units/formula_version.dart';
import 'package:n_keto_tracker/core/units/gki.dart';
import 'package:n_keto_tracker/core/units/glucose.dart';

/// GKI motoru testleri — MASTER_PROMPT §2.4/§16.1.
///
/// Referans vektörleri `test/fixtures/gki_reference_cases.json` (T2'de
/// doğrulandı) parametreli test olarak koşar.
void main() {
  final fixture = jsonDecode(
    File('test/fixtures/gki_reference_cases.json').readAsStringSync(),
  ) as Map<String, dynamic>;
  final cases = (fixture['cases'] as List).cast<Map<String, dynamic>>();

  group('referans vektörleri (gki_reference_cases.json)', () {
    test('fixture en az 12 vektör içerir', () {
      expect(cases.length, greaterThanOrEqualTo(12));
    });

    test('fixture formül sürümü motorla eşleşir', () {
      expect(fixture['formulaVersion'], formulaVersion);
    });

    for (final c in cases) {
      final id = c['id'] as String;
      final glucose = c['glucose'] as Map<String, dynamic>;
      final bhbRaw = c['bhbMmolL'];

      test('$id: ${c['description']}', () {
        final glucoseRaw = glucose['value'];
        final unit = glucose['unit'] == 'mg_dL'
            ? GlucoseUnit.mgDl
            : GlucoseUnit.mmolL;

        // Girdi çözümleme + hesap akışının tamamı; hata vakalarında bu
        // kapanış expect() içinde koşar (parse istisnası kaçmaz).
        Object? runCase() {
          double resolve(Object? raw) {
            if (raw is num) return raw.toDouble();
            if (raw is String) {
              return switch (raw.trim()) {
                'NaN' => double.nan,
                'Infinity' => double.infinity,
                _ => parseDecimal(raw),
              };
            }
            throw ArgumentError(
              'desteklenmeyen girdi türü: ${raw.runtimeType}',
            );
          }

          final g = GlucoseValue.fromRaw(resolve(glucoseRaw), unit);
          return GkiEngine.fromRaw(glucose: g, bhbMmolL: resolve(bhbRaw));
        }

        // Hata bekleyen vakalar.
        if (c.containsKey('expectError')) {
          expect(
            runCase,
            throwsA(
              isA<Object>().having(
                (e) => e.toString(),
                'hata kodu',
                contains(c['expectError'] as String),
              ),
            ),
          );
          return;
        }

        // Başarı bekleyen vakalar: tam float eşitliği (1e-9 toleranslı).
        final expected = c['expected'] as Map<String, dynamic>;
        final result = runCase()! as GkiResult;
        expect(
          result.glucoseMmolL,
          closeTo(expected['glucoseMmolL'] as num, 1e-9),
        );
        expect(result.value, closeTo(expected['gki'] as num, 1e-9));
        // Her sonuç formül sürümüyle etiketlenir.
        expect(result.formulaVersion, formulaVersion);
      });
    }
  });

  group('ara yuvarlama yasağı', () {
    test('97 mg/dL: ara yuvarlanmış değerle ayrışır', () {
      final g = GlucoseValue.fromRaw(97, GlucoseUnit.mgDl);
      final result = GkiEngine.fromRaw(glucose: g, bhbMmolL: 2.9);
      // Doğru: 485/261 ≈ 1.8582375478927204
      expect(result.value, closeTo(1.8582375478927204, 1e-12));
      // Yanlış (ara yuvarlama 5.4/2.9): 1.8620689655172414
      expect(result.value, isNot(closeTo(1.8620689655172414, 1e-9)));
    });
  });

  group('mmol/L doğrudan giriş', () {
    test('dönüşüm iki kez uygulanmaz', () {
      final g = GlucoseValue.fromRaw(5.0, GlucoseUnit.mmolL);
      expect(g.mmolL, 5.0); // 5/18 DEĞİL
      final result = GkiEngine.fromRaw(glucose: g, bhbMmolL: 2.5);
      expect(result.value, 2.0);
    });
  });

  group('referans vaka: MASTER §2.4', () {
    test('90 mg/dL + 2,5 mmol/L → tam 2,0', () {
      final g = GlucoseValue.fromRaw(90, GlucoseUnit.mgDl);
      expect(g.mmolL, 5.0);
      expect(GkiEngine.fromRaw(glucose: g, bhbMmolL: 2.5).value, 2.0);
    });
  });

  group('parseDecimal (TR/EN ondalık)', () {
    test('virgül, nokta, binlik ayraç ve reddi', () {
      expect(parseDecimal('2,5'), 2.5);
      expect(parseDecimal('2.5'), 2.5);
      expect(parseDecimal(' 1.234,5 '), 1234.5); // TR binlik
      expect(parseDecimal('1,234.5'), 1234.5); // EN binlik
      expect(() => parseDecimal(''), throwsA(isA<GlucoseEmptyInput>()));
      expect(() => parseDecimal('  '), throwsA(isA<GlucoseEmptyInput>()));
      expect(() => parseDecimal('2,5abc'), throwsA(isA<GlucoseNotFinite>()));
    });
  });
}
