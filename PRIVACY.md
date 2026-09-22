# Gizlilik — N Keto Tracker (uygulama içi belge dokümanı)

## Cihazda kalmaya zorlanan veri akışı

- Tüm kayıtlar: **uygulama sandbox'ındaki şifreli SQLite veritabanı**
  (SQLCipher; anahtar OS güvenli deposunda — `ADR-0001`).
- **Hesap yok, bulut yok, telemetri yok, reklam yok, analytics yok**:
  Android manifest'inde `INTERNET` izni yok (`tool/check_offline.sh`
  ile derlemesinde kanıtlı).
- Yedekleme: çıkış/çıkartma kuralları DB ve paylaşılanları kapsamaz
  (`data_extraction_rules.xml`, `backup_rules.xml`).

## Dışa/ içe aktarım

- Export **yalnız kullanıcı eylemiyle**: JSON veya CSV; dosya varsa
  seçtiğiniz yerde kaydedilir.
- Import: şema doğrulaması + boyut limiti + tıpkı tek transaction.
- Tüm verilerimi sil: ikinci onay gerektirir; işlem sonrası geçici
  dosyalar da temizlenir.

## Panoya kopyalama

Hiçbir sağlık verisi otomatik panoya taşınmaz; URL kopyalama yalnızca
açık link eylemiyle ve yalnızca metni kopyalar.

## Üçüncü taraflar

Bağımlılıklar `THIRD_PARTY_NOTICES.md`'de; hiçbirinde ağ SDK'sı yok.
