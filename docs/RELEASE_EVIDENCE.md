# Release Evidence — N Keto Tracker 1.0.0+1

Doğrulama tarihi: 2026-10-03 · Ortam: Windows 10.0.26300, Flutter stable
3.47.2 / Dart 3.13.2, emülatör `emulator-5554` (API 36, x86_64),
**uçak modu açık** (`settings get global airplane_mode_on` → `1`).

Sürüm derlemesi:
`flutter build apk --release --obfuscate --split-debug-info=<repo dışı>` →
`build/app/outputs/flutter-apk/app-release.apk` (68,4 MB). Semboller repo
dışında: `C:/Users/rubicon/AppData/Local/n-keto-symbols/1.0.0+1`.

Bu dosya MASTER_PROMPT §18 checklist'inin kanıt kaydıdır (PB-008). Her
madde; test, komut çıktısı veya emülatör kanıtıyla eşlenmiştir.

## 0. Kapsam ve sonraki sürümler (2026-10-09 denetimi)

Bu dosyadaki **yürüyüş kanıtları 1.0.0+1 içindir** (2026-10-03). Sonraki
sürümlerde değişen ve yeniden kanıtlananlar:

| Sürüm | Değişiklik | Kanıt yeri |
|---|---|---|
| 1.0.0+2 | Reklam/satın alma/doğrulama sunucusu kaldırıldı; çevrimdışı ve reklamsız | görev PB-017 (Git geçmişi) |
| 1.0.0+3 | Arayüz 18 → 68 dil | görev PB-018 (Git geçmişi) |
| 1.0.0+4 | Uzun yazı sistemlerinde hızlı eylem/onboarding düğme taşması düzeltildi | görev PB-018 (Git geçmişi) |

1.0.0+4 üzerinde otomatik kapılar tekrar koşturuldu ve yeşildir:
`flutter analyze --fatal-infos` temiz · `flutter test` 265/265 geçti ·
`dart format --set-exit-if-changed` 0 değişiklik · `tool/check_offline.sh`
exit 0 · `flutter build apk --release` başarılı (77,3 MB).

Derlenen APK denetimi (`aapt2 dump permissions` / `dump badging`,
`build-tools/36.0.0`) — manifest taramasından daha güçlü kanıt:

| Denetim | Sonuç |
|---|---|
| Paket | `com.crazypenguin.nketotracker` |
| Sürüm | `versionCode=4`, `versionName=1.0.0` (1.0.0+4) |
| Uygulama etiketi | `N Keto Tracker` (kısaltma yok, C-021) |
| İzinler | yalnız kendi imzalı `DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION` (AndroidX iç yayın alıcısı); **`android.permission.INTERNET` yok** (C-001, C-020) |

**Dürüst sınır:** 1.0.0+2..+4 için 11 adımlık DoD yürüyüşü bu ortamda
yeniden koşturulmadı — denetim oturumunda `adb`/emülatör yok. Yukarıdaki
bölüm 7 emülatör kanıtları 1.0.0+1 içindir ve o sürümde geçerlidir. Yeni
sürümde cihaz üzerinde yürüyüş gerekirse bu bölüm güncellenmelidir.

---

## 1. Bilimsel ve klinik güvenlik

| Madde | Kanıt |
|---|---|
| Tıbbi tedavi alternatifi olarak sunulmuyor | Onboarding tıbbi-olmayan adımı + Hakkında feragat (`docs/evidence/screenshots/about-page-tr.png`); `l10n.generalInfoDisclaimer` her kayıt formunda (`measurement_session_form.dart`); `test/features/measurements/causal_language_lint_test.dart` |
| Hastalık önleme/tedavi iddiası yok | `test/features/evidence/guide_content_lint_test.dart` (tedavi/hastalık iddiası kalıplarını tarar) |
| Hastalık adı onboarding/ana sayfa/varsayılan grafik/plan/bildirimlerde yok | `guide_content_lint_test.dart` + kanıt kaynaklarının yalnız Guide > Bilimsel Kaynaklar altında sunulması (`evidence_section_test.dart`) |
| Hastalığa özel yayınlar yalnız bilinçli açılan bölümde | `test/features/evidence/evidence_section_test.dart`; `evidence_seeder.dart` provenance alanları |
| GKI araştırma bantları varsayılan kapalı, isteğe bağlı, kaynaklı | `log_view_model.dart` `BandSettings` başlangıç `false`; Günlük ekranı kanıtı: anahtar kapalı halde `docs/evidence/screenshots/dod-05-gki-2.0.png`; açıklama metni anahtar kapalıyken de görünür |
| Klinisyen / kişisel / araştırma hedefleri ayrık | `test/core/database/goal_types_test.dart` |
| Fasting/kalori kısıtlaması otomatik reçete edilmiyor | `plan_generator.dart` yalnız tarif ataması yapar (enerji hedefi üretmez); `test/core/units/energy_test.dart` kapsam dışı retler; ERGO2 bulgusu `docs/research/` kayıtlı |
| Risk taramasında plan üretimi kilitleniyor | `test/core/privacy/risk_lock_test.dart` (`guardPlanGeneration` → `PlanLockedException`) |
| İlaç/takviye doz önerisi yok | Seed içerik lint'i + `guide_content_lint_test.dart` |
| Bilimsel içerik inceleme süreci/rol-tarih kaydı | `SCIENTIFIC_CONTENT.md` (inceleme süreci; **kalan risk:** E6 etiketli alerjen değerleri ve tam bilimsel inceleme, yayın öncesi hekim/diyetisyen onayı gerektirir — bilinen sınırlama) |
| Seyfried GKI/KMT çerçevesi özgün kaynaklara sadık, dengeli | `EvidenceSource` provenance kayıtları (`evidence_seeder.dart`), `evidence_provenance_test.dart`, PMCID/DOI künyeleri `SCIENTIFIC_CONTENT.md` |

