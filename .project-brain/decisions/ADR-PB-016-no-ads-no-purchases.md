# ADR-PB-016 — Reklam ve satın alma kaldırıldı

Status: ACCEPTED (kullanıcı talimatı, 2026-10-08: "bu uygulamada reklam ve
satın alma olmayacak demiştim").

## Context

ADR-PB-012 (2026-10-04) AdMob + Play Billing + doğrulama sunucusu eklemişti.
Sahip bunun bu uygulama için istenmediğini bildirdi; yayın öncesi hâlâ
yalnızca iç test AAB'si (1.0.0+1) vardı.

## Decision

AdMob, in_app_purchase, `lib/core/monetization/`, `server/`, INTERNET/
ACCESS_NETWORK_STATE izinleri, AdMob meta-verisi, R8 WorkManager kuralı ve
ilgili ARB metinleri kaldırıldı. `tool/check_offline.sh` ADR-PB-012 öncesi
katı sürüme döndü. ORTAK_UYGULAMA_STANDARDI §0: REKLAM=HAYIR, PRO=HAYIR.
Sürüm 1.0.0+2. Play Console: Reklam=Hayır, Reklam Kimliği=Hayır, Veri
güvenliği=veri toplanmıyor; Pro ürünü oluşturulmayacak.

## Consequences

C-001 yeniden çevrimdışı/reklamsız. Gizlilik politikası ve 18 dilli mağaza
metni güncellendi. Gerekirse geri alma: git geçmişi (2447bfc, 5b3be8d).
