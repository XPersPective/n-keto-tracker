# N Keto Tracker — Sürüm 2 kullanıcı deneyimi

Durum: uygulamaya geçiyor · İlgili: `.project-brain/tasks/PB-036.md`, `docs/PLAN_V2.md`

## 1. Ürün tanımı (tek cümle)

Keto beslenmeni, hareketini ve kan şekerini/ketonunu aynı yerden, 10 saniyede
kaydettiğin; bilimsel dayanağı açıkça görünen, sana sade bir gün özeti veren
cebindeki koç.

## 2. Kullanıcı ve ihtiyaç

- Keto'ya yeni başlayan ya da ölçüm takip eden kişi. Teknik terime yabancı.
- Telefonu tek elle, yolda ya da yemek başında kullanır: kayıt 3 dokunuşu geçmemeli.
- Hem beslenmesini hem hareketini görmek ister: "Bugün ne yaptım, ne kadar iyiyim?"
- Güven ister: "Bu sayı neye dayanıyor? Verim benim için güvenli mi?"

## 3. İlkeler

1. **Önce bugün.** Uygulama açılınca bugünün durumu ve bir sonraki adım görünür.
2. **Bilimsellik görünür, ağır değil.** Her sayının yanında tek satır açıklama
   ve kaynak simgesi (ⓘ). Hakem metin ekranı yok; ilk kullanımda kısa açıklama.
3. **Yargılamayan dil.** "Kayıt yok" yerine "Henüz kaydetmedin — ilk öğününü ekle".
   Seri (streak) kırılma cezası yok; yalnız "bu hafta 4 gün kayıt" gibi nötr özet.
4. **3 dokunuş kuralı.** Öğün, hareket ve ölçüm kaydı en fazla 3 dokunuş.
5. **Fotoğraf her yerde.** Besin, tarif ve öğün kartlarında görsel (kaynak onayı
   bekleniyor — ADR-PB-017). Görsel yoksa kategori ikonu; boş kutu yok.
6. **Güvenlik sınırı açık.** Tıbbi tavsiye değildir; belirtiler ve acil durumlar
   için yönlendirme her riskli alanda görünür.

## 4. Bilgi mimarisi (alt gezinme, 5 sekme)

| Sekme | Amaç | İçerik |
|---|---|---|
| **Bugün** | Gün özeti ve sıradaki adım | Karşılama, günün 3 adımı (öğün / hareket / ölçüm), bugünkü öğünler, hareket özeti |
| **Kayıt** | Hızlı giriş | Öğün ekle, hareket başlat, ölçüm gir, kilo/belirti |
| **Plan** | Gelecek | Haftalık öğün planı, alışveriş listesi, yürüyüş planı |
| **İlerleme** | Geçmiş ve trend | Haftalık hareket çubukları (DSÖ), glukoz/ketон/GKI grafikleri + "bu grafik ne söylüyor" |
| **Rehber** | Öğrenme | Besin rehberi (fotoğraflı), tarifler, kaynaklar |

Ayarlar: Bugün sağ üstteki dişli. Veri, gizlilik, dil, tema ve hakkında burada.

## 5. Kullanıcı yolculukları

### 5.1 İlk açılış (3 ekran, en fazla 60 saniye)

1. **Hoş geldin:** "Keto, hareket ve ölçümlerin tek yerde." Büyük "Başla".
   Dil seçimi üstte (cihaz dili ön seçili).
2. **Hedefin:** çoklu seçim — "Beslenmemi takip etmek", "Hareketimi takip etmek",
   "Kan şekerimi ve ketonumu ölçmek". Hiçbiri zorunlu değil.
3. **Güvenlik ve onam:** 7 kısa evet/hayır sorusu (ana hatlarıyla aynı); yanıtlar
   otomatik plan/hedef önerisini kapatır. Onam ve gizlilik özeti tek kutuda.
   "Hazırım" → Bugün.

Profil (boy, kilo, doğum yılı) ve enerji katsayısı ilk kullanımdan sonra
Ayarlar > Profil'de; Bugün'de "Profilini tamamla" kartı tek seferlik.

### 5.2 Günlük döngü

- Bugün açılır → "Bugünün 3 adımı" kartı: ☐ Öğün ☐ Hareket ☐ Ölçüm.
- Bir adımın "Ekle" düğmesi ilgili forma gider; dönünce kutucuk dolar.
- Hepsi tamamlanınca nötr kutlama: "Bugün 3/3. Yarın yine buradayız."

### 5.3 Hareket zamanlayıcısı (yeni)

- Kayıt sekmesinde büyük kartlar: Yürüyüş · Koşu · Kuvvet · Diğer.
- Dokununca zamanlayıcı ekranı: büyük süre, "Başlat / Duraklat / Bitir".
- Bitir → süre otomatik, isteğe bağlı mesafe ve not → Kaydet.
- Uyarı metni: "Kendini kötü hissedersen dur."

### 5.4 Öğün kaydı

- "Öğün ekle" → öğün tipi (kahvaltı, öğle, akşam, ara) + arama.
- Sonuç listesinde besin fotoğrafı, ad, 100 g başına net karbonhidrat.
- Porsiyon seç (ör. "1 yumurta"), kaydet. Son öğünler ve favoriler en üstte.

### 5.5 Ölçüm

- Glukoz (mg/dL ya da mmol/L) ve BHB; ikisi de isteğe bağlı, biri yeterli.
- Kaydet sonrası GKI ve tek cümle yorum ("Bu değer, kaydettiğin ölçüme göre …").

### 5.6 İlerleme

- Varsayılan: son 7 gün. Haftalık hareket çubuğu DSÖ 150 dk hedefine göre.
- Her grafiğin altında tek satır "Bu grafik neyi gösterir?" açıklaması.

## 6. Metin ilkeleri

- Kısa cümle, etken çatı, "sen" dili (TR: "kaydet", "ekle"; EN: "Add", "Save").
- Terim ilk görünümde açıklanır: GKI = glukoz-ketone oranı (glukoz mmol/L ÷ BHB mmol/L).
- Sayı yanında birim ve dönem: "7 gün", "dk", "g".
- Tıbbi iddia yok; "kanıtlanmış", "garanti", "tedavi" kelimeleri yasak.

## 7. Erişilebilirlik ve tasarım kuralları

- Dokunma hedefi en az 48 dp; ana düğmeler 56 dp.
- Metin büyütme (%200) ile taşma olmamalı; kart başlıkları 2 satıra kadar.
- Renk tek başına anlam taşımaz (GKI bandı metinle de yazılır).
- Koyu ve açık tema; sistem yazı boyutuna uyum.
- 360 dp genişlik referans; Birmanca, Tamilce gibi uzun yazılar için yükseklik
  esnek.

## 8. Ölçülebilir kabul kriterleri

- Yeni kullanıcı 60 saniyede Bugün'e ulaşır (3 ekran).
- Bir öğün kaydı en fazla 3 dokunuş.
- Bir hareket kaydı (zamanlayıcı ile) en fazla 4 dokunuş.
- 360 dp ve 2× yazı boyutunda Bugün, Kayıt ve İlerleme taşmaz.
- Tüm yeni metinler 68 dilde mevcut.

## 9. Kapsam dışı (bu sürüm)

- GPS / otomatik rota. Konum izni yok (C-001).
- Bildirim ve hatırlatıcılar (ayrı karar gerekir).
- Hesap, bulut, paylaşım sosyal ağları.