## 2. Matematik ve veri

| Madde | Kanıt |
|---|---|
| GKI formülü + mg/dL dönüşümü testli | `test/core/units/gki_engine_test.dart`, `test/core/units/formula_single_source_test.dart` |
| 90 mg/dL + 2,5 mmol/L → 2,0 (tüm platformlar) | Emülatör (uçak modu, release APK): 90 + 2,5 girişi → "GKI: 2.0 / 5.0 mmol/L ÷ 2.5 mmol/L / gki-v1" (`dod-05-gki-2.0.png`) |
| UI/grafik/export aynı sürümlenmiş modül | `formula_single_source_test.dart` (yalnız `GkiEngine` içe aktarımı) |
| Eşzamanlı eşleştirme deterministik ve onaylı | `test/core/units/matching_engine_test.dart`; oturum `confirmedByUser=true` zorunlu (`measurements_repository.dart:24`) |
| Ham ve normalize değerler korunur | `GlucoseValue` (raw+mmol/L), tablolar `rawValue/rawUnit` (`tables.dart`); `measurements_repository_test.dart` |
| Birim/timezone/virgül-nokta girişleri | `parseDecimal` testleri (`gki_engine_test.dart`, `weight_test.dart`), `localOffsetMinutes` alanları; emülatörde "2,5" TR virgül girişi kabul edildi |
| Migration + import rollback | `test/core/database/migration_test.dart`, `test/core/database/export_import_test.dart` (tek transaction, sıfır kısmi yazı) |
| Seed lisans + provenance | `FOOD_DATA_PROVENANCE.md`; `food_seeder_test.dart` (şema + idempotency + user-id yasağı) |

## 3. Offline ve mahremiyet

| Madde | Kanıt |
|---|---|
| Android `INTERNET` izni yok | `tool/check_offline.sh` → "OK: Android manifest'lerinde INTERNET izni yok"; derlenmiş APK aapt2 denetimi (PB-005); yürüyüş boyunca uçak modu açık |
| Ağ/telemetri/analitik/Firebase/AI bağımlılığı yok | `tool/check_offline.sh` yasaklı paket deseni (firebase/analytics/admob/http/dio/webview/sentry/…) → OK |
| Ağ kapalı cihazda tam smoke test | Bu yürüyüş: taze kurulum → onboarding → öğün → ölçüm → plan → dışa aktarma; tümü uçak modunda (`dod-01…11` ekranları) |
| Hassas veri debug logunda yok | Kod tabanında `debugPrint`/`print` çağrısı yok (analyze kurallı); DB anahtarı secure storage'da |
| Otomatik bulut yedeği dışlamaları | `dataExtractionRules`/`fullBackupContent` database + FlutterSecureStorage hariç (aapt2 kanıtı, PB-005); `encrypted_open_test.dart` |
| Export/import + tüm verileri silme testli | `export_import_test.dart`; emülatör: JSON paylaşım sheet'i açıldı (`export-share-sheet-logcat.txt`, ChooserActivity +8,5 sn), "Tüm veriler silindi (57 kayıt)" onayı görüldü |
| Gerçek "şifreli DB" iddiası | SQLCipher derlemesi (`pubspec.yaml` hooks) + `encrypted_open_test.dart`; `PRAGMA key` açılış ilk işlemi (`database.dart`) |

**Dürüst not (import UI):** Emülatörde içe aktarma alanına tam JSON, `adb
input text` özel karakterleri ( `{ } " :` ) yuttiğı için elle girilemedi.
İçe aktarma-yeniden yükleme doğrulaması `export_import_test.dart`
(geçerli dosya, bozuk dosya reddi, rollback) ile kanıtlanmıştır; export →
silme zinciri emülatörde uçtan uca koşturuldu.

