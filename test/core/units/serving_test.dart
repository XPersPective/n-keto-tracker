import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/core/units/serving.dart';

/// T16 porsiyon ölçekleme birim testleri (MASTER_PROMPT §16.1, §22.6:
/// tablo tabanlı; kayan nokta hataları kilitli).
void main() {
  test('basit ölçekleme: 250 kcal/100g × 150 g = 375', () {
    expect(scalePer100g(250, 150), closeTo(375, 1e-9));
  });

  test('tekrarlı ondalık: 5.3 g protein × 70 g tam hassasiyetle', () {
    // 5.3*70/100 = 3.71 — ara yuvarlama olmadan
    expect(scalePer100g(5.3, 70), closeTo(3.71, 1e-12));
  });

  test('kayan nokta tuzağı: 0.1×3 tarzı birikim yanlış sonuca sapmaz', () {
    // Aynı öğünü 3×50 g parça parça eklemek 150 g eklemekle aynı toplamı
    // 1e-9 içinde vermeli.
    final one = scalePer100g(33.3333333, 150);
    final parts = scalePer100g(33.3333333, 50) * 3;
    expect(one, closeTo(parts, 1e-9));
  });

  test('negatif netCarb kaynağı 0\'a sabitlenir (MASTER §8.1)', () {
    final n = scaleItem(
      kcalPer100g: 100,
      proteinGPer100g: 10,
      fatGPer100g: 5,
      carbohydrateTotalGPer100g: 2,
      fiberGPer100g: 3,
      netCarbGPer100g: -1, // bozuk kaynak kaydı
      grams: 200,
    );
    expect(n.netCarbG, 0);
  });

  test('tablo: birden çok besin × porsiyon kombinasyonu', () {
    const rows = [
      // kcal/100g, grams, beklenen kcal
      (250.0, 100.0, 250.0),
      (250.0, 50.0, 125.0),
      (884.0, 14.0, 123.76), // zeytinyağı yemek kaşığı
      (717.0, 14.0, 100.38), // tereyağı yemek kaşığı
      (32.0, 150.0, 48.0), // çilek porsiyon
      (0.0, 200.0, 0.0),
    ];
    for (final (kcal, g, expected) in rows) {
      expect(
        scalePer100g(kcal, g),
        closeTo(expected, 0.011),
        reason: '$kcal kcal × $g g',
      );
    }
  });

  test('scaleItem tüm makroları ölçekler ve netCarb kuralını korur', () {
    final n = scaleItem(
      kcalPer100g: 143,
      proteinGPer100g: 12.6,
      fatGPer100g: 9.5,
      carbohydrateTotalGPer100g: 0.7,
      fiberGPer100g: 0.0,
      netCarbGPer100g: 0.7,
      grams: 150,
    );
    expect(n.kcal, closeTo(214.5, 1e-9));
    expect(n.proteinG, closeTo(18.9, 1e-9));
    expect(n.fatG, closeTo(14.25, 1e-9));
    expect(n.netCarbG, closeTo(1.05, 1e-9));
  });
}
