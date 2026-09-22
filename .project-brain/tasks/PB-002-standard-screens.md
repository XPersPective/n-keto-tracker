# PB-002 — Ortak ekranlar: Hakkında, Lisanslar, Paylaş/Diğer Uygulamalar

## Status

READY

## Objective

ORTAK §3.3–3.6 ekranlarını offline ilkeyle uygulamak: Hakkında (logo, ad,
sürüm, açık kaynak bölümü, gizlilik tek cümle, feragat, Lisanslar'a
bağlantı), Lisanslar (showLicensePage + varlık lisansları), Paylaş
(share_plus, sistem sayfası), Puan ver (in_app_review — opsiyonel, ağ
dostu değilse atla), Diğer Uygulamalar (gömülü statik liste, ağ YOK).

## Dependencies

- None

## Affected Areas

- `lib/features/settings/**`
- `pubspec.yaml` (share_plus; in_app_review yalnız ADR gerekçesiyle)
- ARB dosyaları

## Acceptance Criteria

- Hakkında sayfası: ad+sürüm+açık kaynak (GitHub+GPL-3.0 tek cümle)+
  gizlilik özeti+feragat; tümü ARB'de
- Lisanslar: showLicensePage açılır
- Paylaş: share_plus ile uygulama metni sistem paylaşım sayfasına gider
  (test: share_plus çağrısı mock'lanır)
- Diğer Uygulamalar: gömülü statik liste, mağaza linkleri harici açılır
  (url_launcher yerine — ağ yok), ağ isteği YOK
- `bash tool/check_offline.sh` exit 0 kalır
- Widget testleri geçer

## Verification

Risk: MEDIUM

Required:
- `flutter analyze --fatal-infos`
- `flutter test`
- `bash tool/check_offline.sh`

## Architecture Impact

Expected: NO

## Decision Boundary

- in_app_review eklemek yeni bağımlılık gerektirir: ADR yazılmadan
  EKLENMEZ; eklenmiyorsa Puan ver özelliği "mağaza bağlantısı harici"
  olarak sadeleştirilir (kullanıcı kararı değil — konservatif seçim
  yapılabilir)

## Discoveries

(boş)
