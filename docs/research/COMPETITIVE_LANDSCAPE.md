# Rekabet Ortamı — N Keto Tracker

Araştırma tarihi: **2026-09-20** (tüm veriler bu tarihte resmi mağaza sayfalarından/API'lerinden çekildi; erişilen URL'ler her ürün satırında).
Yöntem: Apple iTunes lookup API (iOS puan/yorum sayısı), Google Play web sayfaları (Android puan/yorum/indirme), App Store web sayfaları (görünür yorumlar, gizlilik etiketleri), F-Droid/GitHub (açık kaynak örnekler), Reddit/agregat kaynaklar (yorum temaları). Rakip ekran görüntüleri, metinleri veya tarifleri kopyalanmadı; yalnızca genel desenlerden ilkeler çıkarıldı.
Sınır: Web vitrinleri oturum olmadan uygulama başına yalnızca birkaç yorum gösterir; nicel puanlar kesin, nitel tema örnekleri temsilidir. Gerçek kullanıcı görüşmesi yapılmadı.

## Özet tablo (2026-09-20 verileri)

| Ürün | Platform | Puan / yorum | İndirme | Son güncelleme | Model | GKI | Offline/yerel | Açık kaynak |
|---|---|---|---|---|---|---|---|---|
| Carb Manager | iOS+Android | iOS 4,82 / 735.032; Android 4,7 / 167B | 5M+ (Android) | 2026-08-28 | Freemium + Premium | Raporlarda | Hayır (hesap/bulut) | Hayır |
| Cronometer | iOS+Android | iOS 4,77 / 98.255; Android 4,2 / 58,4B | 5M+ (Android) | 2026-09-11/14 | Freemium + Gold | Hayır | Hayır | Hayır |
| Senza | iOS | 4,78 / 10.814 | — | 2025-12-17 (bayat) | Ücretsiz odaklı | Keton kaydı | Hayır (bağlı veri toplar) | Hayır |
| Keto.app (Keto Diet Tracker) | iOS+Android | iOS 4,63 / 62.018; Android 4,4 / 9,48B | 1M+ (Android) | 2026-08-28/09-14 | Freemium | Hayır | Hayır | Hayır |
| Keto Manager | iOS | 4,67 / 9.400 | — | 2026-08-18 | Freemium | Hayır | Hayır | Hayır |
| MyMojoHealth | iOS | 4,74 / 18.546 | — | 2026-08-08 | Donanım ekosistemi | **Evet** | Hayır (bağlı veri + reklam/analitik amaçlı) | Hayır |
| GKI Tracker | iOS | 3,75 / 16 | — | 2023-04-07 (terk) | Reklamlı | **Evet** | Kısmen | Hayır |
| GKI Insights | iOS | Puan yok / 0 | — | 2025-07-28 | Bilinmiyor (yeni) | **Evet** | Bilinmiyor | Hayır |
| Go-Keto | Android | Gösterilmiyor | 10K+ | 2026-06-12 | Donanım+mağaza ekosistemi | **Evet** | Hayır | Hayır |
| OpenNutriTracker | Android | Web sayfasında gösterilmiyor | 10K+ | 2026-09-10 | Ücretsiz | Hayır | **Evet** (OFF bağımlı) | **Evet** GPL-3.0 |
| Waistline | Android (F-Droid) | F-Droid sayfasında puan yok | — | v3.11.1 | Ücretsiz | Hayır | **Evet** (tamamen yerel) | **Evet** GPL-3.0 |
| Keto Diyet Planı Tarifleri (Eduven) | Android | 4,4 / 1,74B | 500K+ | 2025-12-10 | Reklamlı | Hayır | Hayır | Hayır |

**Boşluk kanıtı:** 12 üründen 5'i GKI destekliyor (MyMojoHealth, GKI Tracker, GKI Insights, Go-Keto); bunların hiçbiri açık kaynak veya tamamen offline değil. Açık kaynak + yerel veri tarafında (Waistline, OpenNutriTracker) GKI/glukoz/BHB takibi yok. "Açık kaynak + tamamen offline + glukoz/BHB/GKI + TR/EN" kombinasyonu bu taramada boş.

