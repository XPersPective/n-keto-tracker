# PB-014 — Reklam + premium satın alma (istemci)

## Status
PLANNED
## Objective
google_mobile_ads (NPA, UMP onam, test kimlikleri) + in_app_purchase
(premium reklamsız). Sağlık ekranlarında reklam yok. check_offline.sh
izin listesi, PRIVACY.md, THIRD_PARTY_NOTICES güncellenir.
## Dependencies
PB-012
## Acceptance Criteria
- Emülatörde test reklamı yüklenir; premium akışı test modunda geçer
- Sağlık verisi hiçbir istekte yok (kod incelemesi + test)
## Verification
Risk: HIGH — ödeme + gizlilik sınırı
## Architecture Impact
YES — monetization modülü
## Decision Boundary
Canlı AdMob app/unit ID ve Play ürün ID'leri kullanıcıdadır (BLOCKED
kısım); gerçek ödeme yapılmaz.
