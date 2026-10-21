/// Hareket kaydının DSÖ 2020 haftalık hedefine katkısı.
///
/// Kaynak: WHO 2020 fiziksel aktivite rehberi (`walk-who-2020`, PMID 33239350):
/// haftada en az 150 dk orta yoğunluk veya 75 dk yoğun yoğunluk aerobik
/// aktivite. Yoğun 1 dk = orta 2 dk eşdeğeri olarak sayılır; bu nedenle koşu
/// dakikası iki kat, yürüyüş ve diğer dakikalar bir kat sayılır.
///
/// Kuvvet çalışması aerobik hedefe SAYILMAZ (rehber ayrı tutar).
library;

/// Haftalık aerobik hedefin alt sınırı (dakika, orta yoğunluk eşdeğeri).
const int weeklyAerobicTargetMinutes = 150;

/// Bir kaydın aerobik eşdeğer dakikası.
int aerobicEquivalentMinutes({
  required String kind,
  required int durationMinutes,
}) {
  switch (kind) {
    case 'run':
      return durationMinutes * 2;
    case 'walk':
    case 'other':
      return durationMinutes;
    default:
      // 'strength' ve bilinmeyen türler aerobik hedefe sayılmaz.
      return 0;
  }
}

/// Kayıt listesinin toplam aerobik eşdeğer dakikası.
int totalAerobicMinutes(
  Iterable<({String kind, int durationMinutes})> sessions,
) {
  var total = 0;
  for (final s in sessions) {
    total += aerobicEquivalentMinutes(
      kind: s.kind,
      durationMinutes: s.durationMinutes,
    );
  }
  return total;
}
