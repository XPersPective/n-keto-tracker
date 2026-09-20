# Ürün Konumlandırması — N Keto Tracker

Araştırma tarihi: 2026-09-20. Kanıt: COMPETITIVE_LANDSCAPE.md, USER_REVIEW_THEMES.md, UX_BENCHMARK.md (hepsi aynı gün resmi mağaza/topluluk kaynaklarıyla).

## Hipotezin sınanması

Sahibin §22.5 önerdiği konumlandırma:

> **N Keto Tracker — private, open-source and fully offline keto, glucose, ketone and GKI tracking.**
> TR: **Tamamen offline çalışan, açık kaynaklı keto günlüğü; glukoz, keton ve GKI takibi.**

2026-09-20 taraması bu cümledeki her farklılaştırıcının pazarda boş olduğunu doğruluyor:

| İddia | Pazardaki durum | Kanıt |
|---|---|---|
| Tamamen offline | 12 üründe tam offline + hesapsız yok; iki açık kaynaklı en yakın örnekte bile barkod/ürün arama ağ istiyor (OpenNutriTracker/Open Food Facts) veya keto işlevi yok (Waistline) | CL #10, #11 |
| Açık kaynak | Yalnız 2/12 açık kaynak; hiçbiri GKI yok | CL özet tablo |
| Glukoz+BHB+GKI bütünlüğü | 4/12'de var; hiçbirinde hesap açıklaması/formül sürümü görünmüyor; üçü donanım/hesap ekosistemine bağımlı | CL #6–#9 |
| Mahremiyet | Senza ve MyMojoHealth kimlikle ilişkili veri topluyor (biri reklam/analitik amaçla); pazarın tamamı hesap/bulut/abonelik katmanlı | CL gizlilik etiketleri |
| TR/EN | Senza yalnızca EN; GKI Tracker EN/FR; MyMojoHealth TR dahil 11 dil ama bulut/hesaplı; TR mağazasında GKI destekli yerli ürün yok | CL #3, #6, #7, #12 |

**Sonuç: konumlandırma DOĞRULANDI** — 2026-09-20 örneklemINDe bu kombinasyon boş; her sütun ayrı ayrı da güçlü (GKI nişi gerçek, offline/mahremiyet şikayet temalarıyla destekli, TR yerelliği talep görüyor).

## Tek cümlelik konumlandırma (final)

- EN: **N Keto Tracker — private, open-source and fully offline keto, glucose, ketone and GKI tracking.**
- TR (yalnızca açıklayıcı mağaza metninde): **Tamamen offline çalışan, açık kaynaklı keto günlüğü; glukoz, keton ve GKI takibi.**

Marka adı her dilde `N Keto Tracker`; `N` tek başına marka harfi, açılımı yok. Önerilen alt başlıklar (≤30 karakter): TR `Keto Günlüğü ve GKI Takibi` (26), EN `Keto Journal & GKI Tracker` (26).

## Tanıtım önceliği (MASTER §0.4 sırası korunuyor)

1. Hızlı ve anlaşılır keto günlüğü — pazarın #1 sürtünmesi kayıt hızı (UT tema 1).
2. Net karb, makro, glukoz, kan ketonu ve GKI tek yerde — 4/12 ürünle niş doğrulandı; açıklanabilir hesap farklılaştırıcı.
3. Veriler cihazda; hesap, reklam, bulut yok — iki ürünün bağlı veri toplaması zıtlık kanıtı; "Data Not Collected" hedefi.
4. Açık kaynak, incelenebilir hesap mantığı — 2/12 rakip; GPL-3.0.
5. Kaynaklı ama sade bilimsel açıklamalar — pazarda karşılığı yok (GKI Insights'in AI yorumu bizim zıttımız).
6. Türkçe ve İngilizce — Senza'nın EN-only'liği ve MyMojoHealth'in TR'si talebi kanıtlıyor.

## Kanıtla desteklenen persona

Ketojenik beslenmesini takip eden, teknik olmayan sıradan kullanıcı (MASTER §0): kayıt hızı ister, porsiyon doğruluğuna güvenir, verisinin kaybolmasına dayanamaz, ekranın karmaşasına değil özetine bakar. İkincil: glukozmetre/keton ölçen ve GKI'sini anlamak isteyen kullanıcı (MyMojoHealth yorumları bu grubun gerçekliğini kanıtlıyor) — hastalık bağlamı YOK, yalnızca genel takip.

## Yasak ve dikkat listesi (tanıtım)

- Hastalık/kanser/tümör/glioblastoma/tedavi çağrışımı yok (AC4).
- "Mucize", "garantili ketozis", "kanıtlanmış kilo verme", "yağ yak", öncesi/sonrası beden çekimleri yok — pazarın baskın kilo dili bilinçli reddediliyor (MASTER §22.3-9).
- Rakip markaları anahtar kelime olarak kullanma; rakip ekran görüntüsü/metin/ikon kopyalama.
- Gerçek olmayan basın alıntısı/kullanıcı yorumu ekleme.
- Seyfried ismi yalnızca kaynak künyelerinde; tanıtım yüzü değil (MASTER §2.4).

## Boyut/kapsam kararları

- Mağaza adı TR/EN: `N Keto Tracker` (14 karakter; 30 sınırı içinde).
- Repo slug: `n-keto-tracker` (GitHub'da boş olduğu 2026-09-20'de sahibi tarafından doğrulandı — §22.1).
- Hedef: Android + iOS, TR/EN. 71 dil hedefi yok (beyin §1 Out of scope).

## Açık riskler

- Ad/marka rezervasyonu henüz yapılmadı (App Store Connect + Google Play + TÜRKPATENT) — sahibin yayın öncesi adımı; uygulama tarafında isim tek yapılandırma noktasından yönetilecek.
- "Offline" iddiasının sürekli kanıtı gerekir: her sürümde check_offline + uçak modu smoke testi (AC3, T30).
