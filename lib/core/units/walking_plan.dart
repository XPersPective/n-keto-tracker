/// Kişiye uygun yürüyüş planı üretici (MASTER_PROMPT §4.8, PB-026/PB-029).
///
/// ## Kaynaklı olan sayılar (doğrulanmış, `assets/seed/evidence.json`)
///
/// - **Haftada 150–300 dk orta yoğunluklu aerobik aktivite** — WHO 2020
///   fiziksel aktivite rehberi (`walk-who-2020`, PMID 33239350). Planda
///   `weeklyTargetMinutes` bu bandın ALT SINIRI olarak 150 kullanılır.
/// - **Haftada 5 gün aerobik aktivite** — ACSM 2011 pozisyon bildirgesi
///   (`walk-acsm-2011`, PMID 21694556). 5 yürüyüş + 2 dinlenme günü bu
///   yapıdan gelir.
/// - **Pedometer tabanlı yürüyüş programları orta düzeyde kilo kaybı
///   sağlar** — Richardson 2008 meta-analizi (`walk-richardson-2008`,
///   PMID 18195317), havuzlanmış −1.27 kg.
///
/// ## Kaynaklı OLMAYAN, sezgisel seçim olan sayılar
///
/// Aşağıdaki değerlerin hiçbirini bir kılavuz ya da meta-analiz
/// doğrulamaz; uygulama çalışması için makul başlangıç noktaları olarak
/// seçilmiştir:
///
/// - haftalık ilerleme çarpanı `1.0 + 0.12 * (w - 1)` (%12 artış)
/// - `pickStartMinutes` eşikleri (15 / 20 / 25 dk)
/// - `pickIntensity` BMI 32 eşiği
/// - günlük üst sınır `weeklyTargetMinutes ~/ 5 + 5`
///
/// Bu yüzden `WalkingPlan.valuesAreEstimates` her zaman `true` döner ve
/// arayüz bu değerleri "tahmin" olarak etiketler. Kullanıcıyı yanıltmamak
/// (2026-10-13 talimatı) için bu ayrım sözleşmedir: yeni bir sayı eklenirken
/// `sourcedFigures` listesine eklenmezse tahmin sayılır.
library;

/// Bir günün aktivite reçetesi.
enum ActivityType {
  /// Orta yoğunluklu aerobik yürüyüş (ACSM 2011: ≥5 gün/hafta).
  walking,

  /// Direnç + nöromotor çalışma (ACSM 2011: 2-3 gün/hafta).
  strength,

  /// Aktif dinlenme — bu planda kullanılmaz, ileriye dönük.
  rest,
}

/// Bir günün aktivite reçetesi.
class WalkingDay {
  const WalkingDay({
    required this.week,
    required this.day,
    required this.minutes,
    this.activity = ActivityType.walking,
  });

  final int week; // 1..8
  final int day; // 1..7 (Pzt=1..Paz=7)

  /// Yürüyüş günlerinde dakika; kuvvet günlerinde 0.
  final int minutes;

  /// Günün aktivite türü. Varsayılan: yürüyüş.
  final ActivityType activity;

  bool get isWalking => activity == ActivityType.walking;
  bool get isStrength => activity == ActivityType.strength;
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
    this.valuesAreEstimates = true,
    this.sourcedFigures = kSourcedFigures,
  });

  /// Hafta 1'in başlangıç dakikası (gün başına) — **tahmin**.
  final int startMinutes;

  /// WHO 2020 bandının alt sınırı (150 dk/hafta) — **kaynaklı**.
  final int weeklyTargetMinutes;

  /// BMI (kg/m²); profil yoksa `double.nan`.
  final double bmi;

  /// 'low' | 'moderate' — başlangıç yoğunluğu, **tahmin**.
  final String intensity;

  /// 8 × 7 = 56 günlük gün listesi.
  final List<WalkingDay> days;

  /// Kanıt referans kimlikleri (`assets/seed/evidence.json` ile eşleşir).
  final List<String> references;

  /// Plandaki kişisel değerlerin kaynaktan gelmediğini belirtir. Arayüz bu
  /// alanı okuyup "tahmin" notu gösterir.
  final bool valuesAreEstimates;

  /// Planda gerçekten kaynağa dayanan sayıların açıklaması.
  final List<String> sourcedFigures;
}

/// Planda kullanılan, doğrulanmış kaynaklara dayanan sayılar.
const List<String> kSourcedFigures = <String>[
  '150-300 min/week moderate aerobic activity (WHO 2020)',
  '30 min/day on >=5 days/week, >=150 min/week (ACSM 2011)',
  'Resistance training 2-3 days/week, each major muscle group (ACSM 2011)',
  'Neuromotor exercise - balance, agility, coordination - 2-3 days/week '
      '(ACSM 2011)',
  'Flexibility: 60 s per exercise, >=2 days/week (ACSM 2011)',
];

