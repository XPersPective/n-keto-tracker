# Besin Verisi Provenance — N Keto Tracker

Sürüm: `food-seed-v1.0` · Tarih: 2026-09-20 · Görev: T15 · Üretici:
`tool/gen_foods_seed.py` (tekrar üretilebilir).

## Kaynak

- **USDA FoodData Central** (SR Legacy / Foundation Foods referans
  değerleri) — <https://fdc.nal.usda.gov>
- **Lisans:** ABD kamu malı (17 U.S.C. §105 — ABD Hükümeti eseri).
  Serbestçe kopyalanabilir, dağıtılabilir ve türev ürünlerde
  kullanılabilir. USDA *nezaketen* atfı talep eder (zorunlu değildir);
  bu projede atıf her besin kaydının `dataSource` alanında ve bu
  belgede yapılır. ORTAK_UYGULAMA_STANDARDI.md §2 izinli listeyle ve
  GPL-3.0 ile uyumludur (THIRD_PARTY_NOTICES.md'de kayıtlı).
- **Erişim/derleme tarihi:** 2026-09-20.

## Derleme yöntemi (dürüst beyan)

1. Değerler (100 g başına enerji/protein/yağ/toplam karbonhidrat/lif)
   USDA SR Legacy yayımlı referans tablolarından **elle derlenmiştir**;
   her kayıt API üzerinden tek tek doğrulanmamıştır.
2. Bu nedenle `sourceRecordId` alanı `FDC-SR-transcribed:<slug>`
   biçimindedir: doğrudan tek FDC kaydına bağlanmadığını dürüstçe
   gösterir.
3. **Açık konu (release engelleyici değil ama yayın öncesi şart):**
   yayın öncesi beslenme uzmanı tarafından örnekleme denetimi ve
   kayıt bazlı FDC API doğrulaması yapılmalıdır; `lastReviewedAt`
   alanı o incelemenin tarihiyle güncellenir. Bkz.
   `SCIENTIFIC_CONTENT.md` (T33).
4. Kapsam: 152 besin; Türkiye'de yaygın besinler (beyaz peynir,
   kaşar, sucuk, pastırma, simit, menemen vb.) ve uluslararası
   keto-relevanslı besinler birlikte.

## Veri kuralları

- `netCarb = max(0, carbohydrateTotal − fiber)` — üretici betik
  hesaplar; negatif değer oluşamaz. TEST EDİLEN.
- Şeker alkollerinin otomatik çıkarımı **YAPILMAZ** (ülke/etiket
  mevzuatı farklılık gösterir; MASTER_PROMPT §8.1). Kullanıcı etiketten
  kendi net karbonhidratını girerse bu "kullanıcı beyanı" olarak ayrı
  alanda saklanır (MealItem.userNetCarbOverrideG; MASTER §8.2).
- Kullanıcı besinleri (`isUserCreated: true`) bu seed setinden bağımsız
  tutulur; `id` alanları `user:` önekiyle çakışmaz.
- Porsiyon seçenekleri tipik Türk/uluslararası porsiyonlardır;
  karbonhidrat hesabı her zaman 100 g değerinden ölçeklenir.

## Güncelleme süreci

- Seed verisi yalnızca yeni uygulama sürümüyle güncellenir
  (MASTER_PROMPT §2.3). `contentVersion` artırılır; `CHANGELOG.md`'e
  madde girilir.
- Değişen değerler migration ile mevcut kayıtlara sessizce işlenmez;
  kullanıcı geçmişi korunur.
