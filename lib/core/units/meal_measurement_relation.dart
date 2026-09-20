/// Öğün–ölçüm ilişkisi (MASTER_PROMPT §8.3, T18): saf, deterministik.
///
/// DİL KURALI: ilişki yalnızca ZAMANSALDIR — "Bu öğünden X saat sonra
/// kaydedilen değer". Nedensellik iddiası taşıyan ifadeler yasaktır
/// (liste lint testinde); lint testi T18'de bunu tarar.
library;

/// Analiz penceresi seçenekleri (saat): kullanıcı seçer.
const mealRelationWindowsHours = [1, 2, 3, 4];
const int defaultRelationWindowHours = 2;

class MealReference {
  const MealReference({required this.id, required this.atUtc});

  final int id;
  final DateTime atUtc;
}

/// Bir ölçümün en yakın ÖNCEKİ öğünü (pencere içinde).
///
/// Pencere dışı/öğün yok → null (ilişki kurulmaz, hiçbir çıkarım
/// yapılmaz).
MealReference? nearestPreviousMeal({
  required DateTime measuredAtUtc,
  required List<MealReference> meals,
  int windowHours = defaultRelationWindowHours,
}) {
  assert(
    mealRelationWindowsHours.contains(windowHours),
    'pencere 1/2/3/4 saat olmalı',
  );
  MealReference? best;
  for (final meal in meals) {
    if (!meal.atUtc.isBefore(measuredAtUtc)) continue; // yalnız ÖNCEKİ
    final isWithinWindow =
        measuredAtUtc.difference(meal.atUtc).inHours < windowHours;
    if (!isWithinWindow) continue;
    if (best == null || meal.atUtc.isAfter(best.atUtc)) best = meal;
  }
  return best;
}

/// Önceki öğüne göre geçen süreyi saat olarak döner (1 ondalık gösterim
/// için; ara yuvarlama yok).
double hoursAfter(MealReference meal, DateTime measuredAtUtc) =>
    measuredAtUtc.difference(meal.atUtc).inMinutes / 60.0;

/// Karıştırıcı etkenler eğitim kartı içeriği (MASTER §8.3): ilişkinin
/// yorumlanmasını etkileyebilecek etkenler; neden-sonuç iddiası yok.
const List<(String, String)> confoundingFactors = [
  (
    'Steroid kullanımı glukozu yükseltebilir; ölçüm bağlamına not edin.',
    'Steroids can raise glucose; note the context with your reading.',
  ),
  (
    'Egzersiz ölçüm sonrası değerleri değiştirebilir.',
    'Exercise can change readings taken around activity.',
  ),
  (
    'Uyku kalitesi ve stres ölçümleri etkileyebilir.',
    'Sleep quality and stress can affect readings.',
  ),
  (
    'Hastalık dönemlerinde değerler sıra dışı olabilir.',
    'During illness readings may look unusual.',
  ),
  (
    'Ölçüm hatası (eller, şerit, cihaz) mümkündür; şüphede tekrar ölçün.',
    'Measurement error (hands, strips, device) is possible; retest if in doubt.',
  ),
];
