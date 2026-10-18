# Target Architecture
Status: DRAFT

## Goal
"devral tüm isleri bitir" — mevcut N Keto Tracker projesindeki açık işleri doğrula, güvenli ve yetkili kapsamda kalan işleri tamamla, doğrulanamayanları kanıtlı biçimde bloke et. (user, imported)

## Target State
### Uygulama
- Android'de üretim kalitesinde, çevrimdışı ve reklamsız/satımsız keto takip uygulaması.
### Kanıt
- Sağlık verisi cihazda kalır; tahminler etiketlenir; test ve release kanıtları güncel tutulur.

## Users and Core Journeys
- Android/iOS kullanıcıları çevrimdışı keto, glukoz, keton ve GKI takibi yapar.
- Onboarding -> bugün -> öğün/ölçüm/kilo/semptom kaydı; veriler cihazda kalır.
- Plan -> tarif -> alışveriş listesi -> deterministik haftalık plan.
- Ayarlar -> JSON/CSV dışa/içe aktarma ve tüm veriyi silme.

## Platforms
- Android: Google Play (mevcut durum, doğrula).
- iOS: kaynak iskeleti; yayın akışı doğrulanmamış.

## Success Conditions
- [machine] Flutter testleri, analiz, format ve offline denetimi yeşil.
- [interaction] Temel offline onboarding ve kayıt akışları cihaz/emülatörde çalışır.
- [security] Release manifestlerinde ağ izni ve veri sızıntısı yoktur.

## Riskiest Assumption
- RA-1: Sağlık verisi tamamen cihazda kalır ve release APK ağsızdır; offline denetimi, testler ve release manifest taraması en ucuz ilk kanıttır.

## Non-Goals
- Bulut/hesap/CGM, kamera-barkod, AI, tanı/tedavi/doz önerisi, reklam, satın alma.
- App Store/Play Store yayınlama ve dağıtımı Project Brain kapsamı dışındadır.

## Open Decisions
- OD-001 OPEN: iOS yayın hedefi ve paket kimliği ne zaman kesinleştirilecek? -> iOS release.
