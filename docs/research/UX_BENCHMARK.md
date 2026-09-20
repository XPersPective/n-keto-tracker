# UX Benchmark — N Keto Tracker

Araştırma tarihi: 2026-09-20.
Kanıt tabanı: COMPETITIVE_LANDSCAPE.md (resmi mağaza sayfaları/metinleri), USER_REVIEW_THEMES.md (35 doğrudan yorum + agregat kaynaklar), sahibin §22 ön taraması. **Akış adım sayıları mağaza metinlerinden ve yorumlardan çıkarımdır; uygulamalar bu taramada adım adım elle koşturulmadı.** Çıkarım olan her satır (çıkarım) etiketlidir. Rakip ekran düzenleri/metinleri kopyalanmadı.

## 1. Onboarding uzunluğu

| Ürün | Gözlem | Kanıt türü |
|---|---|---|
| Carb Manager | Hesap/profil kurulumu + premium tanıtım katmanı; "1 dakikada başla" iddiası mağaza metninde | mağaza metni (çıkarım) |
| Cronometer | Aktivite/hedef profili; cömert ücretsiz katman | mağaza metni (çıkarım) |
| Senza | Hızlı başlangıç iddiası; koçluk/plan upsell'leri | mağaza metni (çıkarım) |
| Keto Manager | Öğretici yokluğu ilk kullanımda kaybolma hissi | iOS yorumu 07/2024 (doğrudan) |
| MyMojoHealth | Cihaz eşleştirme + kurulum belgeleri zayıf şikayeti | iOS yorumu (doğrudan) |
| Waistline | Hesap yok, anında kullanım | F-Droid tanımı (doğrudan) |

**N Keto Tracker hedefi (MASTER §4):** 8 adımlı ama hafif onboarding; hesap yok, ödeme duvarı yok, profil sonra tamamlanabilir; ölçülebilir kabul: sıradan kullanıcı sağlık eğitimi olmadan ana görevleri tamamlayabilmeli (MASTER §16.3).

## 2. Bir öğün kaydına başlama ve tamamlama adım sayısı

- Pazar gözlemi (carbmenot derlemesi, 2026-08-11, çıkar çatışması notuyla): Reddit'te önerilen tüm uygulamalar "arama-öncelikli" — besin ara → kayıt seç → porsiyon boyutlandır → malzeme başına tekrarla. Bu akış, kullanıcıların kaydı bırakmasının ana sürtünmesi olarak işaretleniyor.
- Cronometer'da övülen "önceki günlerden öğün kopyalama" pazardaki en kısa tekrar kaydı yolu (yorum, doğrudan).
- **N Keto Tracker hedefi (MASTER §0.1):** en sık eylemler (öğün, glukoz, keton, ağırlık, semptom) ana ekrandan **en fazla 3 dokunuşta** başlar; hızlı tekrar/favori/son kullanılan ile tamamlama. Kabul testi T14'te widget testiyle ölçülür.

## 3. Net/toplam karbonhidrat sunumu

- Carb Manager: net karb ücretsiz katmanın yüzü ("free net carb tracking" — mağaza metni).
- Keto.app / Keto Manager: alt başlıklarında net karb taşıyor ("Net Carb & Macro Tracker").
- Cronometer: toplam + net birlikte, 95+ öğe yanında keto özel vurgusu yok.
- **N Keto Tracker kararı:** günlük toplamlarda toplam karb, lif ve net karb birlikte; hangisinin hedefte kullanıldığı ayarlarda görünür (MASTER §8.2).

## 4. Glukoz, keton ve GKI desteği

| Ürün | Glukoz | BHB | GKI | Kanıt |
|---|---|---|---|---|
| MyMojoHealth | mg/dL veya mmol/L | Evet | Evet | mağaza metni (doğrudan) |
| GKI Tracker | Evet | Evet | Evet | mağaza metni (doğrudan) |
| GKI Insights | Evet | Evet | Evet | mağaza metni (doğrudan) |
| Go-Keto | mg/dL + mmol/L | Evet | Otomatik | mağaza metni (doğrudan) |
| Senza | Kayıt var | Kayıt var | — | mağaza metni (doğrudan) |
| Diğer 7 | — | — | — | — |

**Ders:** GKI pazarda niş ama gerçek; dört örnekten hiçbiri hesabı açıkça göstermiyor/formülünü sürümlemiyor (metinlerde görünmüyor). Bizim farklılaştırıcı: açıklanabilir hesap kartı + FORMULA_VERSION + kaynak provenance.

