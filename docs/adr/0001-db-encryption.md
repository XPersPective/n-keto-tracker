# ADR-0001 — Veritabanı şifrelemesi: SQLCipher + flutter_secure_storage

- Durum: Kabul edildi · Tarih: 2026-09-20 · Görev: T8
- Dayanak: ORTAK_UYGULAMA_STANDARDI.md §6.1 (yerel veri: cihaz içi şifreli
  veritabanı); MASTER_PROMPT §14.2 (şifreleme GERÇEKTEN varsa söylenür).

## Bağlam

Sağlık verisi (glukoz/BHB/GKI, öğün, semptom, profil) cihazda SQLite
dosyasında duracaktır. Cihaz kaybı/root tehdidi THREAT_MODEL T1/T10'da
ele alınmıştır: uygulama katmanında at-rest şifreleme bu riskleri küçültür.
MASTER §14.2 gereği şifreleme ancak gerçekten uygulanırsa metinlerde
belirtilebilir.

## Araştırma (2026-09-20)

1. `sqlcipher_flutter_libs` **kullanılamaz**: sqlite3 2.x dönemine aittir;
   0.7.0'dan itibaren no-op (pub.dev sayfası).
2. sqlite3.dart 3.x döneminde şifreli SQLite derlemesi **build hook** ile
   seçiliyor: `pubspec.yaml` → `hooks.user_defines.sqlite3.source` =
   `sqlite3mc` (SQLite3MultipleCiphers) veya `sqlcipher`
   (sqlite3.dart `sqlite3/doc/hook.md`).
3. SQLCipher: BSD-3-Clause (Zetetic Community Edition, GitHub reposu) —
   GPL-3.0 uyumlu, ORTAK §2 izinli liste tipi. SQLCipher derlemesi
   Windows/Linux/Android'de OpenSSL bağlar (çalışma zamanı bağımlılığı;
   APK'ya dahil, ağ işlemi yapmaz).
4. flutter_secure_storage: BSD-3-Clause; anahtar platform güvenli
   deposunda (Android Keystore / iOS Keychain).
5. drift, `NativeDatabase.setup` ile açılış öncesi `PRAGMA key` verimeye
   izin veriyor (drift dokümanı Encryption).

## Karar

- `pubspec.yaml`'a build hook eklendi: `sqlite3` derlemesi `sqlcipher`
  kaynağıyla paketlenir.
- Anahtar: ilk açılışta 32 byte CSPRNG → hex; flutter_secure_storage'da
  saklanır; `PRAGMA key` ile NativeDatabase.setup'ta verilir.
- `sqlcipher_flutter_libs` eklenmedi (no-op; gereksiz bağımlılık).

## Alternatifler

- SQLite3MultipleCiphers (`source: sqlite3mc`): MIT; daha geniş şifre
  seçkisi; ancak SQLCipher ile dosya biçimi uyumu "compatibility mode"
  ayarı gerektirir. Standart §6.1'in "şifreli veritabanı" şartını ikisi de
  karşılar; SQLCipher daha yaygın denetlenmiş bir seçim olduğu için
  tercih edildi.
- Şifreleme yok: ORTAK §6.1'i ihlal eder — reddedildi.

## Sonuç / etkiler

- DB dosyası düz `sqlite3` ile açılamaz (T8 testi kanıtlar).
- PRIVACY.md ve kullanıcı metinleri şifrelemeyi ancak bu kurulumla birlikte
  anacaktır; şifreli DB yedeklemeye girmemesi yine manifest kurallarıyla
  sağlanır (T4'te yapıldı).
- Ayrı onay bekleyen not: RSA/in_app_review gibi T28 paketleri bu ADR'nin
  kapsamı dışındadır.

## Doğrulama planı

- Android debug APK derlemesi hook ile başarılı (2026-09-20, 494,9s).
- DB dosyasının düz sqlite3 ile açılamaması testi: `test/core/database/`
  (encrypted_open_test) ve T31'de cihaz üstü `aapt2`/dosya kanıtı.
