# PB-012 — Premium UI + açık/koyu tema

## Status
READY
## Objective
Özgün tasarım dili (tipografi, renk, yüzey, hareket), tüm ekranlara
uygulanmış; Ayarlar'da Sistem/Açık/Koyu seçimi kalıcı.
## Affected Areas
`lib/app/theme/**`, `lib/features/**` (görsel), `lib/app/app*.dart`
## Acceptance Criteria
- ThemeMode seçimi kalıcı; iki temada tüm ekranlar kontrast ≥4.5:1
- Emülatör ekran görüntüleri açık+koyu, TR; tüm testler yeşil
## Verification
Risk: MEDIUM — analyze, test, emülatör görseli
## Architecture Impact
YES — theme, settings
## Decision Boundary
None
