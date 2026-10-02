# PB-009 — ORTAK §3.6 Diğer uygulamalar + §3.3 slogan

## Status

IN_PROGRESS

## Objective

ORTAK_UYGULAMA_STANDARDI.md uyum boşluklarını kapatmak:

1. §3.6: Hakkında'daki "Diğer uygulamalar" girişi ölü düğme
   (`onTap: () {}`, about_page.dart:169). Uygulama tamamen çevrimdışı
   olduğundan (INTERNET izni YOK, kısıt) standarttaki GitHub raw
   çekme mekanizması uygulanamaz — gömülü varlık kopyası uyarlaması
   (standart §3.6 zaten "internet yoksa gömülü kopya" kademelendirmesi
   içerir; burada kalıcı olarak gömülü kopya). Bozuk JSON çökertmez,
   öbek dışı kayıt atlanır, mağaza bağlantısı yalnız kopyalanır
   (uygulanmanın yerleşik "URL yalnız kopyala" kalıbı).
2. §3.3: Hakkında başlığında adın altında kısa slogan.

## Dependencies

None (PB-002 sonrası).

## Affected Areas

- `lib/features/settings/other_apps_page.dart` (yeni)
- `lib/features/settings/about_page.dart`
- `lib/app/router.dart`
- `lib/app/l10n/app_tr.arb`, `app_en.arb` + generated
- `assets/apps.json` (yeni), `pubspec.yaml` (assets)
- `test/features/settings/other_apps_page_test.dart` (yeni)
- `docs/ORTAK_CONFORMANCE.md` kaydı / ADR

## Acceptance Criteria

- Hakkında'daki "Diğer uygulamalar" girişi sayfayı açar; boş listede
  `otherAppsEmpty` metni görünür.
- Gömülü apps.json bozuk/eksik schema ise sayfa çökmez, boş durum
  gösterir (§1.4 girdi doğrulama).
- Slogan TR/EN iki dilde About'ta görünür.
- flutter analyze temiz, flutter test yeşil.

## Verification

Risk: LOW

Required: analyze + targeted widget tests.

## Architecture Impact

NO (yeni yaprak sayfa; router'a bir yol).

## Decision Boundary

- Sıradan uygulama detayı: sayfa tasarımı ajan kararı.
