import 'dart:convert';
import 'dart:io';

import 'monetization_config.dart';

/// Satın alma jetonunu isteğe bağlı sunucuda doğrular (PB-015).
///
/// Sunucuya YALNIZ {packageName, productId, purchaseToken} gider; sağlık
/// verisi bu sınıfa hiç ulaşmaz (ADR-PB-012).
///
/// Sonuç: `true` geçerli, `false` sunucu reddetti, `null` doğrulanamadı
/// (URL yok / ağ hatası).
typedef VerifyCall = Future<bool?> Function(String purchaseToken);

VerifyCall httpVerifier({
  String url = MonetizationConfig.verifyUrl,
  Duration timeout = const Duration(seconds: 6),
}) {
  return (token) async {
    if (url.isEmpty) return null;
    final client = HttpClient()..connectionTimeout = timeout;
    try {
      final req = await client.postUrl(Uri.parse(url)).timeout(timeout);
      req.headers.contentType = ContentType.json;
      req.write(
        jsonEncode({
          'packageName': MonetizationConfig.packageName,
          'productId': MonetizationConfig.premiumProductId,
          'purchaseToken': token,
        }),
      );
      final res = await req.close().timeout(timeout);
      if (res.statusCode != 200) return null;
      final body = await res.transform(utf8.decoder).join();
      return (jsonDecode(body) as Map<String, dynamic>)['valid'] == true;
    } catch (_) {
      return null;
    } finally {
      client.close(force: true);
    }
  };
}

/// Karar: Play zaten "satın alındı" dedi. Sunucu açıkça reddederse verme;
/// ulaşılamazsa (null) ödeme yapmış kullanıcıyı cezalandırma — ver.
Future<bool> shouldGrantPremium(String purchaseToken, VerifyCall verify) async {
  final v = await verify(purchaseToken);
  return v != false;
}