## Ürün matrisleri (MASTER_PROMPT §0.3 alanları)

### 1. Carb Manager — iOS · Android
- URL: https://apps.apple.com/us/app/carb-manager-keto-macro-log/id410089731 · https://play.google.com/store/apps/details?id=com.wombatapps.carbmanager
- Araştırma tarihi: 2026-09-20. iOS 4,82/735.032 (iTunes lookup); Android 4,7/167B yorum, 5M+ indirme, güncelleme 2026-08-28.
- Hedef kullanıcı/konumlandırma: "en iyi keto uygulaması" olarak konumlanan geniş tüketici kitlesi; kilo verme odaklı.
- Model: Freemium; temel net karb takibi ücretsiz, Premium (cihaz senkronu, gelişmiş takip, besin ayrıntıları) abonelik.
- Net/toplam karb: net karbonhidrat ön planda ve ücretsiz katmanda (mağaza metni: "free net carb tracking").
- Glukoz/keton/GKI: raporlarda glukoz/keton kaydı; GKI vurgusu yok.
- Tarif/plan/alışveriş: 5.000+ tarif, yemek planı; mağaza metninde 1M+ besin, barkod, fasting, aylık zorluklar.
- Grafik/ana ekran: makro halkaları + günlük toplam kartları; kapsam büyüdükçe yoğun (yorumlarda "tips page scrolls too fast").
- Arama/porsiyon/tekrar: büyük veritabanı + barkod + favoriler; porsiyon kesirleri eksik (ör. çeyrek avokado).
- Offline/mahremiyet: hesap + bulut senkronu; tamamen çevrimdışı çalışmaz.
- Erişilebilirlik: yoğun arayüz; puan/yorumlarda doğrudan erişilebilirlik bulgusu yok.
- Yorum temaları (olumlu): kolay öğün kaydı, büyük veritabanı, su takibi, restoran besinleri.
- Yorum temaları (olumsuz): karbonhidrat toplamı yanlış hesaplama, besin verisi hataları, besin ayrıntıları paralı, "lifetime" alım sonrası özellik kaldırma, barkod seyrek çalışıyor, arayüz gecikmesi (AB kullanıcısı), reklam/abonelik baskısı.
- Dersler: net karb görünürlüğü + hızlı kayıt alışkanlığı; ücretsiz çekirdeği parayla kapatmamak; veri doğruluğu şikayetlerini test kapısı yapmak.
- Kopyalanmayacak: Premium üste basma, sosyal/zorluk mekanikleri, kalabalık ana ekran.

### 2. Cronometer — iOS · Android
- URL: https://apps.apple.com/us/app/cronometer-calorie-counter/id1145935738 · https://play.google.com/store/apps/details?id=com.cronometer.android.gold
- Araştırma tarihi: 2026-09-20. iOS 4,77/98.255; Android 4,2/58,4B yorum, 5M+ indirme, güncelleme 2026-09-11.
- Hedef kullanıcı: doğruluk arayan detaylı takipçiler (sağlık profesyonelleri de kullanır).
- Model: Freemium + Gold aboneliği; Reddit fikir birliği "ücretsiz sürüm birçok ücretli sürümden daha eksiksiz".
- Besin verisi: NCCDB laboratuvar doğrulamalı kayıtlar (kullanıcı beyanlı USDA/community girdilerine karşı) — pazarın provenance altın standardı.
- Net/toplam karb: 95+ besin öğesi birlikte; keto özel görünüm değil.
- Glukoz/keton/GKI: biyobelirteç kaydı var, GKI vurgusu yok.
- Grafik: güçlü raporlar; yoğun (sıradan kullanıcı için ilk ekran yükü yüksek).
- Yorum temaları (olumlu): barkod, önceki günlerden öğün kopyalama, kilo yönetimi başarısı, veri doğruluğu.
- Yorum temaları (olumsuz): Android'de yeni reklam sistemi şikayetleri (reklamlar 15–30 sn uygulamayı kilitliyor), Gold aboneliği fiyatı.
- Dersler: veri kaynağı disiplini ve provenance bizim evidence mimarisinin modeli; ancak sıradan kullanıcıyı 95+ öğeyle boğmamak.
- Kopyalanmayacak: ilk ekranda besin öğesi yoğunluğu; abonelik gelir modeli.