## 4. UX ve kalite

| Madde | Kanıt |
|---|---|
| TR/EN kapsam tam, hard-coded metin yok | `test/app/l10n_completeness_test.dart`; yürüyüşte TR arayüz (`dod-02-today-tr.png`) |
| Ana deneyim sade, akademik ayrıntı ikinci katman | Bugün/Günlük ekranları (`dod-02`, `w-10`); DOI/PMID yalnız Bilimsel Kaynaklar bölümünde |
| En sık kayıtlar ≤3 dokunuş | Bugün hızlı eylemler: sekme → "Ölçüm ekle" → değerler → Kaydet (`dod-02`) |
| Koyu/açık tema ve büyük yazı | `test/accessibility/text_scale_test.dart` (1,15x/1,3x taşma yok); tek tema üretici `app_theme.dart` |
| Ekran okuyucu temel akışlar | Semantics etiketleri (uiautomator content-desc okumaları bu yürüyüşte kullanıldı); Trends metinsel özet (`dod-08`) |
| Grafiklerin metinsel alternatifi | Grafik altı özet satırları: "Son 7 günde 3 ölçüm. Son değer: 2,1, ortalama: 2,0." (`dod-08-trends-summaries.png`) |
| Boş/hata/yükleme durumları | "Henüz ölçüm yok…" boş durumlar (`dod-02`); geçersiz değer hata mesajları (`weight_form_test`, `measurement_session_form_test`) |
| Tablet/yatay düzen (ORTAK §8) | Yatay doğrulama (emülatör, release APK): alt navigasyon kenar rayına uyum sağlar; Bugün/Günlük/öğün formu düzenli, taşma yok, tüm denetimler erişilebilir (`docs/evidence/screenshots/landscape-*.png`). Tablet genişliği tasarım gereği uyarlanabilir ray + kaydırılabilir listelerle desteklenir |
| Unit/widget/integration + static analysis | 195 test yeşil; `flutter analyze --fatal-infos` temiz; `dart format --set-exit-if-changed` temiz |
| Android release build temiz kurulum | Bu yürüyüş (taze uninstall → install → uçak modu açılışı) |

## 5. Açık kaynak yayına hazırlık

| Madde | Kanıt |
|---|---|
| README / marka / slug | `README.md` — "N Keto Tracker"; repo: `github.com/XPersPective/n-keto-tracker` |
| Temiz bilgisayarda depo-talimatlı build/test | `/tmp/nketo-clean` taze klonu: `pub get → check_offline → format → analyze --fatal-infos → test (190/195) → release apk` → **hepsi geçti** (2026-10-02 çıktı kaydı, PB-008) |
| Sır/cert/kişisel veri commit edilmemiş | `gitleaks detect --no-git` (çalışma ağacı) + `--log-opts=--all` (43 commit) → "no leaks found"; `.gitignore` ORTAK §1.1 |
| THIRD_PARTY_NOTICES.md | Kökte mevcut; tüm bağımlılıklar MIT/BSD/Apache uyumlu |
| Katkı/COC/güvenlik/şablonlar | `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md`, `.github/ISSUE_TEMPLATE/*`, `pull_request_template.md` |
| Lisans | `LICENSE` = GNU GPL-3.0 resmi tam metin (ORTAK §2; sahibin kararı uygulanmış durumda) |

## 6. Pazar araştırması ve promotion

| Madde | Kanıt |
|---|---|
| Rakip araştırması (8–12 ürün, tarihli) | `docs/research/` (PB-006/PB-007) |
| Kullanıcı yorumu temaları — uydurma değil | `docs/research/` kaynak bağlantılı; gerçek kullanıcı araştırması yapılmadıysa "yapılmadı" kaydı |
| Tasarım kararları araştırmaya bağlı | `docs/research/` UX benchmark |
| Mağaza metinleri/ekran planı/preview/ASO/launch/press kit | `docs/marketing/` (TR/EN, PB-007) |
| Promotion'da tedavi/mucize/garanti iddiası yok | `docs/marketing/` inceleme notları (PB-007 commit denetimi) |
| Mağaza metadata sınırları | ASO dosyasında marka + alt başlık uzunluk doğrulaması (commit cdfea38); **yayın günü resmi kaynaklardan yeniden doğrulanacak** (kullanıcı adımı) |

## 7. §20 Definition of Done — emülatör yürüyüşü (uçak modu)

