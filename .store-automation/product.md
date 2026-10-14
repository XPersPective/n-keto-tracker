# Product
Status: DRAFT

Confirmed intent only. DRAFT until the user confirms the Goal. Unknown -> Open Decisions.

## Goal
"devral tüm isleri bitir" — mevcut N Keto Tracker projesindeki açık işleri
doğrula, güvenli ve yetkili kapsamda kalan işleri tamamla, doğrulanamayanları
kanıtlı biçimde bloke et.

## Users
- Android/iOS kullanıcıları — çevrimdışı keto, glukoz, keton ve GKI takibi.

## Core Journeys
- Onboarding -> bugün -> öğün/ölçüm/kilo/semptom kaydı -> veriler cihazda kalır.
- Plan -> tarif -> alışveriş listesi -> deterministik haftalık plan.
- Ayarlar -> JSON/CSV dışa/içe aktarma ve tüm veriyi silme.

## Platforms
- Android: Google Play (yayında); iOS: kaynak iskeleti, yayın akışı doğrulanmamış.

## Success Conditions
- [machine] Flutter testleri, analiz, format ve offline denetimi yeşil.
- [interaction] Temel offline onboarding ve kayıt akışları cihaz/emülatörde çalışır.
- [security] Release manifestlerinde ağ izni ve veri sızıntısı yoktur.

## Riskiest Assumptions
- RA-1: Sağlık verisinin tamamen cihazda kalması ve release APK'nın ağsız olması;
  en ucuz prob offline denetimi + test + release manifest taramasıdır.

## Target State
### Uygulama
- Android'de üretim kalitesinde, çevrimdışı ve reklamsız/satımsız uygulama.
### Kanıt
- Hesaplar kaynaklı, tahminler etiketli, test ve release kanıtları güncel.

## Non-Goals
- Bulut/hesap/CGM, kamera-barkod, AI, tanı/tedavi/doz önerisi, reklam, satın alma.

## Open Decisions
- OD-001 OPEN: iOS yayın hedefi ve paket kimliği ne zaman kesinleştirilecek? -> iOS release.
