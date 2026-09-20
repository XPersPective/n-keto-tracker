# Katkı Rehberi — N Keto Tracker

Katkılarınız için teşekkürler. Bu rehber, ortam kurulumundan PR sürecine kadar
beklentileri tanımlar. Bağlayıcı ürün gereksinimleri `docs/MASTER_PROMPT.md`,
sahip standardı `ORTAK_UYGULAMA_STANDARDI.md`, proje durumu `PROJECT_BRAIN.md`
içindedir; çakışmada sağlık güvenliği/offline kuralları kazanır.

## Geliştirme ortamı

- Flutter **stable 3.47.2** (doğrulanmış sürüm; `flutter --version` ile kontrol edin)
- Android SDK / iOS derlemesi için Xcode (yalnızca iOS derlemesi gerekir)
- Python 3 (yalnızca `tool/` yardımcı betikleri için)

```bash
flutter pub get
flutter analyze --fatal-infos   # temiz olmalı
flutter test                    # yeşil olmalı
bash tool/check_offline.sh      # exit 0 olmalı
```

## Çalışma şekli

- **Branch/commit:** kısa ömürlü feature branch'ler (`feat/...`, `fix/...`,
  `docs/...`). Commit mesajı değişikliği özetler; görev kimliği varsa
  belirtir (ör. `feat(T12): eşleştirme penceresi`).
- **Her commit çalışır durumda olmalı:** analyze temiz + testler yeşil.
- **Kod üretimi:** Drift/freezed/json_serializable değişikliklerinde
  `dart run build_runner build --delete-conflicting-outputs` çalıştırın;
  üretilmiş dosyaları değişiklikle birlikte gönderin.
- **Biçim:** `dart format lib test tool` (CI `--set-exit-if-changed` ile
  kontrol eder).
- **Gizli anahtar/bağımlılık:** sır commit edilmez (`.gitleaks.toml`,
  pre-commit önerisi aşağıda). Yeni paket ancak mevcut set yetmediğinde,
  lisansı GPL-3.0 uyumluysa ve gerekçesi belirtilmişse eklenir.

### Pre-commit gitleaks önerisi

```bash
# gitleaks kuruluysa (https://github.com/gitleaks/gitleaks):
gitleaks protect --staged --redact -v
```

CI'da gitleaks her push/PR'da çalışır; yerelde bu kancayla erken yakalayın.

## Çevrimdışı ve mahremiyet ilkeleri (taviz verilemez)

- Ağ/telemetri/reklam/analitik/harici AI bağımlılığı **eklemeyin**;
  `tool/check_offline.sh` ve CI bunu engeller.
- Android manifest'lerine izin eklemeyin; debug loglarında sağlık verisi,
  profil, öğün, not veya ölçüm değeri yazmayın.
- Kullanıcı metinlerini widget içine gömmeyin; ARB dosyalarına ekleyin (TR+EN
  birlikte).

## Bilimsel içerik katkıları

Bu uygulama sağlık eğitimi içerir; doğruluk taviz verilemez:

1. Her iddianın **kaynağı** (DOI/PMID/PMCID + erişim tarihi) ve **kanıt
   sınıfı** (E1–E6) zorunludur; şema: `docs/EVIDENCE_SCHEMA.md`,
   doğrulanmış kaynak listesi: `docs/research/EVIDENCE_VERIFICATION.md`.
2. Künye bilgileri uydurulmaz; doğrulanamayan iddia eklenmez.
3. Hastalık çağrışımı yapan içerik yalnızca kullanıcının bilinçli seçimiyle
   açılan kaynaklar bölümünde yer alabilir; ana akışa taşınamaz.
4. Kesin sağlık dili ("tedavi eder", "garantili", "mucize") yasaktır.
5. Kaynak metinlerinin telifli tam hâli kopyalanmaz; özgün kısa özetler
   yazılır.

## Çeviri katkısı

- Yalnızca TR ve EN desteklenir; iki dil birlikte güncellenir
  (`test/app/l10n_completeness_test.dart` anahtar eşitliğini zorunlu kılar).
- Sayısal eşikler ve formüller iki dilde birebir aynı olmalıdır.

## Katkı lisans sözleşmesi

Bu depoya katkı göndererek, katkınızı **proje sahibine**, katkıyı mevcut
**GPL-3.0** lisansıyla kullanma, değiştirme ve yeniden lisanslama hakkı
çerçevesinde lisansladığınızı kabul edersiniz. Proje sahibi tek telif hakkı
sahibi olarak uygulamayı mağazalarda yayınlama hakkını korur. Bu sözleşme
katkının mülkiyetini devretmez; yalnızca projenin tek lisans altında
yaşayabilmesini sağlar.

## Sorun bildirimi

Hata ve özellik istekleri için GitHub Issues şablonlarını kullanın
(`.github/ISSUE_TEMPLATE/`). Güvenlik açıkları için `SECURITY.md`'ye bakın.
