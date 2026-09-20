import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/core/units/meal_measurement_relation.dart';

/// T18 öğün-ölçüm ilişkisi testleri (MASTER_PROMPT §8.3): en yakın
/// ÖNCEKİ öğün, pencere 1–4 saat, nedensellik yok.
void main() {
  final breakfast = MealReference(id: 1, atUtc: DateTime.utc(2026, 9, 20, 7));
  final lunch = MealReference(id: 2, atUtc: DateTime.utc(2026, 9, 20, 12));

  test('en yakın önceki öğün seçilir', () {
    final found = nearestPreviousMeal(
      measuredAtUtc: DateTime.utc(2026, 9, 20, 13, 30),
      meals: [breakfast, lunch],
    );
    expect(found!.id, 2); // öğle (1,5 saat önce), kahvaltı değil
  });

  test('öğün SONRASI ölçüm önceki öğüne bağlanmaz', () {
    final found = nearestPreviousMeal(
      measuredAtUtc: DateTime.utc(2026, 9, 20, 6, 0), // kahvaltıdan önce
      meals: [breakfast, lunch],
    );
    expect(found, isNull);
  });

  test('pencere dışı ilişki kurulmaz (null)', () {
    // Öğleden 5 saat sonra — 4 saatlik pencere dışı.
    final found = nearestPreviousMeal(
      measuredAtUtc: DateTime.utc(2026, 9, 20, 17, 0),
      meals: [lunch],
      windowHours: 4,
    );
    expect(found, isNull);
  });

  test('pencere seçenekleri 1–4 saat; 1 saatte yakın öğün bağlanır', () {
    final found = nearestPreviousMeal(
      measuredAtUtc: DateTime.utc(2026, 9, 20, 7, 45),
      meals: [breakfast],
      windowHours: 1,
    );
    expect(found!.id, 1);
    final outside = nearestPreviousMeal(
      measuredAtUtc: DateTime.utc(2026, 9, 20, 8, 15),
      meals: [breakfast],
      windowHours: 1,
    );
    expect(outside, isNull);
  });

  test('hoursAfter tam hassasiyet: 90 dk = 1,5 saat', () {
    final meal = MealReference(id: 3, atUtc: DateTime.utc(2026, 9, 20, 10));
    final hours = hoursAfter(meal, DateTime.utc(2026, 9, 20, 11, 30));
    expect(hours, closeTo(1.5, 1e-12));
  });

  test('karıştırıcı etken eğitim kartı içerik dolu', () {
    expect(confoundingFactors.length, greaterThanOrEqualTo(5));
    for (final (tr, en) in confoundingFactors) {
      expect(tr.trim(), isNotEmpty);
      expect(en.trim(), isNotEmpty);
    }
  });
}
