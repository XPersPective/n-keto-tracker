# PB-005 — Release build sertleştirmesi

## Status

IN_PROGRESS

## Objective

ORTAK §1.4 + §8: R8 keep kuralları gözden geçirme (Drift), --obfuscate
--split-debug-info (repo dışı), usesCleartextTraffic=false doğrulaması,
yedekleme dışlamalarının aapt2 kanıtı, release APK emülatörde çalışır.

## Dependencies

- PB-004

## Affected Areas

- `android/app/proguard-rules.pro`
- `android/app/build.gradle.kts`
- `docs/AUDIT_RESULTS.md`

## Acceptance Criteria

- `flutter build apk --release --obfuscate --split-debug-info=../symbols`
  exit 0 (symbols/ repoya girmez)
- aapt2 dump çıktısında yedek dışlamaları kanıtlı
- Temel akış çalışıyor (kanıt: ekran/ smoke)

## Verification

Risk: HIGH

Required:
- Release build + aapt2 dump xmltree çıktısı belgeleme

## Architecture Impact

Expected: NO

## Decision Boundary

- Keystore imzası kullanıcı adımıdır (debug imzayla bırakılır)
