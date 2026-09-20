/// Genel enerji tahmini (MASTER_PROMPT §7): Mifflin–St Jeor (1990).
///
/// - Sonuç YALNIZCA genel tahmindir; klinik enerji reçetesi değildir.
/// - Kaynak: Mifflin MD, St Jeor ST, Hill LA, ve ark. (1990), AJCN
///   51(2):241–247 — docs/research/EVIDENCE_VERIFICATION.md #7.
/// - Kapsam dışı (18 yaş altı, gebelik/emzirme, katsayı atlandı)
///   → hesap ÜRETİLMEZ (EnergyEstimateNotAllowed).
/// - Aktivite katsayıları sürümlenmiş içerikte; kurumsal referans:
///   Dietary Guidelines for Americans fiziksel aktivite katsayıları.
library;

import '../../features/onboarding/onboarding_controller.dart';
import 'formula_version.dart';

/// Aktivite katsayıları (sürümlenmiş).
const Map<String, double> activityFactors = {
  'sedentary': 1.2,
  'light': 1.375,
  'moderate': 1.55,
  'active': 1.725,
};

const String energyFormulaVersion = 'energy-v1 ($formulaVersion)';

/// Hesap kapsam dışı: uygulama sessizce sayı üretmez, UI dürüst açıklama
/// gösterir (MASTER §7.2).
class EnergyEstimateNotAllowed implements Exception {
  const EnergyEstimateNotAllowed(this.reason);

  final String reason;

  @override
  String toString() => 'ENERGY_ESTIMATE_NOT_ALLOWED: $reason';
}

/// REE (Mifflin–St Jeor): 10·kg + 6,25·cm − 5·yaş + katsayı.
/// Katsayılar OnboardingController.EnergyCoefficient'ten gelir:
/// male2025 → +5, female161 → −161, skipped → hesap yok.
double restingEnergy({
  required double weightKg,
  required double heightCm,
  required int age,
  required EnergyCoefficient coefficient,
}) {
  if (coefficient == EnergyCoefficient.skipped) {
    throw const EnergyEstimateNotAllowed('katsayı atlandı');
  }
  if (age < 18) {
    throw const EnergyEstimateNotAllowed('18 yaş altı kapsam dışı');
  }
  final base = 10 * weightKg + 6.25 * heightCm - 5 * age;
  return switch (coefficient) {
    EnergyCoefficient.male2025 => base + 5,
    EnergyCoefficient.female161 => base - 161,
    EnergyCoefficient.skipped => throw const EnergyEstimateNotAllowed(
      'katsayı atlandı',
    ),
  };
}

/// TDEE = REE × aktivite katsayısı (ara yuvarlama yok).
double totalEnergy({required double ree, required String activityLevel}) {
  final factor = activityFactors[activityLevel];
  if (factor == null) {
    throw ArgumentError('bilinmeyen aktivite düzeyi: $activityLevel');
  }
  return ree * factor;
}

/// Onboarding yanıtlarından hesap uygunluğu (MASTER §4.7/§7.2):
/// gebelik/emzirme işaretliyse hesap üretilmez.
bool isEligibleForEstimate({
  required int? age,
  required EnergyCoefficient coefficient,
  required bool pregnantOrBreastfeeding,
}) {
  if (coefficient == EnergyCoefficient.skipped) return false;
  if (pregnantOrBreastfeeding) return false;
  return age != null && age >= 18;
}
