# Sertleştirme Denetim Sonuçları — N Keto Tracker

Tarih: 2026-09-20 · Görev: PB-004 · Kanıt türü: komut çıktıları + dosya
referansları. Her maddeye uygulanan kanıt belirtilir. Eksikler ayrı
işaretlenir, gizlenmez.

## 1. Ölçüm/hesap doğruluğu (MASTER §18 — Matematik ve veri)

- [x] GKI formülü ve mg/dL dönüşümü testli: `test/core/units/`
  (`gki_engine_test.dart`, 18 referans vektörü yeşil;
  90 mg/dL + 2,5 mmol/L → tam 2.0).
- [x] Ara yuvarlama yasak: 97/2.9 vakası ara yuvarlamadan ayrışır
  (aynı testte ispatlı).
- [x] UI/grafk/export/rapor aynı sürümlenmiş formül modülünü kullanır
  (grep testi: `test/core/units/formula_single_source_test.dart`).
- [x] Eşzamanlı eşleştirme deterministik (matching_engine_test.dart).

## 2. Çevrimdışı ve mahremiyet (§18 — Offline)

- [x] Manifest'lerde INTERNET yok: `bash tool/check_offline.sh` exit 0,
  manifest grep 0.
- [x] Yasaklı bağımlılık taraması otomatik (aynı betik).
- [x] DB şifreli: SQLCipher + secure storage; düz sqlite3 açılışı
  `SqliteException(code 26)` ile reddedilir (`test/core/database/
  encrypted_open_test.dart`).
- [x] Yedekleme dışlamaları: `data_extraction_rules.xml` +
  `backup_rules.xml` (manifest'te referanslı).
- [x] Sadece kullanıcı eylemili dışa aktarma: Veri yönetimi ekranı.
- [x] Import: şema doğrulama, boyut limiti, sıfır kısmi yazı (test:
  `export_import_test.dart`).

## 3. UX ve kalite (§18)

- [x] TR/EN tam kapsam: `l10n_completeness_test.dart` + `flutter gen-l10n`.
- [x] Hard-coded kullanıcı metni yok: analiz; tüm UI metinleri ARB'de.
- [x] En sık kayıt işlemleri ≤3 dokunuş: `today_page_test.dart`.
- [x] Büyük yazı testi: `text_scale_test.dart` (1.15x, 1.3x) + Next
  düğmesi ≥48dp.
- [x] Boş/hata durumları: dashboard ve LogPage boş durumları testli.
- [x] Hastalık adı varsayılan görünümde yok: `evidence_provenance_test`.
- [x] Nedensel dil lint'i: `causal_language_lint_test.dart`.

## 4. Veri bütünlüğü (§18)

- [x] Migration testleri: v1 — DB dosyası kapat/aç veri korunur +
  `PRAGMA integrity_check` == 'ok' (`migration_test.dart`).
- [x] Export→sil→import round-trip değer eşitliği (T26).
- [x] Ölçüm düzenleme → oturum deterministik yeniden hesap
  (`measurements_repository_test.dart`).

## 5. Sertleştirme ve release hazırlığı

- [x] Release APK derlenir (--release --obfuscate --split-debug-info)
  kanıtı: T8'de; gitleaks CI'da; dependabot.yml mevcut; lisanslar ve
  katkı dosyaları mevcut.
- [x] İkon seti özgün üretim (tool/gen_brand_icon.py) + platform
  boyutları (PB-001).
- [x] DoD entegrasyon testi emülatörde: onboarding→öğün→ölçüm→GKI→günlük
  (`integration_test/dod_flow_test.dart`) — 2026-09-20'de emülatörde
  çalışıp geçti ("All tests passed").

## Açık işler ve sınırlamalar

- **Golden testler**: taşınabilirliği tahmin edilemez (font/pixel
  toleransları); bunun yerine erişilebilirlik + widget testleri ve
  ekran görüntüsü yakalama `integration_test` ile yapıldı. Ek goldens
  istenirse PB-004 sonrası açılabilir.
- **SEMANTİK etiketler**: erişilebilirlik testleri `Next` butonu boyutu
  ve taşma kontrolünü doğrular; voice-over metin akışı widget testinde
  sınırlı simülasyonla kanıtlı. Muhtemel genişletme: daha fazla
  anahtar (Semantics) testi.
- **Tablet/yatay düzen** görsel olarak doğrulanmadı (cihaz görsel
  katman eksik); alt senaryolar PB-008'e taşınabilir.

## Komut referansları

```text
flutter analyze --fatal-infos         # temiz
flutter test                          # 183 test yeşil
bash tool/check_offline.sh            # exit 0
flutter test integration_test/dod_flow_test.dart --device-id emulator-5554
                                      # Geçti (uçak modu yerine INTERNET
                                      # izni yokluğu = eşdeğer kanıt)
```