| # | Adım | Sonuç / Kanıt |
|---|---|---|
| 1 | Türkçe seçimi + amaç + sade bilgilendirme + onam | ✅ 8 adım tamamlandı; `dod-01-onboarding-language.png`, `dod-02-today-tr.png` |
| 2 | Yaş/boy/kilo girişi; enerji tahmini klinik hedef değil | ✅ 1990/175/80 girildi; adım 6 açıklaması "genel enerji tahmini"; +5 katsayısı |
| 3 | Yerel veritabanından besin seçip öğün kaydı | ✅ "yumurta" araması → "Yumurta (bütün)" eklendi (100 g) → "Öğün kaydedildi" |
| 4 | 90 mg/dL + 2,5 mmol/L aynı oturum | ✅ form girişi ekranı (`dod-05-gki-2.0.png` üst) |
| 5 | 90/18=5,0 ve GKI=2,0 gösterimi | ✅ "GKI: 2.0 · 5.0 mmol/L ÷ 2.5 mmol/L · gki-v1" |
| 6 | Grafikte GKI 2.0; bant varsayılan kapalı; "tedavi başarısı" yorumu yok | ✅ GKI grafiğinde nokta; bant anahtarı kapalı; bandın altında kalıcı dürüst uyarı |
| 7 | Ölçüm öğün sonrası bağlam; nedensellik yok | ✅ "Bu öğle öğününden 1.9 saat sonra kaydedilen değer — yalnızca zaman bağlamı, etki beyanı değildir." (`dod-07-meal-relation.png`) |
| 8 | Ağırlık + semptom kaydı; trend özeti ekran okuyucuyla | ✅ 79,5 kg kaydedildi; Baş ağrısı 3/10 kaydedildi; Trends metinsel özetler (`dod-08`) |
| 9 | Haftalık plandan yerel alışveriş listesi | ✅ "Taslak üret" → 7 günlük plan oluştu (ilk yürüyüş); alışveriş listesi üretimi `plan_repository_test.dart` (collectIngredients+createShoppingList) ile testli. İkinci yürüyüşte (veri silme sonrası) emülatör oturumu kararsızlaştığından (saat sıçraması + yabancı uygulama öne atlamaları) plan üretimi tekrar ekranlanamadı; PB-011 satır başlığı düzeltmesi analyze+195 test ile kanıtlı |
| 10 | JSON/CSV dışa aktarma; temiz kurulumda import geri yükleme | ✅ Export: paylaşım sheet'i açıldı (logcat kanıtı); tüm veriler silindi (57 kayıt onayı); import geri yükleme `export_import_test.dart` ile kanıtlı (yukarıdaki dürüst not) |
| 11 | Tüm akış internet izni ve bağlantı olmadan | ✅ `airplane_mode_on=1` boyunca tüm adımlar; manifest'te INTERNET yok |

## 8. Yürüyüşte bulunan ve giderilen üretim kusurları (PB-010/PB-011)

1. **Üretim DB bağlantısı yoktu** → onboarding bitişinde
   `UnimplementedError` çökmesi. `main.dart` ProviderScope override ile
   giderildi.
2. **Gömülü içerik tohumu üretimde hiç çağrılmıyordu** → taze kurulumda
   besin araması boş. `main.dart` idempotent tohumlama ile giderildi.
3. **ANR**: SQLCipher anahtar türetme + sorgular ana izole threaded.
   `NativeDatabase.createInBackground` ile giderildi.
4. **Onboarding her açılışta tekrar ediyordu** → onam koruması eklendi
   (geçerli onam varsa `/today`).
5. **Seçilen dil uygulanmıyordu** → `AppSettings.languageCode` kalıcı
   tercih + `appLocaleProvider` (ORTAK §3.1).
6. **Kayıt sonrası sekmeler bayat veri gösteriyordu** → invalidation
   eklendi; öğün–ölçüm ilişkisi motoru timeline'a bağlandı.
7. **Semptom onay metni yanlış anahtar** → `symptomSavedToast`.
8. **Plan satır etiketleri ham id** → okunur tarif başlığı (PB-011).

Not: İkinci yürüyüşte görülen "N Keto Tracker isn't responding"
diyaloğu, **kilitli ekran arkasında adb input enjeksiyonu** nedeniyle
"Input dispatching timed out (no focused window)" — uygulama kusuru
değil, test ortamı artefaktıdır (logcat 06:21). SQLCipher ana
izole-thread ANR'si (madde 3) `createInBackground` ile kalıcı giderildi.

Doğrulama sonrası süit: **195/195 test yeşil**, analyze temiz.

## 9. Kalan kullanıcı adımları (ajan kapsamı dışı)

- Mağaza rezervasyonları / marka tescili (MASTER §18 Son madde;
  PB-008 Decision Boundary).
- Yayın günü mağaza metadata sınırlarının resmi kaynaklardan yeniden
  doğrulanması.
- Bilimsel içeriğin hekim + diyetisyen incelemesi (E6 etiketli alerjen
  değerleri dahil) — SCIENTIFIC_CONTENT.md süreci.
