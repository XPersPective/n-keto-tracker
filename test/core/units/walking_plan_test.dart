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
      );
      expect(plan.startMinutes, 20);
      expect(plan.weeklyTargetMinutes, 150);
      expect(plan.intensity, 'low'); // sedentary + BMI yok → default
      expect(plan.bmi.isNaN, isTrue);
      expect(plan.days, hasLength(56)); // 8 hafta × 7 gün
      expect(plan.references, hasLength(4));
      expect(plan.references, contains('walk-who-2020'));
      expect(plan.references, contains('walk-acsm-2011'));
      expect(plan.references, contains('walk-richardson-2008'));
      expect(plan.references, contains('walk-swift-2018'));
    });

    test('hafta 1 gün 6 ve 7 (Cmt, Paz) kuvvet gunu', () {
      final plan = buildWalkingPlan(
        birthYear: 1990,
        heightCm: 170,
        currentWeightKg: 70,
        activityLevel: 'moderate',
      );
      final weekend = plan.days
          .where((d) => d.week == 1 && (d.day == 6 || d.day == 7))
          .toList();
      expect(weekend, hasLength(2));
      // PB-032: hafta sonu artik bos degil, ACSM 2011 direnc oneri.
      expect(weekend.every((d) => d.isStrength), isTrue);
      expect(weekend.every((d) => d.minutes == 0), isTrue);
    });

    // PB-032: her hafta tam olarak 5 yuruyus + 2 kuvvet gunu.
    test('her hafta 5 yuruyus + 2 kuvvet gunu', () {
      final plan = buildWalkingPlan(
        birthYear: 1990,
        heightCm: 170,
        currentWeightKg: 70,
        activityLevel: 'light',
      );
      for (var w = 1; w <= 8; w++) {
        final week = plan.days.where((d) => d.week == w).toList();
        expect(week, hasLength(7), reason: 'hafta $w');
        expect(
          week.where((d) => d.isWalking),
          hasLength(5),
          reason: 'hafta $w yuruyus',
        );
        expect(
          week.where((d) => d.isStrength),
          hasLength(2),
          reason: 'hafta $w kuvvet',
        );
      }
    });

    test('kaynak listesi ACSM kuvvet ve esneme onerilerini icerir', () {
      expect(kSourcedFigures, hasLength(greaterThanOrEqualTo(5)));
      final joined = kSourcedFigures.join(' ');
      expect(joined, contains('Resistance training 2-3 days/week'));
      expect(joined, contains('60 s per exercise'));
      expect(joined, contains('Neuromotor'));
      expect(kStrengthProtocol, isNotEmpty);
      expect(kStrengthProtocol, contains('ACSM 2011'));
    });

    test('hafta 1 gün 1 (Pzt) yürüyüş (startMinutes * 1.0)', () {
      final plan = buildWalkingPlan(
        birthYear: 1990,
        heightCm: 170,
        currentWeightKg: 70,
        activityLevel: 'moderate',
      );
      final pzt = plan.days.firstWhere((d) => d.week == 1 && d.day == 1);
      expect(pzt.minutes, 25); // moderate default
    });

    test('hafta 8 yürüyüş günleri başlangıçtan yüksek', () {
      final plan = buildWalkingPlan(
        birthYear: 1990,
        heightCm: 170,
        currentWeightKg: 70,
        activityLevel: 'moderate',
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
      );
      // 90 / 1.8^2 = 27.78
      expect(plan.bmi, closeTo(27.78, 0.1));
      // BMI 27.78 < 32, sedentary → 'low' olmaz; 'moderate'
      expect(plan.intensity, 'low'); // sedentary always 'low'
    });
  });

  // PB-029: kullanıcıyı yanıltmayacak şekilde kaynak/estim ayrımı.
  group('kaynak şeffaflığı', () {
    test('valuesAreEstimates her zaman true', () {
      for (final level in ['sedentary', 'light', 'moderate', 'active']) {
        final plan = buildWalkingPlan(
          birthYear: 1990,
          heightCm: 175,
          currentWeightKg: 80,
          activityLevel: level,
        );
        expect(plan.valuesAreEstimates, isTrue, reason: level);
      }
    });

    test('sourcedFigures yalnız doğrulanmış kaynakları içerir', () {
      expect(kSourcedFigures, isNotEmpty);
      // Uydurma kaynak (PB-028'de silindi) hiçbir yerde geçmemeli.
      for (final fig in kSourcedFigures) {
        expect(fig.contains('Murtagh'), isFalse, reason: fig);
      }
      expect(
        kSourcedFigures.join(' '),
        anyOf(contains('WHO 2020'), contains('ACSM 2011')),
      );
    });

    test('referanslar yalnız doğrulanmış kaynak kimlikleridir', () {
      final plan = buildWalkingPlan(
        birthYear: 1990,
        heightCm: 175,
        currentWeightKg: 80,
        activityLevel: 'light',
      );
      expect(plan.references, isNot(contains('walk-murtagh-2015')));
      expect(
        plan.references,
        everyElement(
          anyOf(
            startsWith('walk-who-'),
            startsWith('walk-acsm-'),
            startsWith('walk-richardson-'),
            startsWith('walk-swift-'),
          ),
        ),
      );
    });

    test('ageFromBirthYear gelecek yıl için 0 döner', () {
      final nextYear = DateTime.now().year + 1;
      expect(ageFromBirthYear(nextYear), 0);
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
