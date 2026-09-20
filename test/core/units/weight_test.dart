import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/core/units/weight.dart';

/// T22 ağırlık testleri (MASTER_PROMPT §11.1, §16.1): kg/lb normalize,
/// 7/30 değişim, yetersiz veride trend yok.
void main() {
  test('lb → kg: 150 lb = 68,0389 kg', () {
    expect(lbToKg(150), closeTo(68.0389, 1e-4));
    expect(WeightValue.fromRaw(150, 'lb').kg, closeTo(68.0389, 1e-4));
    expect(WeightValue.fromRaw(150, 'lb').rawValue, 150);
    expect(WeightValue.fromRaw(150, 'lb').unit, 'lb');
  });

  test('kg → lb → kg gidiş-dönüş hatasız', () {
    final roundTrip = lbToKg(kgToLb(72.5));
    expect(roundTrip, closeTo(72.5, 1e-9));
  });

  test('kg girişi normalize değişmez', () {
    expect(WeightValue.fromRaw(72.5, 'kg').kg, 72.5);
  });

  test('7 günlük değişim: ilk-son fark', () {
    final now = DateTime.utc(2026, 9, 20, 8);
    final entries = <(DateTime, double)>[
      (now.subtract(const Duration(days: 7)), 75.0),
      (now.subtract(const Duration(days: 3)), 74.2),
      (now, 74.0),
    ];
    final change = changeOverWindow(entriesKg: entries, days: 7, nowUtc: now);
    expect(change, isNotNull);
    expect(change!.diffKg, closeTo(-1.0, 1e-9));
    expect(change.startKg, 75.0);
    expect(change.endKg, 74.0);
  });

  test('yetersiz veri: pencerede tek ölçüm → null (trend yok)', () {
    final now = DateTime.utc(2026, 9, 20, 8);
    final entries = <(DateTime, double)>[
      (now.subtract(const Duration(days: 1)), 74.0),
    ];
    expect(changeOverWindow(entriesKg: entries, days: 7, nowUtc: now), isNull);
  });

  test('pencere dışı eski ölçüler hesaba katılmaz', () {
    final now = DateTime.utc(2026, 9, 20, 8);
    final entries = <(DateTime, double)>[
      (now.subtract(const Duration(days: 40)), 90.0), // pencere dışı
      (now.subtract(const Duration(days: 30)), 75.0),
      (now.subtract(const Duration(days: 1)), 74.5),
      (now, 74.0),
    ];
    final change = changeOverWindow(entriesKg: entries, days: 7, nowUtc: now);
    expect(change!.startKg, 74.5);
  });
}
