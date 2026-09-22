# PB-003 — Gizlilik politikası sayfası (GitHub Pages)

## Status

READY

## Objective

`docs/privacy/` altında TR+EN statik gizlilik politikası (ORTAK §7 +
MASTER §0.4): veriler yalnız cihazda, hesap/reklam/analitik yok,
export/import davranışı, silme. Uygulama bu siteye veri GÖNDERMEZ.

## Dependencies

- None

## Affected Areas

- `docs/privacy/index.md` + `docs/privacy/en.md`
- `README.md` (Pages bağlantı notu)

## Acceptance Criteria

- TR+EN politika dosyaları mevcut, içeriği uygulama davranışıyla tutarlı
  (şifreleme iddiası ADR-0001 ile aynı)
- README'de Pages yayın notu var
- Uygulama koduna ağ çağrısı EKLENMEMİŞ (check_offline geçer)

## Verification

Risk: LOW

Required:
- Dosya varlığı + içerik kontrolü
- `bash tool/check_offline.sh`

## Architecture Impact

Expected: NO

## Decision Boundary

- Pages yayını (GitHub ayarı) kullanıcı adımıdır; depo yalnız içeriği
  hazırlar
