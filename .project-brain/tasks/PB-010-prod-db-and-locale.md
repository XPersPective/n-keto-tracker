# PB-010 — Üretim DB bağlantısı + dil tercihi uygulaması

## Status

IN_PROGRESS

## Objective

PB-008 DoD yürüyüşünde emülatörde (uçak modu, release APK) bulunan iki
üretim hatasını düzeltmek:

1. **KRİTİK — üretim DB bağlantısı yok:** `appDatabaseProvider`
   (providers.dart) `UnimplementedError` fırlatır; lib/ içinde HİÇBİR
   yerde override edilmiyor (yalnız entegrasyon testlerinde). Onboarding
   bitirilirken (consent kaydı) release derleme çöküyor:
   `UnimplementedError: appDatabaseProvider uygulama başlangıcında
   override edilmelidir` (logcat 2026-10-02 19:33/19:34, emulator-5554).
   main.dart ProviderScope'unu gerçek `AppDatabase()` ile override etmeli.
2. **ORTAK §3.1 — dil tercihi uygulanmıyor:** Onboarding'de seçilen dil
   yalnız ConsentRecords'a yazılıyor; `MaterialApp.locale` yalnız cihaz
   dilinden çözülüyor. AppSettings.languageCode alanı tanımlı ama hiç
   kullanılmıyor. Seçim kalıcı hale getirilip yerel ayara uygulanacak
   (AppSettings.languageCode + onboardingCompleted yazılır; appLocaleProvider
   okur). Tema seçimi (ORTAK §3.2) bu görevin dışıdır — AppSettings.themeMode
   UI'sız alan olarak kalır, ayrı görev gerekir.
3. **KRİTİK — gömülü içerik tohumu üretimde çağrılmıyor:** FoodSeeder /
   RecipeSeeder / EvidenceSeeder lib/ içinde hiçbir yerde kullanılmıyor
   (yalnız testler). Taze kurulumda besin/tarif/kanıt tabloları boş;
   öğün kaydı besin bulamıyor (emülatörde doğrulandı: "yumurta" araması
   sonuç döndürmedi). main.dart açılışta idempotent tohumlama yapacak.
4. **KRİTİK — ANR:** "N Keto Tracker isn't responding" (emülatör,
   taze kurulum ilk açılış). NativeDatabase sorguları ANA izole
   threaded: SQLCipher PBKDF2 anahtar türetme + tohumlama ana thread'i
   bloke ediyor. `NativeDatabase.createInBackground` + setup ile arka
   plan izolesine taşındı (setup closure izolede çalışır, key String
   gönderilebilir).

## Dependencies

None.

## Affected Areas

- `lib/main.dart`
- `lib/core/database/settings_repository.dart` (yeni)
- `lib/app/locale_provider.dart` (yeni)
- `lib/app/app.dart`
- `lib/features/onboarding/onboarding_page.dart` (_finish)
- testler

## Acceptance Criteria

- Release APK'da onboarding bitirilir → Today ekranı açılır, çökme yok
  (emülatör, uçak modu).
- Türkçe seçimi yapılmış kurulumda uygulama sonraki açılışta cihaz dili
  İngilizce olsa bile Türkçe açılır.
- Taze kurulumda besin araması kayıt döner (tohum üretimde çalışır).
- flutter analyze temiz, flutter test yeşil.

## Verification

Risk: HIGH (kalıcılık + üretim başlangıç yolu)

Required: birim testler + emülatörde release APK doğrulaması (PB-008
DoD yürüyüşüyle birleşik).

## Architecture Impact

YES — current.md: main.dart girişi + AppSettings kullanımı güncellenir.

## Decision Boundary

- Tema seçimi UI'sı kapsam dışı bırakıldı (ajan kararı, kayıt: yukarıda).
