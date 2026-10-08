# Gizlilik — N Keto Tracker (uygulama içi belge dokümanı)

Son güncelleme: 2026-10-08 (ADR-PB-016).

## Sağlık verisi cihazdan çıkmaz

- Tüm kayıtlar (öğün, ölçüm, GKI, semptom, kilo, notlar): **uygulama
  sandbox'ındaki şifreli SQLite veritabanı** (SQLCipher; anahtar OS güvenli
  deposunda — `ADR-0001`).
- **Hesap yok, bulut yok, telemetri yok, analytics yok.** Uygulamada
  ağ izni yoktur; `tool/check_offline.sh` her derlemede bunu doğrular.

## Ağ erişimi yok

Uygulama `INTERNET` iznini **istemez**; çevrimdışı çalışır. Reklam, satın alma,
analitik veya telemetri yoktur (ADR-PB-016).

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

Ağ SDK'sı yoktur; bağımlılıklar `THIRD_PARTY_NOTICES.md`'dedir.
