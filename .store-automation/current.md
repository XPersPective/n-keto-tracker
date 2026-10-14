# Current Architecture

Verified present reality only. Markers: VERIFIED | OBSERVED | INFERRED | STALE | UNCONFIRMED.

## Runtime
- Flutter stable 3.47.2 / Dart 3.13.2; giriş `lib/main.dart`; Riverpod + go_router;
  Drift/SQLCipher + secure storage; Android release hattı Fastlane/CI.

## Map
<!-- path — role. Orientation index: read this instead of exploring. -->
- `lib/main.dart` — DB açılışı, içerik tohumlama, ProviderScope
- `lib/app/` — router, tema, 68 dil, locale
- `lib/core/database/` — Drift şeması, şifreli DB, repository ve seed'ler
- `lib/core/units/` — GKI, birimler, enerji, plan ve yürüyüş hesapları
- `lib/core/privacy/` — risk kilidi
- `lib/features/` — onboarding, dashboard, ölçüm, öğün, plan, ayarlar, kanıt
- `test/` — birim/widget erişilebilirlik testleri
- `integration_test/` + `test_driver/` — Android DoD akışı
- `tool/check_offline.sh` — manifest/dependency ağ denetimi
- `.github/workflows/ci.yml` — gitleaks, offline, format, analyze, test, APK
- `fastlane/` — Android release/internal/production otomasyonu
- `docs/RELEASE_EVIDENCE.md` — yayın ve emülatör kanıtları

## Domains

### Veri ve hesaplama
Status: VERIFIED
Sources: `lib/core/database/**`, `lib/core/units/**`, `test/core/**`
- Şifreli Drift DB; repository'ler; deterministik saf hesap motorları; import/export.
### UI ve erişilebilirlik
Status: VERIFIED
Sources: `lib/app/**`, `lib/features/**`, `test/features/**`, `test/accessibility/**`
- Offline onboarding, kayıt ekranları, plan/alışveriş, tema/dil ve hata/boş durumları.
### Platform ve release
Status: OBSERVED
Sources: `android/**`, `ios/**`, `fastlane/**`, `.github/**`, `integration_test/**`
- Android Play sürümü 1.0.0+6; iOS yayın ve tam 11 adım son kanıtı eksik.

## Known Unknowns
- iOS/macOS derleme ve App Store akışı bu Windows ortamında doğrulanamaz.
- Tam 11 adımlı offline entegrasyonun en güncel emülatör kanıtı tamamlanmamış.
- `test_marketing/` izlenmeyen; mağaza görselleri üretim hattı incelenmeli.
