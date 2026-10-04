import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'monetization_config.dart';
import 'premium_controller.dart';

class AdsState {
  const AdsState({this.ready = false, this.privacyOptionsRequired = false});

  /// UMP onamı tamam ve SDK başlatıldı → reklam istenebilir.
  final bool ready;

  /// Kullanıcıya "Reklam gizlilik seçenekleri" girişi gösterilmeli mi.
  final bool privacyOptionsRequired;
}

/// UMP onam akışı + AdMob başlatma. Reklamlar HER ZAMAN kişiselleştirilmemiş
/// ve G içerik sınıfıyla istenir; premium kullanıcıda SDK hiç başlatılmaz.
class AdsController extends Notifier<AdsState> {
  bool _started = false;

  @override
  AdsState build() {
    if (!MonetizationConfig.supported) return const AdsState();
    // Premium durumu yüklenince/değişince yeniden değerlendir.
    ref.listen(premiumProvider.select((s) => s.premium), (_, premium) {
      if (!premium) _start();
    }, fireImmediately: true);
    return const AdsState();
  }

  void _start() {
    if (_started) return;
    _started = true;
    ConsentInformation.instance.requestConsentInfoUpdate(
      ConsentRequestParameters(),
      () => ConsentForm.loadAndShowConsentFormIfRequired((_) => _finish()),
      (_) => _finish(), // önbellekteki onam hâlâ geçerli olabilir
    );
  }

  Future<void> _finish() async {
    final info = ConsentInformation.instance;
    if (!await info.canRequestAds()) return;
    await MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(maxAdContentRating: MaxAdContentRating.g),
    );
    await MobileAds.instance.initialize();
    final status = await info.getPrivacyOptionsRequirementStatus();
    state = AdsState(
      ready: true,
      privacyOptionsRequired:
          status == PrivacyOptionsRequirementStatus.required,
    );
  }

  Future<void> showPrivacyOptions() =>
      ConsentForm.showPrivacyOptionsForm((_) {});
}

final adsProvider = NotifierProvider<AdsController, AdsState>(
  AdsController.new,
);
