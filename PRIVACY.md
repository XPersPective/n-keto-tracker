# Gizlilik — N Keto Tracker (uygulama içi belge dokümanı)

Son güncelleme: 2026-10-04 (ADR-PB-012).

## Sağlık verisi cihazdan çıkmaz

- Tüm kayıtlar (öğün, ölçüm, GKI, semptom, kilo, notlar): **uygulama
  sandbox'ındaki şifreli SQLite veritabanı** (SQLCipher; anahtar OS güvenli
  deposunda — `ADR-0001`).
- **Hesap yok, bulut yok, telemetri yok, analytics yok.** Sağlık verisi hiçbir
  ağ isteğine girmez; ağ kodu yalnızca `lib/core/monetization/` içindedir ve
  `tool/check_offline.sh` her derlemede bunu doğrular.

## Ağ erişimi: yalnızca reklam ve ödeme

Uygulama `INTERNET` iznini yalnızca şunlar için kullanır:

1. **Reklam (Google AdMob)** — ücretsiz sürümde klinik olmayan birkaç
   ekranda (Plan sekmesi, Ayarlar) kişiselleştirilmemiş banner. Reklam
   gösterilmeden önce Google UMP onay formu çıkar; seçiminizi Ayarlar >
   "Reklam gizlilik seçenekleri"nden değiştirebilirsiniz. Reklamlar
   kişiselleştirilmemiş ve genel (G) içerik sınıfındadır. Kayıt formlarında,
   GKI sonucunda, rehber ve bilimsel kaynaklarda reklam yoktur. Google, reklam
   isteği sırasında cihaz/reklam kimliği gibi bilgileri kendi
   politikasına göre işleyebilir; sağlık verisi bu isteğe **hiç** girmez.
2. **Premium (Google Play Faturalandırma)** — tek seferlik satın alma
   reklamları kaldırır. Ödeme Google Play üzerinden yapılır; uygulama kart
   bilgisi görmez. İsteğe bağlı doğrulama sunucusu yalnızca
   `{paket adı, ürün kimliği, satın alma jetonu}` alır.

Premium kullanıcıda reklam SDK'sı hiç başlatılmaz.

## Yedekleme

Çıkış/çıkartma kuralları veritabanını ve paylaşılanları kapsamaz
(`data_extraction_rules.xml`, `backup_rules.xml`).

## Dışa/içe aktarım

- Export **yalnız kullanıcı eylemiyle**: JSON veya CSV; seçtiğiniz yerde
  kaydedilir.
- Import: şema doğrulaması + boyut limiti + tek transaction.
- Tüm verilerimi sil: ikinci onay gerektirir; geçici dosyalar da temizlenir.

## Panoya kopyalama

Hiçbir sağlık verisi otomatik panoya taşınmaz; URL kopyalama yalnızca açık
link eylemiyle ve yalnızca metni kopyalar.

## Üçüncü taraflar

`google_mobile_ads` (reklam + UMP onayı) ve `in_app_purchase` (Play
Faturalandırma) dışında ağ SDK'sı yoktur; bağımlılıklar
`THIRD_PARTY_NOTICES.md`'dedir.
