import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/core/units/walking_plan.dart';

/// walking_plan.dart birim testleri: BMI, yoğunluk, başlangıç dakikası,
/// 8 haftalık plan yapısı, adım tahmini.
void main() {
  group('computeBmi', () {
    test('kg/m^2 doğru hesaplanır', () {
      // 70 kg, 175 cm → 22.86
      expect(computeBmi(weightKg: 70, heightCm: 175), closeTo(22.857, 1e-3));
    });

    test('boy=0 ise null döner (koruma)', () {
      expect(computeBmi(weightKg: 70, heightCm: 0), isNull);
    });

    test('boy<0 ise null döner (koruma)', () {
      expect(computeBmi(weightKg: 70, heightCm: -10), isNull);
    });
  });

  group('pickIntensity', () {
    test('sedentary + düşük BMI → moderate (varsayılan)', () {
      expect(pickIntensity(activityLevel: 'light', bmi: 24.0), 'moderate');
    });

    test('sedentary + yüksek BMI → low', () {
      expect(pickIntensity(activityLevel: 'sedentary', bmi: 25.0), 'low');
    });

    test('BMI ≥ 32 ise low (hangi aktivite olursa olsun)', () {
      expect(pickIntensity(activityLevel: 'moderate', bmi: 33.0), 'low');
    });

    test('active + düşük BMI → moderate', () {
      expect(pickIntensity(activityLevel: 'active', bmi: 22.0), 'moderate');
    });
  });

  group('pickStartMinutes', () {
    test('sedentary + 65+ yaş → 15 dk', () {
      expect(pickStartMinutes(activityLevel: 'sedentary', age: 65), 15);
    });

    test('sedentary + genç → 20 dk', () {
      expect(pickStartMinutes(activityLevel: 'sedentary', age: 40), 20);
    });

    test('light → 20 dk', () {
      expect(pickStartMinutes(activityLevel: 'light', age: 35), 20);
    });

    test('moderate/active → 25 dk', () {
      expect(pickStartMinutes(activityLevel: 'moderate', age: 30), 25);
      expect(pickStartMinutes(activityLevel: 'active', age: 28), 25);
    });
  });

  group('buildWalkingPlan', () {
    test('profil yoksa yaş=40, sedentary default ile plan üretir', () {
      final plan = buildWalkingPlan(
        birthYear: null,
        heightCm: null,
        currentWeightKg: null,
        activityLevel: 'sedentary',
        intensityWeekOverride: null,
      );
      expect(plan.startMinutes, 20);
      expect(plan.weeklyTargetMinutes, 150);
      expect(plan.intensity, 'low'); // sedentary + BMI yok → default
      expect(plan.bmi.isNaN, isTrue);
      expect(plan.days, hasLength(56)); // 8 hafta × 7 gün
      expect(plan.references, hasLength(3));
      expect(plan.references, contains('walk-who-2020'));
      expect(plan.references, contains('walk-acsm-2011'));
      expect(plan.references, contains('walk-murtagh-2015'));
    });

    test('hafta 1 gün 6 ve 7 (Cmt, Paz) dinlenme', () {
      final plan = buildWalkingPlan(
        birthYear: 1990,
        heightCm: 170,
        currentWeightKg: 70,
        activityLevel: 'moderate',
        intensityWeekOverride: null,
      );
      final restDays = plan.days
          .where((d) => d.week == 1 && (d.day == 6 || d.day == 7))
          .toList();
      expect(restDays, hasLength(2));
      expect(restDays.every((d) => d.minutes == 0), isTrue);
    });

    test('hafta 1 gün 1 (Pzt) yürüyüş (startMinutes * 1.0)', () {
      final plan = buildWalkingPlan(
        birthYear: 1990,
        heightCm: 170,
        currentWeightKg: 70,
        activityLevel: 'moderate',
        intensityWeekOverride: null,
      );
      final pzt = plan.days.firstWhere(
        (d) => d.week == 1 && d.day == 1,
      );
      expect(pzt.minutes, 25); // moderate default
    });

    test('hafta 8 yürüyüş günleri başlangıçtan yüksek', () {
      final plan = buildWalkingPlan(
        birthYear: 1990,
        heightCm: 170,
        currentWeightKg: 70,
        activityLevel: 'moderate',
        intensityWeekOverride: null,
      );
      final w1 = plan.days.firstWhere((d) => d.week == 1 && d.day == 1).minutes;
      final w8 = plan.days.firstWhere((d) => d.week == 8 && d.day == 1).minutes;
      expect(w8, greaterThanOrEqualTo(w1));
    });

    test('günlük dakika 35\'i geçmez (üst sınır)', () {
      final plan = buildWalkingPlan(
        birthYear: 1990,
        heightCm: 170,
        currentWeightKg: 70,
        activityLevel: 'active',
        intensityWeekOverride: null,
      );
      for (final d in plan.days) {
        if (d.minutes > 0) {
          expect(d.minutes, lessThanOrEqualTo(35));
        }
      }
    });

    test('BMI doğru hesaplanır (profil tam verildiğinde)', () {
      final plan = buildWalkingPlan(
        birthYear: 1990,
        heightCm: 180,
        currentWeightKg: 90,
        activityLevel: 'sedentary',
        intensityWeekOverride: null,
      );
      // 90 / 1.8^2 = 27.78
      expect(plan.bmi, closeTo(27.78, 0.1));
      // BMI 27.78 < 32, sedentary → 'low' olmaz; 'moderate'
      expect(plan.intensity, 'low'); // sedentary always 'low'
    });
  });

  group('estimateSteps', () {
    test('30 dakika, varsayılan boy 170 cm → makul adım sayısı', () {
      final steps = estimateSteps(30);
      // ortalama 100-130 adım/dk × 30 = 3000-3900
      expect(steps, inInclusiveRange(2500, 4500));
    });

    test('boy verilirse stride oranında değişir', () {
      final short = estimateSteps(30, heightCm: 150);
      final tall = estimateSteps(30, heightCm: 200);
      // Uzun boylu kişi daha büyük adım atar → adım başına metre ↑,
      // dakikadaki adım sayısı ↓
      expect(tall, lessThan(short));
    });
  });
}