### 3. Senza — iOS
- URL: https://apps.apple.com/us/app/senza-keto-fasting/id1038260828
- Araştırma tarihi: 2026-09-20. 4,78/10.814; son güncelleme 2025-12-17 (~9 ay bayat).
- Konumlandırma: "Coaches | Meal Plans | Macros" — koçluk + plan + makro.
- Model: büyük ölçüde ücretsiz; performans şikayetleri baskın.
- İçerik: 1,6M besin, 5.000 tarif; yemek+fasting+uyku+ruh hali+ağırlık+glukoz+keton birlikte kaydı.
- Dil: yalnızca İngilizce (mağaza dilleri listesi) — TR boşluğu.
- Gizlilik etiketi: "Data Linked to You" — Health & Fitness, Location, Contact Info, Identifiers, Diagnostics; sürüm geçmişinde Firebase Crashlytics. Ağ/telemetri içerir.
- Yorum temaları (olumlu): değer/ücretsiz kapsam, kullanım kolaylığı.
- Yorum temaları (olumsuz): porsiyon birimleri (oz vs cup) ve yüzde vs gram gösterimi, tarif tarayıcıda (WebView) açılıyor, koyu renkler zor görünüyor (erişilebilirlik sinyali), bi-saatlik kayıt zorluğu; Reddit: besin yüklemesi yavaş, barkod "hiç çalışmıyor".
- Dersler: öğün + biyobelirteç bağlamını aynı zaman çizgisinde birleştirme fikri doğrulanıyor; birim/esneklik ve okunabilirlik bizim doğrulanacak kabul kriterlerimiz.
- Kopyalanmayacak: WebView içerik açma, bağlı veri toplama, koçluk/topluluk bağımlılığı.

### 4. Keto.app (Keto Diet Tracker) — iOS · Android
- URL: https://apps.apple.com/us/app/keto-diet-app-low-carb-manager/id1169054597 · https://play.google.com/store/apps/details?id=keto.droid.lappir.com.ketodiettracker
- Araştırma tarihi: 2026-09-20. iOS 4,63/62.018 (alt başlık "Macros tracker & counter"); Android 4,4/9,48B, 1M+ indirme.
- Konumlandırma: basit makro + net karb takibi; barkod, plan, tarif, grafik.
- Yorum temaları (olumlu): barkod, restoran besinleri, su takibi, net karb hesabı, kullanım kolaylığı.
- Yorum temaları (olumsuz): besinler kayboluyor/çoğalıyor, etiket porsiyon dönüşüm hataları (1/4 cup vs yemek kaşığı), çökmeler, abonelik ödenmesine rağmen yanıt alınamayan destek, porsiyon kesirleri eksik.
- Dersler: porsiyon dönüşümü ve kayıt bütünlüğü bizim tablo tabanlı birim testlerimizin gerekçesi (MASTER §22.6 zaten öngörüyor); veri kaybı kabul edilemez.
- Kopyalanmayacak: abonelik duvarı, hatalı veri toleransı.

### 5. Keto Manager — iOS
- URL: https://apps.apple.com/us/app/keto-diet-app-keto-manager/id1475764462
- Araştırma tarihi: 2026-09-20. 4,67/9.400; alt başlık "Net Carb & Macro Tracker"; güncelleme 2026-08-18.
- Öne çıkan: makro takibi, sesli giriş, alışkanlık serileri, topluluk.
- Yorum temaları (olumlu): kolay, doğru takip; cömert ücretsiz kapsam; yemek planı.
- Yorum temaları (olumsuz): eğitim/öğretici yok, kafa karıştırıcı SSS, özel besin girişi hatalı, seriler/adımlar aksaklıkları.
- Dersler: ilk kullanım öğreticisi/onboarding akışımızın önemi; tekrar kayıt kolaylaştırma.
- Kopyalanmayacak: topluluk/seri/rekabet mekanikleri.

