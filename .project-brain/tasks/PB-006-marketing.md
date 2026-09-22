# PB-006 — Marketing paketi

## Status

READY

## Objective

MASTER §0.4: docs/marketing/ altında STORE_LISTING_TR/EN,
SCREENSHOT_PLAN, APP_PREVIEW_SCRIPT, LAUNCH_PLAN, BRAND_GUIDE,
ASO_RESEARCH, PRESS_KIT (8 dosya). Hastalık/tedavi/mucize iddiası
yasak; ekran görüntüleri çalışan uygulamadan.

## Dependencies

- PB-004 (çalışan uygulama)

## Affected Areas

- `docs/marketing/**`

## Acceptance Criteria

- 8 dosya mevcut; `grep -ri "tumor\|tümör\|cancer\|kanser\|glioblastoma" docs/marketing/` boş
- Mağaza adı her yerde "N Keto Tracker"; alt başlıklar ≤30 karakter
- Konumlandırma docs/research/PRODUCT_POSITIONING.md ile tutarlı

## Verification

Risk: LOW

Required:
- grep kontrolü + dosya varlığı

## Architecture Impact

Expected: NO

## Decision Boundary

- Mağaza yayın işlemleri kullanıcı adımıdır
