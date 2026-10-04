import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'monetization_config.dart';
import 'purchase_verifier.dart';

class PremiumState {
  const PremiumState({
    this.premium = false,
    this.price,
    this.busy = false,
    this.available = false,
  });

  final bool premium;

  /// Play'den gelen yerelleştirilmiş fiyat metni (ürün yüklenene dek null).
  final String? price;
  final bool busy;
  final bool available;

  PremiumState copyWith({
    bool? premium,
    String? price,
    bool? busy,
    bool? available,
  }) => PremiumState(
    premium: premium ?? this.premium,
    price: price ?? this.price,
    busy: busy ?? this.busy,
    available: available ?? this.available,
  );
}

const _storageKey = 'premium_v1';

/// Reklamsız "Premium" tek seferlik satın alma (ADR-PB-012).
/// Durum yerelde güvenli depoda önbelleğe alınır; açılışta Play ile
/// geri yüklenir. ponytail: iade sonrası önbellek temizliği yok — gerekirse
/// sunucu tarafı RTDN ile eklenir.
class PremiumController extends Notifier<PremiumState> {
  StreamSubscription<List<PurchaseDetails>>? _sub;
  ProductDetails? _product;
  final VerifyCall _verify = httpVerifier();
  final _storage = const FlutterSecureStorage();

  @override
  PremiumState build() {
    ref.onDispose(() => _sub?.cancel());
    if (MonetizationConfig.supported) scheduleMicrotask(_init);
    return const PremiumState();
  }

  Future<void> _init() async {
    try {
      final cached = await _storage.read(key: _storageKey);
      if (cached == 'true') state = state.copyWith(premium: true);
    } catch (_) {}
    final iap = InAppPurchase.instance;
    _sub = iap.purchaseStream.listen(_onPurchases, onError: (_) {});
    if (!await iap.isAvailable()) return;
    final res = await iap.queryProductDetails({
      MonetizationConfig.premiumProductId,
    });
    if (res.productDetails.isNotEmpty) {
      _product = res.productDetails.first;
      state = state.copyWith(available: true, price: _product!.price);
    }
    await iap.restorePurchases();
  }

  Future<void> buy() async {
    final p = _product;
    if (p == null || state.busy) return;
    state = state.copyWith(busy: true);
    try {
      await InAppPurchase.instance.buyNonConsumable(
        purchaseParam: PurchaseParam(productDetails: p),
      );
    } catch (_) {
      state = state.copyWith(busy: false);
    }
  }

  Future<void> restore() async {
    if (!MonetizationConfig.supported) return;
    await InAppPurchase.instance.restorePurchases();
  }

  Future<void> _onPurchases(List<PurchaseDetails> list) async {
    for (final p in list) {
      if (p.productID != MonetizationConfig.premiumProductId) continue;
      switch (p.status) {
        case PurchaseStatus.purchased || PurchaseStatus.restored:
          final ok = await shouldGrantPremium(
            p.verificationData.serverVerificationData,
            _verify,
          );
          if (ok) {
            state = state.copyWith(premium: true, busy: false);
            try {
              await _storage.write(key: _storageKey, value: 'true');
            } catch (_) {}
          }
        case PurchaseStatus.pending:
          break;
        case PurchaseStatus.error || PurchaseStatus.canceled:
          state = state.copyWith(busy: false);
      }
      if (p.pendingCompletePurchase) {
        await InAppPurchase.instance.completePurchase(p);
      }
    }
  }
}

final premiumProvider = NotifierProvider<PremiumController, PremiumState>(
  PremiumController.new,
);
