import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/core/units/energy.dart';
import 'package:n_keto_tracker/features/onboarding/onboarding_controller.dart';

/// T21 enerji tahmini testleri (MASTER_PROMPT §7, §16.1): iki katsayı,
/// aktivite çarpanı, kapsam dışı ret.
void main() {
  test('erkek katsayısı (+5): 70 kg, 170 cm, 30 yaş → REE 1648', () {
    final ree = restingEnergy(
      weightKg: 70,
      heightCm: 170,
      age: 30,
      coefficient: EnergyCoefficient.male2025,
    );
    // 700 + 1062.5 - 150 + 5 = 1617.5
    expect(ree, closeTo(1617.5, 1e-9));
  });

  test('kadın katsayısı (−161): 60 kg, 160 cm, 30 yaş → REE 1364', () {
    final ree = restingEnergy(
      weightKg: 60,
      heightCm: 160,
      age: 30,
      coefficient: EnergyCoefficient.female161,
    );
    // 600 + 1000 - 150 - 161 = 1289
    expect(ree, closeTo(1289, 1e-9));
  });

  test('TDEE: REE × aktivite katsayısı (moderate 1.55)', () {
    final ree = restingEnergy(
      weightKg: 70,
      heightCm: 170,
      age: 30,
      coefficient: EnergyCoefficient.male2025,
    );
    final tdee = totalEnergy(ree: ree, activityLevel: 'moderate');
    expect(tdee, closeTo(1617.5 * 1.55, 1e-9));
  });

  test('bilinmeyen aktivite düzeyi ArgumentError', () {
    expect(
      () => totalEnergy(ree: 1600, activityLevel: 'superhuman'),
      throwsA(isA<ArgumentError>()),
    );
  });

  test('kapsam dışı: 18 yaş altı, katsayı atlandı, gebelik — hesap yok', () {
    expect(
      () => restingEnergy(
        weightKg: 50,
        heightCm: 160,
        age: 16,
        coefficient: EnergyCoefficient.male2025,
      ),
      throwsA(isA<EnergyEstimateNotAllowed>()),
    );
    expect(
      () => restingEnergy(
        weightKg: 50,
        heightCm: 160,
        age: 30,
        coefficient: EnergyCoefficient.skipped,
      ),
      throwsA(isA<EnergyEstimateNotAllowed>()),
    );
    expect(
      isEligibleForEstimate(
        age: 30,
        coefficient: EnergyCoefficient.female161,
        pregnantOrBreastfeeding: true,
      ),
      isFalse,
    );
    expect(
      isEligibleForEstimate(
        age: null,
        coefficient: EnergyCoefficient.male2025,
        pregnantOrBreastfeeding: false,
      ),
      isFalse,
    );
  });
}
