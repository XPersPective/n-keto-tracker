# PB-016 — Google Play yayını

## Status
IN_PROGRESS

## Objective
Kullanıcı protokolüne (D:/AppPublishing/README.md) uygun, imzalı AAB; Play
Console beyanları, 18 dilli mağaza girişi, Pro ürünü; üretime gönderim.

## Dependencies
PB-012..PB-015 (tamam)

## Acceptance Criteria
- AAB upload anahtarıyla imzalı, gerçek AdMob/Pro kimlikleriyle: DONE (SHA-256 eşleşti)
- İç test yüklemesi: DONE (2026-10-05, fastlane deploy_internal)
- Console beyanları: Reklam, Oturum bilgileri, İçerik derecelendirme, Hedef kitle: DONE;
  Gizlilik politikası, Veri güvenliği, Sağlık, Resmi kurum, Finans, Reklam kimliği,
  kategori/iletişim, mağaza girişi: TODO
- Pro ürünü (com.crazypenguin.nketotracker.pro_lifetime, 149,99 TRY/4,99 USD): TODO (Console UI)
- Mağaza metni 18 dil: DONE (D:/AppPublishing/apps/n-keto-tracker/stores/google-play/metadata); ekran görüntüleri: TODO
- Üretim gönderimi (ilk sürüm: PLAY_RELEASE_STATUS=draft fastlane deploy_production + Console gönderimi): TODO

## Verification
Risk: HIGH — AAB imza/izin/bayrak denetimi yapıldı; Console beyanları gerçek davranışla uyumlu olmalı.

## Resume notes
Verified: AAB imzası, manifest (INTERNET, ACCESS_NETWORK_STATE, AD_ID, BILLING; debuggable=false;
allowBackup=false), iç test yüklemesi, 4 Console beyanı.
Incomplete: aşağıdaki TODO'lar. Gizlilik URL'si herkese açık olmalı; GitHub deposu anonim
erişimde 404 (private) — kullanıcı public yapmalı ya da başka bir herkese açık URL vermeli.
Known failures: Browser paneli gizliyken Console'da fiyat tablosu toplu düzenleme (tek seferlik
ürün) ve ekran görüntüsü alınamıyor; JS ile mat-checkbox'a MouseEvent dizisi gönderilince çalışır.
Dirty areas: yok (screenshot hattı integration_test/store_screenshots_test.dart + test_driver/).
Next action: ekran görüntüleri → AppPublishing metadata/images; Veri güvenliği formu; ürün;
fastlane push_metadata; deploy_production (draft) → Console'dan gönder.

## Decision Boundary
Play Console girişi/mağaza gönderimi kullanıcı yetkisinde verildi (2026-10-05, "yayınla").
