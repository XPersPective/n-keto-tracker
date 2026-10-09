# Project Constraints

## User Requirements

### C-001: Çevrimdışı, reklamsız, satın almasız (ADR-PB-016)

Uygulamada reklam, satın alma, ağ, analytics/telemetri/Firebase/harici AI
YOK (kullanıcı talimatı 2026-10-08: "bu uygulamada reklam ve satın alma
olmayacak"). `INTERNET` izni istenmez; `tool/check_offline.sh` her commit'te
exit 0. ORTAK_UYGULAMA_STANDARDI §0: REKLAM=HAYIR, PRO=HAYIR.

### C-050: Atıf

Commit mesajları, PR açıklamaları ve dosyalar hiçbir yapay zeka adı/ortak yazar
satırı içermez; katkıcı listesinde yalnız proje sahibi görünür.

Bu kural `project-brain` skill'inin `PB-Agent:` trailer şablonunu geçersiz
kılar: protocol commit'lerinde **o trailer yazılmaz**. (2026-10-09 notu: PB-018
ve öncesi commit'lerde `PB-Agent: claude-sonnet-5-5` satırı var; geçmiş
`preserve` modunda yeniden yazılmaz, ileriye dönük uygulanır.)

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
