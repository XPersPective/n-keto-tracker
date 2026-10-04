# Project Constraints

## User Requirements

### C-001: Sağlık verisi cihazdan çıkmaz (ADR-PB-012 ile revize)

Sağlık verisi hiçbir ağ çağrısına girmez. `INTERNET` yalnız reklam +
ödeme SDK'ları içindir; analytics/telemetri/Firebase/harici AI SDK'sı
YASAK. `tool/check_offline.sh` izin listesini zorlar, exit 0 her commit'te.
Sağlık ekranlarında reklam yok.

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
