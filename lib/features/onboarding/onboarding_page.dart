import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/l10n/generated/app_localizations.dart';
import '../../app/l10n/language_names.dart';
import '../../core/database/settings_repository.dart';
import 'consent_repository.dart';
import 'onboarding_controller.dart';

/// 8 adımlı ilk açılış akışı (MASTER §4):
/// dil → gizlilik → tıbbi-olmayan → amaç → profil → enerji katsayısı →
/// risk taraması → veri kalıcılığı + onam.
class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  int _step = 0;
  bool _consentChecked = false;

  static const _stepCount = onboardingStepCount;

  @override
  void initState() {
    super.initState();
    // Onam koruması (PB-010): geçerli onamı olan kullanıcı her açılışta
    // onboarding'e düşmez — doğrudan Bugün'e devam eder. Router global
    // statik olduğu için yönlendirme burada, veritabanı okumasıyla yapılır.
    WidgetsBinding.instance.addPostFrameCallback((_) => _redirectIfConsented());
  }

  Future<void> _redirectIfConsented() async {
    bool ok;
    try {
      ok = await ref.read(consentRepositoryProvider).hasValidConsent();
    } catch (_) {
      // DB okunamazsa güvenli yol: onboarding'i göster (testler ve
      // ilk açılış dahil).
      ok = false;
    }
    if (!mounted) return;
    if (ok) {
      context.go('/today');
    } else {
      setState(() => _consentChecked = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(onboardingControllerProvider);
    if (!_consentChecked) {
      // Onam kontrolü tamamlanana kadar kısa bekleme görünümü.
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.onboardingStepOf(_step + 1, _stepCount))),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _buildStep(context, _step, state)),
              const SizedBox(height: 12),
              Row(
                children: [
                  if (_step > 0)
                    TextButton(
                      // ≥48dp dokunma hedefi (MASTER §12).
                      style: TextButton.styleFrom(
                        minimumSize: const Size(48, 48),
                      ),
                      onPressed: () => setState(() => _step--),
                      child: Text(l10n.onboardingBack),
                    ),
                  const Spacer(),
                  if (_step < _stepCount - 1)
                    FilledButton(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(96, 48),
                      ),
                      onPressed: () => setState(() => _step++),
                      child: Text(l10n.onboardingNext),
                    )
                  else
                    FilledButton(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(96, 48),
                      ),
                      onPressed: state.consentAccepted
                          ? () => _finish(l10n)
                          : null,
                      child: Text(l10n.onboardingFinish),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(BuildContext context, int step, OnboardingState state) {
    final l10n = AppLocalizations.of(context)!;
    final controller = ref.read(onboardingControllerProvider.notifier);
    switch (step) {
      case 0:
        return _StepScaffold(
          title: l10n.onboardingLanguageTitle,
          child: RadioGroup<String>(
            groupValue: state.languageCode,
            onChanged: (v) {
              if (v != null) controller.setLanguage(v);
            },
            child: Column(
              children: [
                for (final e in languageEndonyms.entries)
                  RadioListTile<String>(title: Text(e.value), value: e.key),
              ],
            ),
          ),
        );
      case 1:
        return _StepScaffold(
          title: l10n.onboardingPrivacyTitle,
          body: l10n.onboardingPrivacyBody,
        );
      case 2:
        return _StepScaffold(
          title: l10n.onboardingMedicalTitle,
          body: l10n.onboardingMedicalBody,
        );
      case 3:
        return _StepScaffold(
          title: l10n.onboardingPurposeTitle,
          child: Column(
            children: [
              _purposeTile(
                controller,
                state,
                PurposeSelection.learn,
                l10n.onboardingPurposeLearn,
              ),
              _purposeTile(
                controller,
                state,
                PurposeSelection.meals,
                l10n.onboardingPurposeMeals,
              ),
              _purposeTile(
                controller,
                state,
                PurposeSelection.macros,
                l10n.onboardingPurposeMacros,
              ),
              _purposeTile(
                controller,
                state,
                PurposeSelection.measure,
                l10n.onboardingPurposeMeasure,
              ),
            ],
          ),
        );
      case 4:
        return _StepScaffold(
          title: l10n.onboardingProfileTitle,
          body: l10n.onboardingProfileBody,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: l10n.onboardingBirthYear,
                ),
                keyboardType: TextInputType.number,
                onChanged: (v) {
                  final year = int.tryParse(v);
                  if (year != null) {
                    controller.setProfile(birthYear: year);
                  }
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: l10n.onboardingHeightCm),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onChanged: (v) {
                  final h = double.tryParse(v.replaceAll(',', '.'));
                  if (h != null) controller.setProfile(heightCm: h);
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: l10n.onboardingWeightKg),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onChanged: (v) {
                  final w = double.tryParse(v.replaceAll(',', '.'));
                  if (w != null) controller.setProfile(weightKg: w);
                },
              ),
            ],
          ),
        );
      case 5:
        return _StepScaffold(
          title: l10n.onboardingEnergyCoeffTitle,
          body: l10n.onboardingEnergyCoeffBody,
          child: RadioGroup<EnergyCoefficient>(
            groupValue: state.energyCoefficient,
            onChanged: (v) {
              if (v != null) controller.setEnergyCoefficient(v);
            },
            child: Column(
              children: [
                RadioListTile<EnergyCoefficient>(
                  title: const Text('Mifflin–St Jeor +5'),
                  value: EnergyCoefficient.male2025,
                ),
                RadioListTile<EnergyCoefficient>(
                  title: const Text('Mifflin–St Jeor −161'),
                  value: EnergyCoefficient.female161,
                ),
                RadioListTile<EnergyCoefficient>(
                  title: Text(l10n.onboardingEnergyCoeffSkip),
                  value: EnergyCoefficient.skipped,
                ),
              ],
            ),
          ),
        );
      case 6:
        final risk = state.riskAnswers;
        return _StepScaffold(
          title: l10n.onboardingScreeningTitle,
          body: l10n.onboardingScreeningBody,
          child: Column(
            children: [
              _riskTile(
                controller,
                risk,
                (r, v) => r.copyWith(hasDiabetes: v),
                l10n.onboardingScreeningDiabetes,
              ),
              _riskTile(
                controller,
                risk,
                (r, v) => r.copyWith(usesGlucoseLoweringMedication: v),
                l10n.onboardingScreeningMedication,
              ),
              _riskTile(
                controller,
                risk,
                (r, v) => r.copyWith(pregnantOrBreastfeeding: v),
                l10n.onboardingScreeningPregnancy,
              ),
              _riskTile(
                controller,
                risk,
                (r, v) => r.copyWith(kidneyLiverPancreasDisease: v),
                l10n.onboardingScreeningOrgan,
              ),
              _riskTile(
                controller,
                risk,
                (r, v) => r.copyWith(eatingDisorderHistory: v),
                l10n.onboardingScreeningEatingDisorder,
              ),
              _riskTile(
                controller,
                risk,
                (r, v) => r.copyWith(unintentionalWeightLoss: v),
                l10n.onboardingScreeningWeightLoss,
              ),
              _riskTile(
                controller,
                risk,
                (r, v) => r.copyWith(under18: v),
                l10n.onboardingScreeningUnder18,
              ),
              if (risk.hasAnyRisk) ...[
                const SizedBox(height: 8),
                Text(
                  l10n.onboardingScreeningLockedNote,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ],
          ),
        );
      case 7:
        return _StepScaffold(
          title: l10n.onboardingDataTitle,
          body: l10n.onboardingDataBody,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.onboardingConsentTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(l10n.onboardingConsentBody),
              const SizedBox(height: 12),
              CheckboxListTile(
                title: Text(l10n.onboardingConsentCheckbox),
                value: state.consentAccepted,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (v) => controller.setConsentAccepted(v ?? false),
              ),
            ],
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _purposeTile(
    OnboardingController controller,
    OnboardingState state,
    PurposeSelection purpose,
    String label,
  ) {
    return CheckboxListTile(
      title: Text(label),
      value: state.purposes.contains(purpose),
      onChanged: (_) => controller.togglePurpose(purpose),
    );
  }

  Widget _riskTile(
    OnboardingController controller,
    RiskAnswers risk,
    RiskAnswers Function(RiskAnswers, bool) apply,
    String label,
  ) {
    return CheckboxListTile(
      title: Text(label),
      value: apply(risk, true) == risk,
      onChanged: (v) => controller.updateRisk((r) => apply(r, v ?? false)),
    );
  }

  Future<void> _finish(AppLocalizations l10n) async {
    final repository = ref.read(consentRepositoryProvider);
    final state = ref.read(onboardingControllerProvider);
    await repository.recordConsent(
      l10n: l10n,
      languageCode: state.languageCode,
    );
    // Dil tercihi kalıcı: sonraki açılışlarda AppSettings'ten uygulanır
    // (ORTAK §3.1; PB-010). Invalidate, yeni tercihi yerel ayara taşır.
    await ref
        .read(settingsRepositoryProvider)
        .saveOnboardingResult(languageCode: state.languageCode);
    ref.invalidate(appSettingsProvider);
    if (mounted) context.go('/today');
  }
}

class _StepScaffold extends StatelessWidget {
  const _StepScaffold({required this.title, this.body, this.child});

  final String title;
  final String? body;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          if (body != null) ...[const SizedBox(height: 12), Text(body!)],
          if (child != null) ...[const SizedBox(height: 16), child!],
        ],
      ),
    );
  }
}
