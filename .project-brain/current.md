# Current Architecture

## Scope

Repository-wide. Flutter mobil uygulaması N Keto Tracker (Android+iOS,
TR/EN, tamamen offline).

## Runtime

- Flutter stable 3.47.2, Dart 3.13.2 (VERIFIED: `flutter --version`)
- Giriş: `lib/main.dart` → ProviderScope → `lib/app/app.dart`
- Router: go_router (`lib/app/router.dart`) — `/onboarding` + 5 sekme
  (today/log/plan/trends/guide) + alt rotalar (/log/session,
  /meals/new, /weight/new, /symptoms/new, /plan/recipes/{id})
- Veri: Drift + SQLite, SQLCipher şifreli (`pubspec.yaml` hooks:
  sqlite3 source sqlcipher), anahtar flutter_secure_storage
- CI: `.github/workflows/ci.yml` (gitleaks → offline+format+analyze+test
  → release APK)

## Domains

### Veri Katmanı (`lib/core/database/`)

**Status:** VERIFIED

**Sources:**
- `lib/core/database/tables.dart` — 27 tablo (DataClassName, FK
  cascade/RESTRICT/SET NULL kararları yorumlu)
- `lib/core/database/database.dart` — schemaVersion 1, FK pragma,
  `loadOrCreateDatabaseKey` (32 byte CSPRNG → secure storage),
  `PRAGMA key` NativeDatabase.setup'ta
- Repositories: measurements (oturum onayı/ yeniden hesap/ geçersiz
  kılma), meal (toplamlar/ quick-repeat/ arama), symptom (11 tanım +
  needsGuidance), plan (savePlan/ collectIngredients/ createShoppingList),
  evidence_seeder, food_seeder (152 besin), recipe_seeder (20 tarif),
  export_import (JSON+CSV, rollback, deleteAllData)

### Saf Hesap Motorları (`lib/core/units/`)

**Status:** VERIFIED

- `gki.dart` — GkiEngine (glucoseMmolL=mgDl/18.0; GKI=mmolL/BHB;
  BHB≤0/glukoz≤0/NaN ret), GkiResult+formulaVersion ('gki-v1')
- `glucose.dart` — GlucoseValue (ham+birim+normalize; mmol/L'de çift
  dönüşüm yok), parseDecimal (TR virgül/EN nokta/binlik ayraç)
- `matching.dart` — MatchingEngine (pencere 1–15 dk, en küçük |Δt|,
  eşitlikte erken, kullanılmış ölçüm dışarı)
- `serving.dart` — scalePer100g/scaleItem (netCarb≥0)
- `energy.dart` — Mifflin–St Jeor (male2025 +5 / female161 −161),
  activityFactors, kapsam dışı ret (18 yaş altı/ gebelik/ atlandı)
- `weight.dart` — lbToKg/kgToLb (0.45359237), changeOverWindow
  (yetersiz veride null)
- `meal_measurement_relation.dart` — nearestPreviousMeal (pencere 1–4h,
  yalnız ÖNCEKİ) + confoundingFactors
- `plan_generator.dart` + `meal_plan_models.dart` — deterministik
  taslak (alerjen/kategori filtre, uygun yoksa null), ShoppingMerger
  (gram toplama, adet ayrı satır)
- `csv_safety.dart` — csvCell formül enjeksiyonu kaçışı, import
  header/boyut doğrulama

### UI (`lib/features/`, `lib/app/`)

**Status:** VERIFIED

- onboarding: 8 adım (dil→gizlilik→tıbbi-olmayan→amaç→profil→katsayı→
  risk taraması→veri+onam); consent_repository (sürüm+SHA-256 hash)
- dashboard: TodayPage (4 hızlı eylem, boş durumlar)
- measurements: MeasurementSessionForm (GKI kartı), LogPage (çizelge +
  3 ayrı grafik + bantlar varsayılan KAPALI + karıştırıcı eğitim kartı)
- nutrition: MealForm (arama→ekle→kaydet)
- symptoms: SymptomForm (yönlendirme mesajı nöbet/şiddet≥7)
- weight: WeightForm (kg/lb)
- meal_plans: PlanPage (taslak üret AppBar CTA, risk kilidi), shopping:
  ShoppingListPage
- evidence: GuidePage (12 gıda rehberi kartı) + EvidenceSection (7 kanıt
  kaynağı; hastalığa özel yalnız bilinçli filtreyle; URL yalnız kopyala)
- recipes: RecipesPage + RecipeDetailPage
- settings: GoalLegend (üç hedef türü), about_page (ORTAK §3.3: sürüm+
  slogan, açık kaynak, gizlilik, feragat, Lisanslar, Paylaş), data_
  management_page, other_apps_page (ORTAK §3.6 çevrimdışı uyarlama —
  gömülü assets/apps.json, ADR-PB-009; bozuk JSON çökmez, URL yalnız
  kopyala)
- privacy: risk_lock.dart (riskLockProvider + guardPlanGeneration →
  PlanLockedException)

### Platform Sertleştirmesi

**Status:** VERIFIED

- 3 manifest'te (main/debug/profile) INTERNET izni YOK
- usesCleartextTraffic=false; dataExtractionRules + backup_rules
  (database + FlutterSecureStorage hariç)
- R8 minify+shrink + proguard-rules.pro; kotlin.incremental=false
- `tool/check_offline.sh` (manifest + yasaklı paket taraması) CI'da

## External Dependencies

flutter_riverpod 3.4.3, go_router 18.0.1, drift 2.35.0, fl_chart 1.2.0,
freezed 4.0.2 (+annotation), json_serializable 6.14.1, intl 0.20.3,
path_provider 2.1.6 (ADR-0002), flutter_secure_storage (ADR-0001),
crypto — tümü MIT/BSD-3, GPL-3.0 uyumlu (THIRD_PARTY_NOTICES.md)

## Known Unknowns

- Debug attach (hot reload) INTERNET izni kaldırılınca emülatörde
  doğrulanmadı (T30'da test edilecek)
- Onboarding profil alanları UserProfile tablosuna henüz yazılmıyor
  (repo yok; T21 notu)
- Alerjen değerleri tarif seed'inde serbest metin; gıda rehberi E6
  etiketli (uzman incelemesi yayın öncesi şart)
