# Güvenlik — N Keto Tracker

## Sağlık verisi mahremiyeti

N Keto Tracker **tamamen çevrimdışıdır**: hesap yok, bulut senkronizasyonu
yok, telemetri/analitik/reklam SDK'sı yok, ağ izni yok. Tüm veriler
(glukoz/BHB/GKI ölçümleri, öğünler, ağırlık, semptomlar, profil, onam
kayıtları) yalnızca cihazdaki uygulama sandbox'ında saklanır.

- Hassas veritabanı ve paylaşılan tercihler Android otomatik bulut yedeği ve
  cihaz taşıma kapsamına alınmamıştır (`data_extraction_rules.xml`,
  `backup_rules.xml`).
- Dışa aktarma yalnızca kullanıcının açık eylemiyle olur; dosya kullanıcının
  seçtiği konuma yazılır ve bundan sonra uygulamanın kontrolü dışındadır.
- Uygulama silinirse yerel yedek alınmamış veriler **kaybolur**; düzenli
  dışa aktarma önerilir (uygulama içi uyarı metni de bunu söyler).

## Desteklenen sürümler

Yalnızca en son yayınlanan sürüm güvenlik güncellemesi alır.

## Güvenlik açığı bildirimi

> **İletişim adresi:** proje sahibi tarafından eklenecektir (e-posta adresi,
> sahibi onaylamadan yazılmaz). Ekleninceye kadar:
> lütfen açığı **özel** olarak GitHub üzerinden depo sahibine
> ("Security" sekmesi → "Report a vulnerability") iletin; açık bulgusunu
> herkese açık issue olarak açmayın.

Bildirimde neler yararlı: etkilenen sürüm, yeniden üretim adımları, etki
değerlendirmesi. Bildirimden sonra herkese açık açıklamaya kadar makul bir
süre tanıyın (90 gün önerilir).

## Kapsam dışı

- Cihaz kullanıcı kilidi biyometrik doğrulamayı aşan fiziksel saldırılar
  (bkz. `THREAT_MODEL.md` kalan riskler).
- Kullanıcının kendi paylaştığı dışa aktarma dosyalarının sonrası.
- Flutter/Android/iOS platform zafiyetleri — ilgili upstream'a bildirin.
