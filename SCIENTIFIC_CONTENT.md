# Bilimsel İçerik ve İnceleme Süreci — N Keto Tracker

## Kanıt sınıfları (MASTER_PROMPT §2.1)

| Kod | Etiket | Türü |
|---|---|---|
| E1 | Klinik kılavuz / yüksek düzey kanıt | Güçlü insan verisi |
| E2 | İnsan çalışması | Randomize veya gözlemsel insan verisi |
| E3 | Erken güvenlik bulgusu | Küçük insan örneği, etkinlik iddiası yok |
| E4 | Laboratuvar/hayvan araştırması | Mekanik |
| E5 | Araştırmacı önerisi | Hipotez/çerçeve |
| E6 | Genel eğitim | Beslenme/ölçüm bilgisi |

## Başlangıç kaynak setine bağlanabilirlik (docs/research/
EVIDENCE_VERIFICATION.md'de doğrulanmış)

7 kaynak künyesi ve doğrulama kaydı (2026-09-20):

1. Meidenbauer, Mukherjee, Seyfried (2015) — GKI hesaplayıcısı; genel eğitim.
2. Duraj ve ark. (2024) — KMT araştırma çerçevesi; **hastalığa özel filtre ile**.
3. Persiani ve ark. (2026) — sistematik derleme; **hastalığa özel filtre ile**.
4. Voss ve ark. (2020) — ERGO2 randomized trial; **hastalığa özel filtre ile**.
5. Amaral LJ, ve ark. (2025) — faz 1 uygulanabilirlik; **hastalığa özel filtre ile** (author düzeltmesi: "Klein P" değil **Amaral LJ**).
6. Martin-McGill ve ark. (2020) — KEATING uygulanabilirlik; **hastalığa özel filtre ile**.
7. Mifflin ve ark. (1990) — REE denklemi; genel enerji tahmini.

## Provenance zorunluluğu (§2.3)

Her kayıtta kaynak alanları (id, künye, kanıt sınıfı, inceleme tarihi,
sınırlılıklar) zorunludur; hatalı DOI/PMID/PMCID biçimi build'i keser.
İçerik yalnızca yeni uygulama sürümüyle güncellenir (`contentVersion`).
Telifli tam metinler kopyalanmaz; özgün kısa özetler yazılır.

## İnceleme süreci

Yazar: ürün geliştirme ekibi. Kyle/beslenme uzmanı incelemesi yayın
öncesi şarttır (açık konu). Çeviri doğruluğu için `TRANSLATION_NOTES.md`
yakında eklenecek (kaynak sayısal eşikler TR/EN'de birebir aynıdır).

## Açık konular

- `foods.json` per-100g değerleri USDA SR Legacy referanslarından
  elle derlendi; kayıt başına `sourceRecordId` şekli
  "FDC-SR-transcribed:..." olarak işaretlidir. Yayın öncesi beslenme
  uzmanının örnekleme denetimi terkit edilir.
