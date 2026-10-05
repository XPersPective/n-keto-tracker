import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

/// Reklam + ödeme yapılandırması (ADR-PB-012). Varsayılanlar Google'ın
/// herkese açık TEST kimlikleridir; üretimde `--dart-define` ile
/// gerçek değerler verilir (sır değil ama hesaba bağlıdır).
abstract final class MonetizationConfig {
  /// Tek seferlik, tüketilmeyen "Pro" ürünü (reklamları kaldırır).
  /// Kimlik: yayın kökü apps/n-keto-tracker/app-ids.env (IAP_PRO_LIFETIME).
  static const String premiumProductId = String.fromEnvironment(
    'PREMIUM_PRODUCT_ID',
    defaultValue: 'com.crazypenguin.nketotracker.pro_lifetime',
  );

  /// Banner birimi: release'te `fastlane build_release` gerçek birimi
  /// (ADMOB_BANNER_ANDROID) enjekte eder; varsayılan Google'ın TEST birimidir.
  static const String bannerUnitId = String.fromEnvironment(
    'ADMOB_BANNER_ANDROID',
    defaultValue: 'ca-app-pub-3940256099942544/6300978111',
  );

  /// Boşsa istemci yalnız Play Billing'e güvenir (PB-015 sunucusu isteğe bağlı).
  static const String verifyUrl = String.fromEnvironment('PREMIUM_VERIFY_URL');

  static const String packageName = 'com.crazypenguin.nketotracker';

  /// Reklam/ödeme yalnız Android'de (iOS kapsam dışı).
  static bool get supported => !kIsWeb && Platform.isAndroid;
}