### 6. MyMojoHealth — iOS
- URL: https://apps.apple.com/us/app/mymojohealth/id1591026859
- Araştırma tarihi: 2026-09-20. 4,74/18.546; güncelleme 2026-08-08 (v1.23 senkron iyileştirmeleri).
- Konumlandırma: Keto-Mojo ölçüm cihazı ekosistemi; cihaz senkronu + manuel giriş; mg/dL veya mmol/L; **GKI**; etiket/not, filtre, grafik.
- Dil: İngilizce + 10 dil, **Türkçe dahil**.
- Gizlilik etiketi: "Data Linked to You" — Health & Fitness + Contact Info (e-posta, ad); amaçlar: Developer's Advertising/Marketing, Analytics, App Functionality.
- Yorum temaları (olumsuZ): ölçüm→uygulama senkron gecikmeleri, "Out of Ketosis" gibi yargılayıcı etiketleme kafa karıştırıyor, küçük yazı (erişilebilirlik), kurulum belgeleri zayıf, şerit israfı, 72 saate varan destek yanıtı, çoklu kullanıcı yok.
- Yorum temaları (olumlu): uzun oruç + metabolik protokol takibinde glukoz/keton/GKI kaydı işe yarar.
- Dersler: glukoz+BHB+GKI akışının pazarda işlendiğini kanıtlıyor; donanım/hesap/bulut olmadan aynı bütünlüğü cihaz üzerinde sunmak farklılaştırıcımız. Yargı dili ("ketozda değilsin") tam kaçınacağımız desen.
- Kopyalanmayacak: donanım kilidi, bağlı veri toplama, yargı etiketleri.

### 7. GKI Tracker — iOS
- URL: https://apps.apple.com/us/app/gki-tracker/id1452955250
- Araştırma tarihi: 2026-09-20. 3,75/16 yorum; son güncelleme 2023-04-07 (üç yıldan uzun süredir güncellenmiyor).
- Öne çıkan: glukoz+keton→GKI, geçmiş, notlar, tarih düzenleme, alışveriş listesi.
- Yorum temaları (olumsuz): geriye dönük tarih girişi eksikliği (2019), reklamlar (2022), grafikte ketonlar düz çizgi (birleşik eksen, 2025), haftanın belirli günlerine hatırlatıcı yok.
- Dersler: ölçüm tarih/saatini geriye dönük düzenleme birinci sınıf özellik olmalı; birleşik eksen yerine ayrı ölçekli küçük grafikler (MASTER §22.4 ile uyumlu).
- Kopyalanmayacak: terk edilmiş bakım, reklam modeli.

### 8. GKI Insights — iOS
- URL: https://apps.apple.com/us/app/gki-insights/id6748614520
- Araştırma tarihi: 2026-09-20. Değerlendirme yok (0 puan/0 yorum); güncelleme 2025-07-28.
- Öne çıkan: öğün, uyku, fasting ve not bağlamı; haftalık trend; AI yorumları.
- Dersler: bağlam etiketleri + sade trendler doğrulanıyor; harici AI yorumları bizim offline ilkesiyle çelişiyor — kullanmayacağız.
- Kopyalanmayacak: otomatik tıbbi yorum/"optimal durum" hükmü.

### 9. Go-Keto — Android
- URL: https://play.google.com/store/apps/details?id=com.goketo.goketo
- Araştırma tarihi: 2026-09-20. 10K+ indirme; güncelleme 2026-06-12; web sayfasında puan/yorum görünmüyor.
- Öne çıkan: mmol/L ve mg/dL, otomatik GKI, grafik, ağırlık; ölçüm cihazı + mağaza ekosistemi (Keto Connect B.V.).
- Dersler: birim dönüşümünün açık ve hatasız olması şart (MASTER §6.2 zaten zorunlu kılıyor).
- Kopyalanmayacak: mağaza/donanım satışının deneyime karışması.

