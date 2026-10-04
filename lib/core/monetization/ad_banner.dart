import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../app/l10n/generated/app_localizations.dart';
import 'ads_controller.dart';
import 'monetization_config.dart';
import 'premium_controller.dart';

/// Kişiselleştirilmemiş banner. Premium, desteklenmeyen platform veya onam
/// yokken HİÇ yer kaplamaz. Yalnız klinik olmayan ekranlara konur
/// (Plan sekmesi, Ayarlar — ADR-PB-012).
class AdBanner extends ConsumerStatefulWidget {
  const AdBanner({super.key});

  @override
  ConsumerState<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends ConsumerState<AdBanner> {
  BannerAd? _ad;
  bool _loaded = false;

  void _load() {
    if (_ad != null) return;
    _ad = BannerAd(
      adUnitId: MonetizationConfig.bannerUnitId,
      size: AdSize.banner,
      request: const AdRequest(nonPersonalizedAds: true),
      listener: BannerAdListener(
        onAdLoaded: (_) => mounted ? setState(() => _loaded = true) : null,
        onAdFailedToLoad: (ad, _) {
          ad.dispose();
          _ad = null;
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!MonetizationConfig.supported) return const SizedBox.shrink();
    final premium = ref.watch(premiumProvider.select((s) => s.premium));
    final ready = ref.watch(adsProvider.select((s) => s.ready));
    if (premium || !ready) return const SizedBox.shrink();
    _load();
    final ad = _ad;
    if (!_loaded || ad == null) return const SizedBox.shrink();
    return Semantics(
      label: AppLocalizations.of(context)!.adLabel,
      child: SizedBox(
        width: ad.size.width.toDouble(),
        height: ad.size.height.toDouble(),
        child: AdWidget(ad: ad),
      ),
    );
  }
}
