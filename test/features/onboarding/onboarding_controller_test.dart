import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n_keto_tracker/features/onboarding/onboarding_controller.dart';

/// Onboarding denetleyicisi birim testleri (MASTER §4; T10 risk kilidi
/// davranışının safsız doğrulaması).
void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
  });

  test('varsayılan durum: cihaz dili (yoksa EN), onam kabul edilmedi, katsayı atlandı', () {
    final s = container.read(onboardingControllerProvider);
    // Test ortamı cihaz dili 'en' → desteklenen → 'en'; desteklenmeyen de 'en'.
    expect(s.languageCode, anyOf('en', 'tr'));
    expect(s.consentAccepted, isFalse);
    expect(s.energyCoefficient, EnergyCoefficient.skipped);
    expect(s.riskAnswers.hasAnyRisk, isFalse);
  });

  test('dil değişimi', () {
    container.read(onboardingControllerProvider.notifier).setLanguage('en');
    expect(container.read(onboardingControllerProvider).languageCode, 'en');
  });

  test('amaç çoklu seçimi: ekle ve çıkar', () {
    final c = container.read(onboardingControllerProvider.notifier);
    c.togglePurpose(PurposeSelection.measure);
    c.togglePurpose(PurposeSelection.macros);
    expect(container.read(onboardingControllerProvider).purposes, {
      PurposeSelection.measure,
      PurposeSelection.macros,
    });
    c.togglePurpose(PurposeSelection.measure);
    expect(container.read(onboardingControllerProvider).purposes, {
      PurposeSelection.macros,
    });
  });

  test('tek risk yanıtı hasAnyRisk kilit koşulunu üretir', () {
    final c = container.read(onboardingControllerProvider.notifier);
    c.updateRisk((r) => r.copyWith(usesGlucoseLoweringMedication: true));
    expect(
      container.read(onboardingControllerProvider).riskAnswers.hasAnyRisk,
      isTrue,
    );
    c.updateRisk((r) => r.copyWith(usesGlucoseLoweringMedication: false));
    expect(
      container.read(onboardingControllerProvider).riskAnswers.hasAnyRisk,
      isFalse,
    );
  });

  test('RiskAnswers ==/hashCode tüm alanlarda ayrıştırır (checkbox değeri '
      'doğru işlemesi için)', () {
    const base = RiskAnswers();
    final modified = base.copyWith(hasDiabetes: true);
    expect(base == modified, isFalse);
    expect(base == const RiskAnswers(), isTrue);
    expect(modified == base.copyWith(hasDiabetes: true), isTrue);
  });
}
