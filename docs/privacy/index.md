# Gizlilik Politikası — N Keto Tracker

Son güncelleme: 2026-09-20

## Özet

N Keto Tracker **tamamen çevrimdışı** çalışır. Verileriniz — ölçümler,
öğünler, notlar, profil — **yalnızca cihazınızda**, uygulamanın
sandbox'ındaki şifreli SQLite veritabanında saklanır.

- **Hesap yok.** Kayıt olmazsınız, kimlik verisi istenmez.
- **Reklam yok, analitik yok, telemetri yok.** Uygulama hiçbir ağ
  bağlantısı kuramaz: Android paketinde `INTERNET` izni bile yoktur.
- **Bulut yedeği yok.** Sağlık veritabanı Android otomatik yedeği ve
  cihaz taşıma kapsamı dışındadır.

## Topladığımız veri

Hiçbirini toplamıyoruz. Uygulama internete bağlanamaz; veri
gönderemez.

## Verilerinizin saklanması

- Tüm kayıtlar cihaz içindeki uygulama sandbox'ında tutulur.
- Veritabanı SQLCipher ile şifrelenir; anahtar cihazın güvenli
  deposunda (Android Keystore / iOS Keychain) durur.
- **Uygulamayı silerseniz verileriniz silinir.** Düzenli olarak
  *Ayarlar → Veri yönetimi → Dışa aktar* ile yedek almanız önerilir.

## Dışa aktarma ve paylaşım

Dışa aktarma yalnızca sizin açık eyleminizle olur (CSV veya JSON).
Dosya, sizin seçtiğiniz konuma yazılır; bundan sonraki paylaşımı
sizin sorumluluğunuzdadır. Uygulama hiçbir dosyayı otomatik
göndermez.

## Üçüncü taraflar

Uygulama içinde hiçbir üçüncü taraf analitik/reklam/hizmet yoktur.
Uygulamanın kullandığı açık kaynak paketlerin listesi GitHub deposundaki
`THIRD_PARTY_NOTICES.md` dosyasındadır.

## Çocuklar ve özel durumlar

Uygulama 18 yaş altı kullanıcılar için tasarlanmamıştır; onboarding'de
bu soru sorulur ve kişiselleştirilmiş plan üretimi kilitlenir.

## İletişim

Sorularınız için GitHub deposundaki issue izleyicisini kullanın:
https://github.com/XPersPective/n-keto-tracker

---

## Privacy Policy — N Keto Tracker (English)

Last updated: 2026-09-20

## Summary

N Keto Tracker works **fully offline**. Your data — measurements, meals,
notes, profile — is stored **only on your device**, in an encrypted
SQLite database inside the app sandbox.

- **No account.** No sign-up, no identity data collected.
- **No ads, no analytics, no telemetry.** The app cannot connect to the
  internet: the Android package has no `INTERNET` permission at all.
- **No cloud backup.** The health database is excluded from Android
  auto-backup and device transfer.

## Data we collect

None. The app has no network access and cannot send data anywhere.

## Data storage

- All records stay in the app sandbox on your device.
- The database is encrypted with SQLCipher; the key lives in the
  device secure storage (Android Keystore / iOS Keychain).
- **Uninstalling deletes your data.** Regularly export a backup via
  *Settings → Data management → Export*.

## Export and sharing

Export happens only by your explicit action (CSV or JSON). The file is
written to a location you choose; sharing it afterwards is your
responsibility. The app never sends files automatically.

## Third parties

No third-party analytics/advertising services are embedded. The open
source packages used are listed in `THIRD_PARTY_NOTICES.md` in the
GitHub repository.

## Children and special situations

The app is not designed for users under 18; onboarding asks this and
locks personalized plan generation.

## Contact

Use the issue tracker on the GitHub repository:
https://github.com/XPersPective/n-keto-tracker