## 5. Grafik ve ana ekran bilgi hiyerarşisi

- GKI Tracker'da birleşik eksen ketonları görünmez kılmış (yorum, 05/2025, doğrudan) → ayrı küçük grafikler/etiketli bağımsız eksenler.
- MyMojoHealth: filtre + grafik + etiket hiyerarşisi güçlü; ama cihaz ekosistemine bağımlı.
- Carb Manager: makro halkaları + çok kart; kapsam/karmaşık dengesi yorumlarda eleştiri konusu.
- **N Keto Tracker kararı (MASTER §5.1, §5.4, §12):** Bugün = son ölçümler + günlük toplamlar + hızlı eylemler; Trendler = ayrı küçük grafikler, 7/30/90 + özel; bantlar varsayılan kapalı; her grafik metinsel özet.

## 6. Arama, porsiyon ve tekrar kayıt kolaylığı

- Porsiyon dönüşüm hataları iki üründe belgelenmiş şikayet (Keto.app 1/4 cup; Senza oz/cup) → tablo tabanlı birim testleri.
- Kesir desteği eksikliği (çeyrek avokado) → esnek porsiyon ifadeleri.
- Öğün kopyalama (Cronometer) → hızlı tekrar çekirdeğimiz.

## 7. Offline çalışma ve mahremiyet beyanı

| Ürün | Beyan/durum |
|---|---|
| Waistline | Tamamen yerel, export/import (doğrudan) |
| OpenNutriTracker | Offline iddiası + OFF bağımlılığı (barkod/arama ağ ister) (doğrudan) |
| Senza | Kimlikle ilişkili veri toplama etiketi; Crashlytics |
| MyMojoHealth | Kimlikle ilişkili sağlık verisi; reklam/analitik amaçlı |
| Carb Manager, Cronometer, Keto.app, Keto Manager, Go-Keto, Eduven | Hesap/bulut/abonelik katmanı; tam offline iddiası yok |

**Sonuç:** "Tamamen offline + hesapsız + GKI" kombinasyonu bu örneklemde yalnızca N Keto Tracker hedefi olarak var; mahremiyet beyanımız mağaza gizlilik etiketiyle ("Data Not Collected" hedefi) ve Android INTERNET izninin yokluğuyla kanıtlanabilir olacak.

## 8. Erişilebilirlik gözlemleri

- Küçük yazı (MyMojoHealth), koyu renk zorluğu (Senza), öğretici eksikliği (Keto Manager), hızlı kayan ipuçları sayfası (Carb Manager).
- **Karar:** 44–48dp hedefler, kontrast, renk dışı anlatım, ekran okuyucu grafik özetleri, büyük yazı taşma testleri (MASTER §12, §16.3).

## 9. Mağaza görsel dili

- Yaygın desen: kalabalık çok-özellik ekran görüntüleri, makro halkası motifi, "en iyi keto uygulaması" iddiası, kilo verme öncesi/sonrası çekimleri.
- N Keto Tracker yaklaşımı (MASTER §22.4): tek büyük mesaj + gerçek ekran + kısa yerelleştirilmiş başlık; sakin tek vurgu rengi; neon/alev/şimşek/beyin/hastane imgesi yok; önerilen sıra: günün özeti → hızlı kayıt → glukoz/keton/GKI → bağlamlı trendler → plan/tarif/alışveriş → kaynaklı rehber → veriler cihazında.

## 10. Önceliklendirilmiş "kopyalama değil öğrenme" listesi

1. Net karbın ücretsiz çekirdekte görünür olması (Carb Manager'dan ilke; uygulayış değil).
2. Önceki günden öğün kopyalama hızının tekrar kayıt standardı olması (Cronometer'dan ilke).
3. NCCDB tarzı provenance disiplininin besin verimizde karşılığı: kaynak, sürüm, lisans, inceleme tarihi alanları.
4. Ayrı ölçekli küçük grafikler (GKI Tracker'ın başarısızlığından ters ders).
5. Bağlam etiketleri + geriye dönük tarih düzenleme (GKI Tracker/MyMojoHealth/GKI Insights ortak ihtiyacı).
6. Cömert ücretsiz kapsam (Cronometer Reddit fikir birliği).
7. Tamamen yerel veri + export/import (Waistline'dan ilke).
8. Çok dillilik içinde Türkçe'nin birinci sınıf olması (MyMojoHealth kanıtı: mümkün ve değerli).
