# PB-001 — Marka ikonları + splash

## Status

IN_PROGRESS

## Objective

Özgün N Keto Tracker ikon setini tüm platform boyutlarında üretip
referanslamak (Android uyarlanabilir + monokrom, splash, iOS opak);
Flutter varsayılan logosu kalmaz.

## Dependencies

- None (T4 platform iskeleti tamam)

## Affected Areas

- `tool/brand/generate_icons.py`
- `tool/gen_brand_icon.py`
- `assets/brand/**`
- `android/app/src/main/res/**`
- `ios/Runner/Assets.xcassets/**`

## Acceptance Criteria

- `assets/brand/brand_icon_1024.png` üretilmiş (özgün, sakin tasarım)
- `python tool/brand/generate_icons.py --source assets/brand/brand_icon_1024.png --app-root . --background "#0A3D66"` exit 0
- Android mipmap dosyaları güncel; iOS AppIcon dosyaları güncel
- `grep -ri "ic_launcher" android/app/src/main/AndroidManifest.xml` özel
  ikona işaret ediyor (varsayılan name zaten @mipmap/ic_launcher)
- Derleme bozulmaz: `flutter build apk --debug` exit 0

## Verification

Risk: LOW

Required:
- Yukarıdaki komutlar
- `git status` ile üretilen dosya listesi

## Architecture Impact

Expected: NO

## Decision Boundary

- İkon görsel tasarımı (sakin teal + N glifi + keton çizgisi) agent
  kararı; kullanıcı marka onayı yayın öncesi adımıdır

## Resume

Verified:
- `tool/gen_brand_icon.py` yazıldı (N glifi + dalga)
- Pillow kurulu doğrulandı

Incomplete:
- Kaynak ikon çalıştırılıp üretilmedi
- generate_icons.py platform çıktıları alınmadı
- THIRD_PARTY_NOTICES varlık kaydı güncellenmedi

Next action:
- `python tool/gen_brand_icon.py` çalıştır, ardından generate_icons.py
  ile platform çıktılarını üret
