/// Ağırlık normalize ve değişim penceresi (MASTER_PROMPT §11.1, T22).
///
/// Dil kuralı: rozet/seri/kilo baskısı yok; yetersiz veride trend
/// GÖSTERİLMEZ (null). Değerler nötr; tanı/uyarı yok.
library;

/// 1 lb = 0,45359237 kg (uluslararası avoirdupois pound tanımı).
const double lbToKgFactor = 0.45359237;

double lbToKg(double lb) => lb * lbToKgFactor;

double kgToLb(double kg) => kg / lbToKgFactor;

/// Ağırlık girdisi: ham değer + birim + normalize kg.
class WeightValue {
  const WeightValue._({
    required this.rawValue,
    required this.unit,
    required this.kg,
  });

  final double rawValue;
  final String unit; // 'kg' | 'lb'
  final double kg;

  static WeightValue fromRaw(double value, String unit) {
    assert(value > 0, 'ağırlık pozitif olmalı');
    assert(unit == 'kg' || unit == 'lb');
    final kg = unit == 'lb' ? lbToKg(value) : value;
    return WeightValue._(rawValue: value, unit: unit, kg: kg);
  }
}

/// Değişim penceresi sonucu; yetersiz veride null (trend gösterilmez).
class WeightChange {
  const WeightChange({
    required this.startKg,
    required this.endKg,
    required this.diffKg,
    required this.days,
  });

  final double startKg;
  final double endKg;
  final double diffKg;
  final int days;
}

/// Bir penceredeki (son [days] gün) değişim: ilk ve son ölçüm farkı.
///
/// YETERSİZ VERİ KURALI: pencerede ≥2 ölçüm yoksa null — trend
/// uydurulmaz (MASTER §11.1).
WeightChange? changeOverWindow({
  required List<(DateTime, double)> entriesKg,
  required int days,
  required DateTime nowUtc,
}) {
  assert(days > 0);
  final cutoff = nowUtc.subtract(Duration(days: days));
  final inWindow = entriesKg.where((e) => !e.$1.isBefore(cutoff)).toList()
    ..sort((a, b) => a.$1.compareTo(b.$1));
  if (inWindow.length < 2) return null;
  final start = inWindow.first;
  final end = inWindow.last;
  return WeightChange(
    startKg: start.$2,
    endKg: end.$2,
    diffKg: end.$2 - start.$2,
    days: days,
  );
}
