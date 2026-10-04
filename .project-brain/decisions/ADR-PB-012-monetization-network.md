# ADR-PB-012 — Reklam, ödeme ve sunucu tarafı: C-001 revizyonu

Status: ACCEPTED (kullanıcı talimatı, 2026-10-04: "ödeme ve reklam, server
tarafı… Google Play'e yükle").

## Context

Önceki hedef: tamamen çevrimdışı, reklam/abonelik/ağ non-goal'dü (C-001).
Kullanıcı bunu açıkça tersine çevirdi: reklam + ödeme + sunucu entegrasyonu,
premium görsel, açık/koyu tema, çok dilli, Play yayını.

## Decision

- Tek build; `INTERNET` yalnız reklam (AdMob) ve ödeme (Play Billing)
  için eklenir. Sağlık verisi (öğün, ölçüm, GKI, semptom, kilo) cihazdan
  ASLA çıkmaz; sunucuya yalnız satın alma jetonu gider.
- Analytics/telemetri/Firebase/harici AI hâlâ YASAK. `check_offline.sh`
  izin listesi: yalnız `google_mobile_ads` + `in_app_purchase` ailesi.
- Reklamlar kişiselleştirilmemiş (NPA), UMP onam akışı, sağlık ekranlarında
  (kayıt formları, GKI sonucu, rehber/kanıt) reklam YOK; premium ile kalkar.
- Test kimlikleri: Google'ın herkese açık test reklam birimleri. Canlı
  AdMob/Play ürün kimlikleri kullanıcı adımı (sır değil, ama hesap bağlı).
- Sunucu: satın alma doğrulama servisi (Play Developer API) ayrı dizinde
  (`server/`); dağıtım ve servis hesabı anahtarı kullanıcıdadır.

## Consequences

PRIVACY.md, Data safety, mağaza metni, THIRD_PARTY_NOTICES, C-001, hedef
non-goal'ler güncellenir. Reddedilen: iki flavor (offline/play) —
karmaşıklık; gerekirse sonradan eklenebilir.
