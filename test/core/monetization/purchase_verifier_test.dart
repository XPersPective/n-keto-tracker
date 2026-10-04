import 'package:flutter_test/flutter_test.dart';
import 'package:n_keto_tracker/core/monetization/purchase_verifier.dart';

/// Premium verme kararı (ADR-PB-012): sunucu açıkça reddederse verilmez;
/// ulaşılamazsa (null) ödeme yapmış kullanıcı cezalandırılmaz.
void main() {
  test('sunucu geçerli → verilir', () async {
    expect(await shouldGrantPremium('t', (_) async => true), isTrue);
  });

  test('sunucu reddetti → verilmez', () async {
    expect(await shouldGrantPremium('t', (_) async => false), isFalse);
  });

  test('sunucu yok/ulaşılamaz (null) → verilir', () async {
    expect(await shouldGrantPremium('t', (_) async => null), isTrue);
  });

  test('URL boşsa httpVerifier ağa çıkmadan null döner', () async {
    expect(await httpVerifier(url: '')('t'), isNull);
  });
}
