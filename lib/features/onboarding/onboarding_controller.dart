import 'dart:ui' show PlatformDispatcher;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/language_names.dart';

/// Onboarding adım sayısı: dil → gizlilik → tıbbi-olmayan → amaç → profil
/// → enerji katsayısı → risk taraması → veri kalıcılığı + onam (MASTER §4).
const onboardingStepCount = 8;

/// Kullanım amacı seçimi (çoklu; yalnız ana ekranı sadeleştirir,
/// hastalık modu OLUŞTURMAZ).
enum PurposeSelection { learn, meals, macros, measure }

/// Mifflin–St Jeor katsayısı: cinsiyet kimliği DEĞİL; denklemin iki
/// doğrulanmış katsayısından biri. skipped = enerji tahmini atlandı.
enum EnergyCoefficient { male2025, female161, skipped }

/// Risk taraması yanıtları (MASTER §4 adım 7). Hiçbiri tanı üretmez.
class RiskAnswers {
  const RiskAnswers({
    this.hasDiabetes = false,
    this.usesGlucoseLoweringMedication = false,
    this.pregnantOrBreastfeeding = false,
    this.kidneyLiverPancreasDisease = false,
    this.eatingDisorderHistory = false,
    this.unintentionalWeightLoss = false,
    this.under18 = false,
  });

  final bool hasDiabetes;
  final bool usesGlucoseLoweringMedication;
  final bool pregnantOrBreastfeeding;
  final bool kidneyLiverPancreasDisease;
  final bool eatingDisorderHistory;
  final bool unintentionalWeightLoss;
  final bool under18;

  /// Herhangi bir risk → otomatik plan/hedef üretimi KİLİTLENİR.
  bool get hasAnyRisk =>
      hasDiabetes ||
      usesGlucoseLoweringMedication ||
      pregnantOrBreastfeeding ||
      kidneyLiverPancreasDisease ||
      eatingDisorderHistory ||
      unintentionalWeightLoss ||
      under18;

  RiskAnswers copyWith({
    bool? hasDiabetes,
    bool? usesGlucoseLoweringMedication,
    bool? pregnantOrBreastfeeding,
    bool? kidneyLiverPancreasDisease,
    bool? eatingDisorderHistory,
    bool? unintentionalWeightLoss,
    bool? under18,
  }) {
    return RiskAnswers(
      hasDiabetes: hasDiabetes ?? this.hasDiabetes,
      usesGlucoseLoweringMedication:
          usesGlucoseLoweringMedication ?? this.usesGlucoseLoweringMedication,
      pregnantOrBreastfeeding:
          pregnantOrBreastfeeding ?? this.pregnantOrBreastfeeding,
      kidneyLiverPancreasDisease:
          kidneyLiverPancreasDisease ?? this.kidneyLiverPancreasDisease,
      eatingDisorderHistory:
          eatingDisorderHistory ?? this.eatingDisorderHistory,
      unintentionalWeightLoss:
          unintentionalWeightLoss ?? this.unintentionalWeightLoss,
      under18: under18 ?? this.under18,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is RiskAnswers &&
      other.hasDiabetes == hasDiabetes &&
      other.usesGlucoseLoweringMedication == usesGlucoseLoweringMedication &&
      other.pregnantOrBreastfeeding == pregnantOrBreastfeeding &&
      other.kidneyLiverPancreasDisease == kidneyLiverPancreasDisease &&
      other.eatingDisorderHistory == eatingDisorderHistory &&
      other.unintentionalWeightLoss == unintentionalWeightLoss &&
      other.under18 == under18;

  @override
  int get hashCode => Object.hash(
    hasDiabetes,
    usesGlucoseLoweringMedication,
    pregnantOrBreastfeeding,
    kidneyLiverPancreasDisease,
    eatingDisorderHistory,
    unintentionalWeightLoss,
    under18,
  );
}

/// Onboarding form durumu (sayfalar arası taşınır; kayıt ancak son adımda).
class OnboardingState {
  const OnboardingState({
    this.languageCode = 'tr',
    this.purposes = const <PurposeSelection>{},
    this.birthYear,
    this.heightCm,
    this.weightKg,
    this.energyCoefficient = EnergyCoefficient.skipped,
    this.riskAnswers = const RiskAnswers(),
    this.consentAccepted = false,
  });

  final String languageCode;
  final Set<PurposeSelection> purposes;
  final int? birthYear;
  final double? heightCm;
  final double? weightKg;
  final EnergyCoefficient energyCoefficient;
  final RiskAnswers riskAnswers;
  final bool consentAccepted;

  OnboardingState copyWith({
    String? languageCode,
    Set<PurposeSelection>? purposes,
    int? birthYear,
    double? heightCm,
    double? weightKg,
    EnergyCoefficient? energyCoefficient,
    RiskAnswers? riskAnswers,
    bool? consentAccepted,
  }) {
    return OnboardingState(
      languageCode: languageCode ?? this.languageCode,
      purposes: purposes ?? this.purposes,
      birthYear: birthYear ?? this.birthYear,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      energyCoefficient: energyCoefficient ?? this.energyCoefficient,
      riskAnswers: riskAnswers ?? this.riskAnswers,
      consentAccepted: consentAccepted ?? this.consentAccepted,
    );
  }
}

/// Onboarding durum denetleyicisi (Riverpod 3 Notifier).
class OnboardingController extends Notifier<OnboardingState> {
  @override
  OnboardingState build() {
    // İlk açılış: cihaz dili destekleniyorsa o, değilse İngilizce (ORTAK §3.1).
    final device = PlatformDispatcher.instance.locale.languageCode;
    return OnboardingState(
      languageCode: languageEndonyms.containsKey(device) ? device : 'en',
    );
  }

  void setLanguage(String code) => state = state.copyWith(languageCode: code);

  void togglePurpose(PurposeSelection purpose) {
    final next = {...state.purposes};
    if (!next.remove(purpose)) next.add(purpose);
    state = state.copyWith(purposes: next);
  }

  void setProfile({int? birthYear, double? heightCm, double? weightKg}) {
    state = state.copyWith(
      birthYear: birthYear ?? state.birthYear,
      heightCm: heightCm ?? state.heightCm,
      weightKg: weightKg ?? state.weightKg,
    );
  }

  void setEnergyCoefficient(EnergyCoefficient coefficient) =>
      state = state.copyWith(energyCoefficient: coefficient);

  void updateRisk(RiskAnswers Function(RiskAnswers) update) =>
      state = state.copyWith(riskAnswers: update(state.riskAnswers));

  void setConsentAccepted(bool accepted) =>
      state = state.copyWith(consentAccepted: accepted);
}

final onboardingControllerProvider =
    NotifierProvider<OnboardingController, OnboardingState>(
      OnboardingController.new,
    );