/// Kuvvet günü protokolü.
///
/// ACSM 2011 her büyük kas grubunu haftada 2-3 gün çalıştırmayı önerir;
/// **set sayısını** belirtmez. Aşağıdaki "2 set" sezgisel bir öneridir ve
/// kaynaklı değildir (PB-032).
const String kStrengthProtocol =
    '2 sets per major muscle group (set count is an estimate; ACSM 2011 '
    'specifies frequency, not set count)';

/// BMI sınıflandırması (WHO): <18.5 düşük, 18.5–24.9 normal, 25–29.9
/// fazla kilolu, ≥30 obez.
double? computeBmi({required double weightKg, required double heightCm}) {
  if (heightCm <= 0) return null;
  final m = heightCm / 100.0;
  return weightKg / (m * m);
}

/// Başlangıç yoğunluğu — **sezgisel**, kaynaklı değil (PB-029).
///
/// Hareketsiz (sedentary) ya da BMI ≥ 32 ise daha düşük bir başlangıç,
/// aksi hâlde orta yoğunluk. Eşikler uygulama çalışması için seçilmiştir;
/// hiçbir kılavuz bu sayıyı önermez.
String pickIntensity({required String activityLevel, required double? bmi}) {
  if (activityLevel == 'sedentary' || (bmi != null && bmi >= 32)) {
    return 'low';
  }
  return 'moderate';
}

/// Hafta 1 günlük başlangıç dakikası — **sezgisel**, kaynaklı değil
/// (PB-029). Değerler makul bir başlangıç aralığı seçer, kılavuz önerisi
/// değildir.
int pickStartMinutes({required String activityLevel, required int age}) {
  if (activityLevel == 'sedentary') return age >= 60 ? 15 : 20;
  if (activityLevel == 'light') return 20;
  return 25;
}

/// Doğum yılından yaş. Doğum günü bu yıl henüz gelmediyse yaş bir küçüktür.
int ageFromBirthYear(int birthYear, {DateTime? now}) {
  final today = now ?? DateTime.now();
  var age = today.year - birthYear;
  // 1 Ocak kabulü: gün bilgisi yok, yıl farkı kullanılır.
  return age < 0 ? 0 : age;
}

/// 8 haftalık plan üret.
///
/// [birthYear], [heightCm], [currentWeightKg] ve [activityLevel] onboarding
/// profilinden gelir; hiçbiri yoksa yaş 40 / sedentary varsayılanı
/// kullanılır ve `bmi` `double.nan` olur.
WalkingPlan buildWalkingPlan({
  required int? birthYear,
  required double? heightCm,
  required double? currentWeightKg,
  required String activityLevel,
}) {
  final age = birthYear == null ? 40 : ageFromBirthYear(birthYear);
  final bmi = (heightCm != null && currentWeightKg != null)
      ? computeBmi(weightKg: currentWeightKg, heightCm: heightCm)
      : null;
  final intensity = pickIntensity(activityLevel: activityLevel, bmi: bmi);
  final start = pickStartMinutes(activityLevel: activityLevel, age: age);

  // WHO 2020 haftalık bandının alt sınırı — kaynaklı.
  const target = 150;

  final days = <WalkingDay>[];
  for (var w = 1; w <= 8; w++) {
    // Sezgisel %12 haftalık ilerleme; günlük tavan da sezgisel.
    final factor = 1.0 + 0.12 * (w - 1);
    final daily = (start * factor).round().clamp(start, target ~/ 5 + 5);
    // ACSM 2011: haftada ≥5 aerobik gün + 2-3 direnç/nöromotor günü.
    // Cmt ve Paz kuvvet günü olarak ayrıldı (eski hâlde boştu).
    for (var d = 1; d <= 7; d++) {
      final isStrengthDay = d == 6 || d == 7;
      days.add(
        WalkingDay(
          week: w,
          day: d,
          minutes: isStrengthDay ? 0 : daily,
          activity: isStrengthDay ? ActivityType.strength : ActivityType.walking,
        ),
      );
    }
  }

  return WalkingPlan(
    startMinutes: start,
    weeklyTargetMinutes: target,
    bmi: bmi ?? double.nan,
    intensity: intensity,
    days: days,
    references: const [
      'walk-who-2020',
      'walk-acsm-2011',
      'walk-richardson-2008',
      'walk-swift-2018',
    ],
  );
}

/// Adım sayısı tahmini (boy × 0.45 stride, 1.4 m/s orta yürüyüş —
/// en.wikipedia/pedometer varsayımlarına dayalı **tahmin**, ölçüm değil).
int estimateSteps(int minutes, {double? heightCm}) {
  final stride = (heightCm ?? 170) / 100 * 0.45; // m
  final stepsPerMin = (1.4 / stride) * 60;
  return (stepsPerMin * minutes).round();
}