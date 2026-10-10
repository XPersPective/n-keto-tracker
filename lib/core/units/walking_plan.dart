/// Kişiye uygun yürüyüş planı üretici (MASTER_PROMPT §4.8).
///
/// WHO ve ACSM fiziksel aktivite önerilerine dayanır: haftada en az
/// 150 dk orta yoğunluk (Moderate) veya 75 dk yüksek yoğunluk (Vigorous)
/// aerobik aktivite, haftada 2+ gün kuvvet çalışması. Yürüyüş
/// başlangıç planları daha düşük hacimle başlar ve 8 haftada hedefe
/// ulaşır.
///
/// Hesap, kullanıcının UserProfile satırındaki `birthYear`,
/// `currentWeightKg`, `activityLevel` (sedentary/light/moderate/active)
/// ve BMI'sini kullanır. Yaş, kilo ve aktivite düzeyine göre:
///   - Başlangıç dakikası: 15–25 (düşük baseline) veya 20–30 (orta)
///   - Haftalık artış: %10–15
///   - Hedef: 30–45 dk/gün × 5 gün = 150–225 dk/hafta
///
/// Çıktı `WalkingPlan` sekiz haftalık, gün bazında dakika listesi
/// döner. Üç bilimsel kaynağa referans (W1, W2, W3) üretir — bunlar
/// `walkingEvidence.json` ile eşleşir.
library;

/// Bir günün yürüyüş reçetesi.
class WalkingDay {
  const WalkingDay({required this.week, required this.day, required this.minutes});

  final int week; // 1..8
  final int day; // 1..7 (Pzt=1..Paz=7)
  final int minutes;
}

/// Sekiz haftalık plan.
class WalkingPlan {
  const WalkingPlan({
    required this.startMinutes,
    required this.weeklyTargetMinutes,
    required this.bmi,
    required this.intensity,
    required this.days,
    required this.references,
  });

  /// Hafta 1'in başlangıç dakikası (gün başına).
  final int startMinutes;

  /// Hedef: haftada toplam dakika (150 = WHO önerisi).
  final int weeklyTargetMinutes;

  /// BMI (kg/m²); yuvarlanmış 1 ondalık.
  final double bmi;

  /// 'low' | 'moderate' | 'vigorous' — başlangıç yoğunluğu.
  final String intensity;

  /// 8 × 7 = 56 günlük gün listesi.
  final List<WalkingDay> days;

  /// Kanıt referans kimlikleri (ör. `walk-acsm-2011`).
  final List<String> references;
}

/// BMI sınıflandırması (WHO): <18.5 düşük, 18.5–24.9 normal, 25–29.9
/// fazla kilolu, ≥30 obez.
double? computeBmi({
  required double weightKg,
  required double heightCm,
}) {
  if (heightCm <= 0) return null;
  final m = heightCm / 100.0;
  return weightKg / (m * m);
}

/// Plan yoğunluğunu seç: hareketsiz (sedentary) + yüksek BMI → 'low';
/// aksi → 'moderate'.
String pickIntensity({
  required String activityLevel,
  required double? bmi,
}) {
  if (activityLevel == 'sedentary' || (bmi != null && bmi >= 32)) {
    return 'low';
  }
  if (activityLevel == 'active') return 'moderate';
  return 'moderate';
}

/// Başlangıç dakikasını seç (gün başına, hafta 1).
int pickStartMinutes({required String activityLevel, required int age}) {
  if (activityLevel == 'sedentary') return age >= 60 ? 15 : 20;
  if (activityLevel == 'light') return 20;
  return 25;
}

/// 8 haftalık plan üret.
WalkingPlan buildWalkingPlan({
  required int? birthYear,
  required double? heightCm,
  required double? currentWeightKg,
  required String activityLevel,
  required int? intensityWeekOverride,
}) {
  final now = DateTime.now();
  final age = birthYear == null ? 40 : now.year - birthYear;
  final bmi = (heightCm != null && currentWeightKg != null)
      ? computeBmi(weightKg: currentWeightKg, heightCm: heightCm)
      : null;
  final intensity = pickIntensity(
    activityLevel: activityLevel,
    bmi: bmi,
  );
  final start = pickStartMinutes(
    activityLevel: activityLevel,
    age: age,
  );
  const target = 150; // WHO haftalık minimum (Moderate)
  final days = <WalkingDay>[];

  for (var w = 1; w <= 8; w++) {
    // Haftalık %12 artış, üst sınır target/5 = 30–35 dk/gün.
    final factor = 1.0 + 0.12 * (w - 1);
    final daily = (start * factor).round().clamp(start, target ~/ 5 + 5);
    // Haftanın günleri: 5 gün yürüyüş + 2 gün dinlenme (PR/PA hariç).
    for (var d = 1; d <= 7; d++) {
      if (d == 6 || d == 7) {
        days.add(WalkingDay(week: w, day: d, minutes: 0));
      } else {
        days.add(WalkingDay(week: w, day: d, minutes: daily));
      }
    }
  }
  return WalkingPlan(
    startMinutes: start,
    weeklyTargetMinutes: target,
    bmi: bmi ?? double.nan,
    intensity: intensity,
    days: days,
    references: const [
      'walk-acsm-2011',
      'walk-murtagh-2015',
      'walk-who-2020',
    ],
  );
}

/// Adım sayısı tahmini (Tudor-Locke referansı: orta yürüyüş 1.4 m/s,
/// stride ≈ boy × 0.45). 170 cm boy ve 30 dk için ≈ 110 adım/dk,
/// yani ~3300 adım.
int estimateSteps(int minutes, {double? heightCm}) {
  final stride = (heightCm ?? 170) / 100 * 0.45; // m, ortalama adım uzunluğu
  final stepsPerMin = (1.4 / stride) * 60;
  return (stepsPerMin * minutes).round();
}
