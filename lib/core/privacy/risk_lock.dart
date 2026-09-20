import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/onboarding/onboarding_controller.dart';

/// Otomatik plan/hedef üretiminin kilit durumu (MASTER §4 adım 7, T10).
///
/// Risk taramasında herhangi bir risk yanıtı → üretim KİLİTLİ: uygulama
/// yalnızca kayıt ve eğitim işlevleri sunar, uygun sağlık uzmanı
/// değerlendirmesi ister. Tarama düzenlendiğinde [riskLockProvider] yeniden
/// değerlenir (Notifier'ın risk durumunu izlemesiyle).
class RiskLockState {
  const RiskLockState({required this.locked, required this.anyRiskAnswered});

  /// Plan üretici ve otomatik hedef üretimi çağrılabilir mi?
  final bool locked;

  /// Kullanıcı taramada en az bir soruyu "evet" yanıtladı mı?
  /// (Kilit mesajının gösterilip gösterilmeyeceği buradan gelir.)
  final bool anyRiskAnswered;
}

/// Risk kilidi sağlayıcısı: onboarding'deki [onboardingControllerProvider]
/// risk yanıtını okur. Kayıt/eğitim işlevleri bu sağlayıcıdan etkilenmez.
final riskLockProvider = Provider<RiskLockState>((ref) {
  final risk = ref.watch(onboardingControllerProvider).riskAnswers;
  return RiskLockState(
    locked: risk.hasAnyRisk,
    anyRiskAnswered: risk.hasAnyRisk,
  );
});

/// Plan üretimi girişiminde bulunur; kilitliyken [PlanLockedException]
/// fırlatır. Gerçek plan üretici T20'de bu fonksiyonu kapı olarak kullanır.
T guardPlanGeneration<T>(RiskLockState lock, T Function() generate) {
  if (lock.locked) {
    throw const PlanLockedException();
  }
  return generate();
}

/// Kilitliyken üretim çağrısının reddi.
class PlanLockedException implements Exception {
  const PlanLockedException();

  @override
  String toString() =>
      'Plan/goal generation is locked by risk screening (MASTER_PROMPT §4.7)';
}
