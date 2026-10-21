# N Keto Tracker — Sürüm 2 plan önerisi

Tarih: 2026-10-21 · Durum: taslak + bu sürümün ilk dilimi uygulandı
Kapsam: "sadece keto değil; içinde koşu olacak; kullanıcı gözüyle sade ve
takibi kolay bir uygulama."

## 1. Kullanıcı gözünden bulunan sorunlar

Kodu ve 1.0.0+4 emülatör ekran görüntülerini kullanıcı gibi gezerek
doğruladım:

| # | Nerede | Sorun | Kullanıcının hissettiği |
|---|--------|-------|--------------------------|
| 1 | Bugün | İlk kart "GKI 1.7" gibi büyük bir sayı; GKI'nin ne olduğu açıklanmıyor | "Bu sayı ne demek?" |
| 2 | Onboarding | 8 adım (dil, amaç, profil, enerji katsayısı, 7 güvenlik sorusu, veri, onam) | Uygulamayı açmadan yorulur |
| 3 | Günlük | Grafikler önce, kayıt listesi en altta | Kaydettiğini bulamaz |
| 4 | Yemek | Yalnız kategori ikonu (PB-030); görsel yok, besin ayırt edilemiyor | "Yemekler görselli değil" |
| 5 | Hareket | Yalnız yürüyüş planı önerisi var; kayıt yok | "İçinde koşu yok" |
| 6 | Bugün | Öğün/kilo/semptom kartları çoğunlukla "henüz yok" metni | Boş ekran, ne yapacağı belirsiz |
| 7 | Trendler | Ham nokta grafikleri; okuma yardımı kısa | Grafiğin ne söylediğini çıkaramaz |

## 2. Bu sürümde yapılanlar (ilk dilim)

- **Hareket kaydı**: yürüyüş, koşu, kuvvet, diğer. Süre (dk), isteğe bağlı
  mesafe (km), not. GPS yok; her şey elle girilir (konum izni yok, C-001).
- **DSÖ 2020 haftalık hedef**: son 7 gün; koşu dakikası iki kat sayılır,
  kuvvet aerobik hedefe sayılmaz. Hedef 150 dk (rehberin alt sınırı).
- **Bugün ekranına "Hareket" kartı**: haftalık ilerleme çubuğu, bugünkü
  kayıtlar, tek dokunuşla "Hareket ekle", kayıt silme.
- **Veri güvenliği**: veritabanı şeması 1 → 2 (yalnız yeni tablo eklenir;
  1.0.0+6 kullanıcılarının verisi migration testiyle korunur). Dışa/içe
  aktarma ve "tüm verilerimi sil" hareket kayıtlarını da kapsar.
- **66 dilde çeviri** (68 uygulama dilinin tamamı): 19 yeni metin.
  Çeviriler model üretimidir; anadilli inceleme yapılmadı.

Doğrulama: `flutter analyze --fatal-infos` temiz; `flutter test` 325 test
geçti; `tool/check_offline.sh` OK.

## 3. Açık karar: yemek görselleri

Kullanıcı yemeklerin görselli olmasını istiyor. Mevcut karar (PB-030)
fotoğrafı reddetti: APK boyutu, besin başına lisans ve doğrulama, ve
"fotoğraf iddiası" yanıltıcılığı. Üç yol var:

- **A — Lisanslı fotoğraflar** (152 besin): gerçek görsel. Her fotoğrafın
  lisansı, kaynağı ve atıfı gerekir; küçük önizleme (~15 KB) ile paket
  yaklaşık 2–3 MB büyür. Kaynak bulma ve doğrulama uzun sürer.
- **B — Özgün çizim seti** (önerilen): kategori başına değil, en sık
  kullanılan ~40 besin için sade vektör çizim. Lisans sorunu yok, çevrimdışı
  kalır, ve gerçek görsel gibi okunur. Üretim süresi: birkaç gün.
- **C — Mevcut kategori ikonları + renkli kart** (şu an): en düşük maliyet,
  ama "görsel" isteğini karşılamaz.

Öneri: **B**. Onay gelirse 1 besin grubuyla başlayıp emülatörde doğrularım.

## 4. Sıradaki işler (öncelik sırasıyla)

1. **Onboarding 8 → 3 adım**: (a) dil ve amaç, (b) güvenlik soruları + onam,
   (c) "Hazırsın". Profil ve enerji katsayısı kayıt sonrası isteğe bağlı
   ayarlara taşınır. Güvenlik soruları ve onam kaldırılmaz.
2. **Terimleri ilk görünümde açıkla**: GKI, BHB, mmol/L için tek cümlelik
   açıklama + "Nedir?" dokunuşu. Bugün'deki büyük sayının yanında etiket.
3. **Bugün ekranı = bugünün listesi**: Ölçüm / Öğün / Hareket için üç
   onay kutulu satır; her biri tek dokunuşla ilgili forma gider.
4. **Günlük sayfası**: kayıt listesi üstte, grafikler altta.
5. **Trendlere hareket grafiği**: haftalık aerobik dakika çubukları.
6. **Yemek görselleri**: karar (bölüm 3) sonrası.
7. **Emülatör DoD yürüyüşü** (PB-034): `adb` artık kullanılabilir; uçak modu
   ve ağsız APK doğrulaması.

## 5. Güvenlik ve tıbbi sınırlar

- Hareket kartında ve formda "Kendini kötü hissedersen dur" uyarısı var.
- Güvenlik taramasında "yeni başlıyorum / ilaç / hamilelik" gibi yanıtlar
  varsa planlar otomatik açılmaz (mevcut kural, değişmedi).
- Koşu hedefi tıbbi hedef değildir; DSÖ eşdeğerliği yalnız bilgilendirme.
- Veri cihazda kalır; ağ izni yok; dışa aktarma kullanıcı kararıdır.

## 6. Yayın

- Bu sürüm 1.0.0+7 olarak **iç test** kanalına gider. Üretim ayrı onay ister.
- Üretimde 1.0.0+6 yayında (commit ef3c119); yeni sürüm üretime sizin
  onayınızla çıkar.
