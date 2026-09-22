# Project Constraints

## User Requirements

### C-001: Tamamen çevrimdışı

Ağ izni, HTTP istemcisi, Firebase/analytics/reklam/telemetri/harici AI
SDK'sı YASAK. `tool/check_offline.sh` exit 0 her commit'te.

### C-002: Sağlık güvenliği dili

Teşhis/tedavi/doz önerisi yok; hastalık çağrışımı yalnız bilinçli filtre
arkasındaki kanıt bölümünde; nedensel dil yasak (lint testleri var:
causal_language_lint_test, guide_content_lint_test).

### C-003: Hesap doğruluğu

GKI formülü yalnız `lib/core/units/gki.dart` içinde (grep testi), ara
yuvarlama yok, 90 mg/dL + 2,5 mmol/L → tam 2,0. Formül değişikliği =
yeni FORMULA_VERSION + kaynak + test güncellemesi.

### C-004: Veri bütünlüğü

Migration ileri yönlü + testli; import transaction'da hatada sıfır
kısmi yazı; kullanıcı verisi sessizce silinmez; "tümünü sil" ikinci
onaylı.

## Compatibility

### C-010: Flutter stable 3.47.2

`pubspec.lock` kilitli; yeni bağımlılık yalnız gereksinim + GPL-3.0
uyum + ADR gerekçesiyle.

### C-011: GPL-3.0

Tüm bağımlılıklar MIT/BSD/Apache uyumlu; AGPL/SSPL/non-commercial
yasak; THIRD_PARTY_NOTICES.md güncel.

## Security

### C-020: Veri saklama

DB SQLCipher şifreli (ADR-0001); anahtar secure storage'da; debug
loglarında sağlık verisi yok; sır/anahtar repoya girmez (gitleaks).

### C-021: Marka

Ürün adı `N Keto Tracker` (açılım yok); repo slug `n-keto-tracker`;
ad+logo GPL kapsamı dışı markadır.

## Operations

### C-030: Release imzalama

Sırlar repoda yok; `key.properties.example` şablon; kullanıcı keystore'u
kendi yedekler.

## Development

### C-040: Test zinciri

Her commit: `flutter analyze --fatal-infos` temiz + `flutter test` yeşil
+ `bash tool/check_offline.sh` exit 0. Yeni işlev en küçük testiyle
gelir.
