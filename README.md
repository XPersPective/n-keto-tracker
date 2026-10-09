# N Keto Tracker

**Private, open-source keto, glucose, ketone and GKI tracking — your health data never leaves your device.**
(Gizliliğe önem veren, açık kaynaklı keto günlüğü; glukoz, keton ve GKI takibi.)

[![Ekran görüntüleri yer tutucu — ilk sürümde eklenecek](https://img.shields.io/badge/screenshots-placeholder-lightgrey)](#)

> **Sağlık uyarısı:** Bu uygulama genel bilgilendirme ve kişisel takip içindir;
> tıbbi tavsiye, tanı veya tedavi değildir. Sağlık kararlarınızı daima uygun
> sağlık uzmanıyla görüşün.

## Neden bu uygulama?

- **Sağlık verisi cihazdan çıkmaz.** Hesap yok, bulut yok, telemetri yok,
  reklam yok, satın alma yok. Uygulama `INTERNET` iznini istemez ve
  `tool/check_offline.sh` bunu her derlemede kanıtlar.
  Verileriniz yalnızca cihazınızda, şifreli veritabanında tutulur.
- **Açık kaynak.** Tüm kod GPL-3.0 ile incelenebilir; GKI hesabı sürümlenmiş
  tek bir saf modüldedir ve referans test vektörleriyle kilitlenmiştir.
- **Keto günlüğü:** öğün, makro, net karbonhidrat takibi (planlanan).
- **Glukoz + kan ketonu (BHB) + GKI:** mg/dL veya mmol/L girişte birim
  dönüşümü testlidir; 90 mg/dL + 2,5 mmol/L → tam 2,0 GKI referans vakası
  olarak sabitlenmiştir.
- **68 dil**, açık/koyu/sistem teması.

## Özellik durumu

Bu depo geliştirme aşamasındadır; özellikler aşama aşama eklenir
(yol haritası: `PROJECT_BRAIN.md` §5). Temel hedefler: öğün/makro günlüğü,
ölçüm oturumları ve açıklanabilir GKI, haftalık plan/tarif/alışveriş listesi,
ağırlık ve semptom takibi, kaynaklı sade bilimsel rehber, CSV/JSON dışa/içe
aktarma.

## Mimari

```text
lib/
  app/      uygulama kökü, 5 sekmeli yönlendirici (Bugün/Günlük/Plan/Trendler/Rehber),
            Material 3 tema (tek üretici), TR/EN l10n
  core/     yapılandırma; (yol üzerinde) Drift veritabanı, saf hesap motorları
            (GKI, birimler, Mifflin–St Jeor), doğrulama
  features/ özellik odaklı ekranlar (onboarding, measurements, nutrition, ...)
```

- Durum yönetimi Riverpod, gezinme go_router, veri Drift+SQLite,
  grafikler fl_chart, model/serileştirme freezed + json_serializable.
- Formüller saf ve deterministiktir; `test/fixtures/gki_reference_cases.json`
  referans vektörleriyle test edilir; formül başka yerde tekrar yazılmaz.
- Çevrimdışı garanti: manifest'lerde ağ izni yok; yasaklı bağımlılık taraması
  CI'da her derlemede çalışır.

## Hızlı kurulum

Gereksinim: Flutter **stable 3.47.2** (doğrulanmış kurulum sürümü).

```bash
git clone https://github.com/XPersPective/n-keto-tracker.git
cd n-keto-tracker
flutter pub get          # bağımlılıklar + l10n üretimi
flutter analyze          # statik analiz (--fatal-infos)
flutter test             # birim + widget testleri
flutter run              # cihaz/emülatörde çalıştır
```

### Kod üretimi

Drift/freezed/json_serializable üretimi gerektiren dosyalar eklendiğinde:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Yerelleştirme (ARB → Dart) `flutter pub get` ile otomatik üretilir
(`l10n.yaml`; çıktı `lib/app/l10n/generated/`, depoya girmez).

### Çevrimdışı doğrulama

```bash
bash tool/check_offline.sh
# Manifest izinleri allowlist'te; ağ kodu yalnız monetization içinde
# pubspec doğrudan bağımlılıkları yasaklı desen içermiyor
```

### Yayın derlemesi (Android)

```bash
flutter build apk --release   # R8 küçültme + kaynak budama etkindir
```

İmzalama sırları repoda tutulmaz; `android/key.properties.example` dosyasına
bakın. **Keystore yedekleme uyarısı:** yayın imzalama anahtarını kaybederseniz
Google Play'de aynı uygulama kimliğiyle güncelleme yapamazsınız — keystore'u
güvenli ve yedekli saklayın (değeri yoktur, yeniden üretilemez).

## Gizlilik

Gizlilik politikası: `docs/privacy/index.md` (GitHub Pages yayınlanır).

## Katkı

Katkı rehberi: [CONTRIBUTING.md](CONTRIBUTING.md) · Davranış kuralları:
[CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) · Güvenlik bildirimi:
[SECURITY.md](SECURITY.md)

Bilimsel içerik katkılarında kaynak/provenance zorunludur; bkz.
`docs/EVIDENCE_SCHEMA.md` ve `SCIENTIFIC_CONTENT.md` (yol üzerinde).

## Lisans

[GPL-3.0](LICENSE). Kod herkese açıktır; okuyabilir, değiştirebilir,
dağıtabilirsiniz; dağıtan aynı lisansla kaynak kodunu açmak zorundadır.

**"N Keto Tracker" adı ve logosu markadır; GPL lisansına dahil değildir.**
Marka adı her dilde değişmeden `N Keto Tracker`'dır; `N` tek başına marka
harfidir, bir kelimenin kısaltması olarak açılmaz.

---

Repo slug: `n-keto-tracker` · Proje durumu ve çalışma protokolü:
`PROJECT_BRAIN.md` (ölçekli geliştirme beyni).
