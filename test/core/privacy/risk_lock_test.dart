import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/core/privacy/risk_lock.dart';
import 'package:n_keto_tracker/features/onboarding/onboarding_controller.dart';

/// T10 risk kilidi testleri (MASTER §4.7): risk → plan/hedef üretimi
/// kilitli; tarama düzenlenince yeniden değerlenir; kilit kayıt/eğitimi
/// etkilemez (yalnız üretim kapısı).
void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
  });

  test('risk yokken kilit açık', () {
    expect(container.read(riskLockProvider).locked, isFalse);
  });

  test('tek risk yanıtı kilidi kapatır', () {
    container
        .read(onboardingControllerProvider.notifier)
        .updateRisk((r) => r.copyWith(pregnantOrBreastfeeding: true));
    final lock = container.read(riskLockProvider);
    expect(lock.locked, isTrue);
    expect(lock.anyRiskAnswered, isTrue);
  });

  test('tarama düzenlenince yeniden değerlenir (kilit açılır)', () {
    final controller = container.read(onboardingControllerProvider.notifier);
    controller.updateRisk((r) => r.copyWith(hasDiabetes: true));
    expect(container.read(riskLockProvider).locked, isTrue);
    controller.updateRisk((r) => r.copyWith(hasDiabetes: false));
    expect(container.read(riskLockProvider).locked, isFalse);
  });

  test(
    'guardPlanGeneration: kilittesken PlanLockedException, açıkken üretir',
    () {
      final controller = container.read(onboardingControllerProvider.notifier);
      final openLock = container.read(riskLockProvider);
      expect(guardPlanGeneration(openLock, () => 'plan'), 'plan');

      controller.updateRisk((r) => r.copyWith(under18: true));
      final lockedLock = container.read(riskLockProvider);
      expect(
        () => guardPlanGeneration(lockedLock, () => 'plan'),
        throwsA(isA<PlanLockedException>()),
      );
    },
  );
}
