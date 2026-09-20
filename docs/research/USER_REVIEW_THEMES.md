# Kullanıcı Yorumu Temaları — N Keto Tracker

Araştırma tarihi: 2026-09-20.

## Yöntem ve dürüstlük beyanı

- **Gerçek kullanıcı görüşmesi/anket yapılmadı.** Bu belge yalnızca herkese açık mağaza yorumları ve topluluk kaynaklarının sınıflandırmasıdır.
- Doğrudan okunan görünür mağaza yorumu: **35** (Carb Manager Play 3; Keto.app Play 3 + iOS 4; Cronometer Play 3; Eduven TR Play 2; Senza iOS 4; MyMojoHealth iOS 4; GKI Tracker iOS 5; Keto Manager iOS 4; toplam platform kısıtı nedeniyle Go-Keto/GKI Insights/OpenNutriTracker/Waistline'da görünür yorum yoktu). Web vitrinleri oturum/JS olmadan uygulama başına yalnızca birkaç yorum gösterir; bu yüzden 35 doğrudan örnek, ~800 binden fazla toplam yorum havuzunu temsil eden **agregat kaynaklarla** desteklendi:
  - r/keto "Senza app crashed" başlığı (https://www.reddit.com/r/keto/comments/bye4xs/senza_app_crashed) — birden çok kullanıcı.
  - r/1200isplentyketo "Favourite calorie/carb counting apps?" (2019) — Carb Manager premium bırakma örneği.
  - r/ketobeginners AB kullanıcısı arayüz gecikmesi şikayeti (2022).
  - carbmenot.com "Best Keto App Reddit (2026)" (2026-08-11; **rakip uygulama blogu, çıkar çatışması açık** — yalnızca tema doğrulaması için kullanıldı): r/keto fikir birliği Cronometer veri kalitesi, Carb Manager premium kamplaşması, MyFitnessPal veritabanı güvenilmezliği, "arama-öncelikli kayıt akışının sürtünme yarattığı" gözlemi.
  - Sahibin 2026-09-20 tarihli §22.3 ön taraması (aynı gün; bağımsız çapraz doğrulama olarak kullanıldı).
- Puanlar ve yorum sayıları COMPETITIVE_LANDSCAPE.md'de; burada yalnızca temalar.

## Sınıflandırılmış temalar (MASTER_PROMPT §0.3 sürtünme sınıfları)

### 1. Yavaş/güçlü öğün kaydı (en sık)
- "Arama-öncelikli" akış (besin ara → kayıt seç → porsiyon boyutlandır → tekrar tekrar) topluluk gözleminde ana sürtünme (carbmenot derlemesi, 2026-08-11).
- Senza'da bi-saatlik kayıt isteyen kullanıcı akışın ağırlığından yakınıyor (App Store yorumu, 2026-09-20 okundu).
- Keto Manager'da öğretici olmaması ilk kaydı yavaşlatıyor (iOS yorumu, 07/2024).
- **Karar:** hızlı tekrar, favori, son kullanılan; ≤3 dokunuşta kayıt başlatma (MASTER §0.1, §22.6).

### 2. Veri doğruluğu ve porsiyon dönüşümü
- Carb Manager: "karbonhidratları doğru toplamıyor", veritabanı hataları (Play yorumu).
- Keto.app: etiket porsiyon dönüşüm hataları (1/4 cup vs yemek kaşığı), besinler kayboluyor/çoğalıyor (iOS yorumları 09/2022, 11/2022).
- Senza: oz/cup birim karışıklığı; yüzde vs gram gösterimi (iOS yorumları).
- Carb Manager: çeyrek avokado gibi kesirler eksik (Play yorumu).
- **Karar:** porsiyon/birim dönüşümleri tablo tabanlı birim testleriyle; veri kaybına karşı DB bütünlük testleri (MASTER §22.6).

### 3. Veri kaybı ve senkronizasyon
- Keto.app: tarifler/öğünler kaybolma, çökmeler (iOS).
- MyMojoHealth: cihaz→uygulama senkron gecikmeleri (iOS).
- Carb Manager: "lifetime" alım sonrası özellik kaldırma şikayeti (Play).
- **Karar:** tamamen yerel tek gerçek kaynak + export/import; senkron hiç olmayacak (kaybın ana kaynağı bulut/hesap katmanı).

### 4. Grafik ölçeği ve okunabilirlik
- GKI Tracker: birleşik eksende ketonlar düz çizgi gibi görünüyor (iOS, 05/2025).
- Carb Manager: eksik ağırlık grafiği şikayeti (Play).
- Senza: koyu renkler zor görünüyor (erişilebilirlik sinyali).
- MyMojoHealth: küçük yazı (erişilebilirlik).
- **Karar:** ayrı küçük grafikler, bağımsız eksenler, metinsel grafik özetleri, kontrast ve büyük yazı testleri.

### 5. Ölçüm bağlamı ve geriye dönük düzenleme
- GKI Tracker: geriye dönük tarih girişi yoktu (2019 yorumu; sonraki sürümlerde kısmen gelmiş görünüyor).
- MyMojoHealth: "Out of Ketosis" yargı etiketi kafa karıştırıyor; not/etiket/filtre beğeniliyor.
- GKI Insights: öğün/uyku/fasting bağlamı öne çıkıyor.
- **Karar:** bağlam etiketleri + tarih/saat düzenleme birinci sınıf; yargı dili yok.

### 6. Paywall, abonelik, reklam
- Carb Manager: besin ayrıntıları paralı; premium üste basma; Reddit'te ikiye bölünmüş kamplar.
- Cronometer Android: "reklamlar 15–30 sn uygulamayı kullanılamaz yapıyor" (2026 yorumları); Gold aboneliği şikayeti.
- GKI Tracker: reklam şikayeti, reklamsız ücretli sürüm isteği.
- Keto.app: abonelik ödenmesine rağmen destek alınamıyor.
- **Karar:** hiçbir çekirdek işlev paralı değil; reklam yok; hesap yok (MASTER §1.2).

### 7. Gizlilik
- Senza: kimlikle ilişkili veri toplama (Health & Fitness, Location, Contact Info, Identifiers, Diagnostics) — App Store gizlilik etiketi (2026-09-20 görüntülendi).
- MyMojoHealth: kimlikle ilişkili sağlık verisi + reklam/analitik amaçlı toplama — gizlilik etiketi.
- **Karar:** "Data Not Collected" hedefi; Android INTERNET izni yok; bu belgelenmiş farklılaştırıcı.

### 8. Ana ekran karmaşası
- Carb Manager: kapsam büyüdükçe yoğun ekran; hızlı kaydı boğan premium pencereleri (yorumlar + sahibin §22.3 taraması).
- Senza: ders kitabı kapsamı geniş, "detaylı kullanıcı öğeleri"nden düşüyor (App Store yorumu).
- **Karar:** Bugün ekranı = bugünün özeti + 4 hızlı eylem; akademik ayrıntı ikinci katmanda (MASTER §0.1).

### 9. Erişilebilirlik
- MyMojoHealth: küçük yazı; zayıf kurulum belgeleri.
- Senza: koyu renkler zor görünüyor.
- Keto Manager: öğretici/SSS kafa karıştırıcı.
- **Karar:** ≥48dp dokunma hedefleri, kontrast, renk dışı durum anlatımı, ekran okuyucu özetleri.

### 10. AI/otomatik yorum
- GKI Insights: AI yorumları pazarda görünür; bağımsız doğrulama yok.
- **Karar:** harici AI yok; belirsizliği dürüstçe anlat (MASTER §1.2, §22.3-8).

### 11. Dil ve yerellik
- Senza: yalnızca İngilizce.
- GKI Tracker: İngilizce/Fransızca.
- MyMojoHealth: Türkçe dahil 11 dil (pozitif örnek).
- Eduven TR: Türkçe içerik beğeniliyor; dil seçeneği eksikliği eleştiriliyor.
- **Karar:** TR/EN birinci sınıf; Türkçe kullanıcı için birincil dil, İngilizce tam eşdeğer.

## Tekrar eden olumlu temalar (korunacak beklentiler)
- Büyük, doğru besin veritabanı ve barkod (bizde: paketli seed veri + kullanıcı besini; barkod MVP dışı).
- Önceki günlerden öğün kopyalama (Cronometer) — hızlı tekrar tasarımımızın doğrudan karşılığı.
- Glukoz+keton+GKI'yi tek yerde görmek (MyMojoHealth kullanıcıları).
- Ücretsiz kapsamın cömertliği (Cronometer Reddit fikir birliği).
- Tamamen yerel veri ve export/import (Waistline felsefesi).