### 10. OpenNutriTracker — Android (+iOS)
- URL: https://play.google.com/store/apps/details?id=com.opennutritracker.ont.opennutritracker · https://github.com/gadostudio/nutri-tracker
- Araştırma tarihi: 2026-09-20. Play: 10K+ indirme, güncelleme 2026-09-10, web sayfasında puan gösterilmiyor; geliştirici: Simon Oppowa; lisans GPL-3.0; Flutter.
- Öne çıkan: basitlik + mahremiyet odaklı açık kaynak kalori/nütrient takibi; Open Food Facts veritabanı; çevrimdışı çalışma iddiası.
- Sınır: OFF bağımlı ürün arama/barkod ağ ister; glukoz/BHB/GKI yok.
- Dersler: açık kaynak + Flutter + mahremiyet pazarda canlı bir niş; GPL-3.0 uyumlu bir öncül.
- Kopyalanmayacak: ağ bağımlı besin kaynağı (bizim seed veri paketli yaklaşımımızın tersi).

### 11. Waistline — Android (F-Droid)
- URL: https://f-droid.org/en/packages/com.waist.line/
- Araştırma tarihi: 2026-09-20. v3.11.1; GPL-3.0; Android 5.0+.
- Öne çıkan: tamamen yerel veri ("All data is kept on the user's device"), export/import; Open Food Facts barkod desteği; kalori + ağırlık takibi; makro özeti.
- Sınır: keto'ya özel hiçbir işlev ve GKI yok.
- Dersler: yerel-veri + export/import modelimizin doğrulanmış pazar karşılığı; mahremiyet konumlandırmasında en yakın ruh akraba.
- Kopyalanmayacak: OFF ağ bağımlılığı; masaüstü olmayan tek platform kapsamı.

### 12. Keto Diyet Planı Tarifleri (Eduven) — Android, Türkiye mağazası
- URL: https://play.google.com/store/apps/details?id=com.eduven.cc.ketogenic&hl=tr
- Araştırma tarihi: 2026-09-20. 4,4/1,74B yorum; 500K+ indirme; güncelleme 2025-12-10; geliştirici Edutainment Ventures LLC.
- Öne çıkan: Türkçe tarif + takip kombinasyonu; videolu tarifler, egzersiz videoları, BMI hesabı, kalori sayacı.
- Yorum temaları: videolu tarifler beğeniliyor; dil seçeneği olmaması eleştirisi.
- Dersler: Türkiye pazarında içeriği Türkçe ve gerçekçi olan sade bir takip uygulaması için yer var; BMI/kilo-baskısı odaklı çerçeve bizim tonumuzla çelişiyor.
- Kopyalanmayacak: tarif/video içeriğinin takip çekirdeğine gömülmesi; oyunlaştırılmış sahne yapısı.

## Kaynak URL listesi (erişim: 2026-09-20)
1. https://itunes.apple.com/lookup?id=410089731 (Carb Manager iOS)
2. https://itunes.apple.com/lookup?id=1145935738 (Cronometer iOS)
3. https://itunes.apple.com/lookup?id=1038260828 (Senza iOS)
4. https://itunes.apple.com/lookup?id=1169054597 (Keto.app iOS)
5. https://itunes.apple.com/lookup?id=1475764462 (Keto Manager iOS)
6. https://itunes.apple.com/lookup?id=1591026859 (MyMojoHealth iOS)
7. https://itunes.apple.com/lookup?id=1452955250 (GKI Tracker iOS)
8. https://itunes.apple.com/lookup?id=6748614520 (GKI Insights iOS)
9. https://play.google.com/store/apps/details?id=com.wombatapps.carbmanager
10. https://play.google.com/store/apps/details?id=keto.droid.lappir.com.ketodiettracker
11. https://play.google.com/store/apps/details?id=com.goketo.goketo
12. https://play.google.com/store/apps/details?id=com.cronometer.android.gold
13. https://play.google.com/store/apps/details?id=com.eduven.cc.ketogenic&hl=tr
14. https://play.google.com/store/apps/details?id=com.opennutritracker.ont.opennutritracker
15. https://f-droid.org/en/packages/com.waist.line/
16. https://apps.apple.com/us/app/senza-keto-fasting/id1038260828 (gizlilik etiketi ve yorumlar)
17. https://github.com/gadostudio/nutri-tracker
