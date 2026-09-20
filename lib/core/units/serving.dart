/// Porsiyon ölçekleme (MASTER_PROMPT §8.1): 100 g referansından gerçek
/// miktara doğrusal ölçekleme. Saf fonksiyonlar; kayan nokta hataları
/// testle kilitlenir (§16.1).
library;

/// valuePer100g'yi grams'a ölçekler (ara yuvarlama yok).
double scalePer100g(double valuePer100g, double grams) =>
    valuePer100g * grams / 100.0;

/// Bir öğün maddesinin makrolarını hesaplar.
class ScaledNutrition {
  const ScaledNutrition({
    required this.kcal,
    required this.proteinG,
    required this.fatG,
    required this.carbohydrateTotalG,
    required this.fiberG,
    required this.netCarbG,
  });

  final double kcal;
  final double proteinG;
  final double fatG;
  final double carbohydrateTotalG;
  final double fiberG;
  final double netCarbG;
}

/// 100 g referans değerlerini grams porsiyona ölçekler.
///
/// [netCarbPer100g] kaynak kayıttan gelir; negatif çıkarsa 0'a
/// sabitlenir (MASTER §8.1 kuralının ölçeklemede korunması).
ScaledNutrition scaleItem({
  required double kcalPer100g,
  required double proteinGPer100g,
  required double fatGPer100g,
  required double carbohydrateTotalGPer100g,
  required double fiberGPer100g,
  required double netCarbGPer100g,
  required double grams,
}) {
  assert(grams >= 0, 'grams negatif olamaz');
  return ScaledNutrition(
    kcal: scalePer100g(kcalPer100g, grams),
    proteinG: scalePer100g(proteinGPer100g, grams),
    fatG: scalePer100g(fatGPer100g, grams),
    carbohydrateTotalG: scalePer100g(carbohydrateTotalGPer100g, grams),
    fiberG: scalePer100g(fiberGPer100g, grams),
    netCarbG: scalePer100g(netCarbGPer100g.clamp(0, double.infinity), grams),
  );
}
