# Current Architecture

Verified present reality only. Markers: VERIFIED | OBSERVED | INFERRED | STALE | UNKNOWN.

## Runtime
- Prior Store Automation record: Flutter stable 3.47.2 / Dart 3.13.2; entry `lib/main.dart`; Riverpod + go_router; Drift/SQLCipher + secure storage; Android release via Fastlane/CI. Current versions and wiring need revalidation.

## Map
- `lib/main.dart` — DB startup, content seeding, ProviderScope
- `lib/app/` — router, theme, 68 languages, locale
- `lib/core/database/` — Drift schema, encrypted DB, repositories and seeds
- `lib/core/units/` — GKI, units, energy, plan and walk calculations
- `lib/core/privacy/` — risk lock
- `lib/features/` — onboarding, dashboard, measurement, meal, plan, settings, evidence
- `test/` — unit/widget/accessibility tests
- `integration_test/` + `test_driver/` — Android DoD flow
- `tool/check_offline.sh` — manifest/dependency network audit
- `.github/workflows/ci.yml` — gitleaks, offline, format, analyze, test, APK
- `fastlane/` — Android release/internal/production automation
- `docs/RELEASE_EVIDENCE.md` — release and emulator evidence

## Domains

### Data and calculations
Status: STALE
Sources: `lib/core/database/**`, `lib/core/units/**`, `test/core/**`
- Encrypted Drift DB, repositories, deterministic pure calculation engines, import/export.
### UI and accessibility
Status: STALE
Sources: `lib/app/**`, `lib/features/**`, `test/features/**`, `test/accessibility/**`
- Offline onboarding, records, plan/shopping, theme/language and error/empty states.
### Platform and release
Status: STALE
Sources: `android/**`, `ios/**`, `fastlane/**`, `.github/**`, `integration_test/**`
- Android Play version 1.0.0+6 (reverify); iOS release and latest full 11-step evidence are incomplete.

## Known Unknowns
- iOS/macOS build and App Store flow cannot be verified on this Windows host; publishing is out of scope.
- Latest 11-step offline integration emulator evidence is incomplete.
- `test_marketing/` is untracked; inspect the screenshot pipeline before changing it.
