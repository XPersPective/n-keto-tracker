import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

/// Reklam + ödeme yapılandırması (ADR-PB-012). Varsayılanlar Google'ın
/// herkese açık TEST kimlikleridir; üretimde `--dart-define` ile
/// gerçek değerler verilir (sır değil ama hesaba bağlıdır).
abstract final class MonetizationConfig {
  static const String premiumProductId = String.fromEnvironment(
    'PREMIUM_PRODUCT_ID',
    defaultValue: 'premium_remove_ads',
  );

  /// Google'ın test banner birimi.
  static const String bannerUnitId = String.fromEnvironment(
    'ADMOB_BANNER_UNIT_ID',
    defaultValue: 'ca-app-pub-3940256099942544/6300978111',
  );

  /// Boşsa istemci yalnız Play Billing'e güvenir (PB-015 sunucusu isteğe bağlı).
  static const String verifyUrl = String.fromEnvironment('PREMIUM_VERIFY_URL');

  static const String packageName = 'com.crazypenguin.nketotracker';

  /// Reklam/ödeme yalnız Android'de (iOS kapsam dışı).
  static bool get supported => !kIsWeb && Platform.isAndroid;
}
