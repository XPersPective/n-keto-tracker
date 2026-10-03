# Changelog — N Keto Tracker

Bu dosya kullanıcıya dönük sürüm değişikliklerini izler. Biçim Keep a
Changelog'a yakın tutulur; tarihler ISO 8601.

## [Unreleased]

### Eklendi

- Aşama 0: pazar/rekabet araştırması (`docs/research/`), bilimsel kaynak
  doğrulama (EVIDENCE_VERIFICATION; 5. kaynağın ilk yazarı Amaral LJ olarak
  düzeltildi), gereksinim matrisi (105 REQ), tehdit modeli, kanıt içerik
  şeması.
- Flutter iskeleti: 5 sekmeli Material 3 uygulama (Bugün/Günlük/Plan/
  Trendler/Rehber), TR/EN yerelleştirme altyapısı, tek tema üreticisi.
- Çevrimdışı garanti altyapısı: manifest'lerde ağ izni yok, yedekleme
  dışlama kuralları, R8 küçültme, `tool/check_offline.sh` + CI.
- GKI referans test vektörleri (`test/fixtures/gki_reference_cases.json`,
  18 vektör; 90 mg/dL + 2,5 mmol/L → 2,0 referans vakası dahil).

- Özgün marka ikon seti (tüm platform boyutları, monokrom, splash).
- Ayarlar > Hakkında: sürüm, açık kaynak lisansları, gizlilik, tıbbi
  feragat, paylaş.
- TR/EN gizlilik politikası (`PRIVACY.md`), bilimsel içerik politikası
  (`SCIENTIFIC_CONTENT.md`), kullanıcı kılavuzu (`docs/USER_GUIDE_TR.md`,
  `docs/USER_GUIDE_EN.md`).
- Mağaza/pazarlama paketi (`docs/marketing/`).
- Release sertleştirmesi: `--obfuscate --split-debug-info` (semboller repo
  dışında); entegrasyon, erişilebilirlik ve migration testleri.
- Hakkında > Diğer uygulamalar (ORTAK §3.6): tamamen çevrimdışı gömülü
  katalog; bozuk veri çökmez, mağaza bağlantısı yalnız kopyalanır.
- Hakkında başlığında kısa slogan (TR/EN).

### Düzeltildi (sürüm adayı doğrulaması, 2026-10-03)

- Taze kurulumda uygulama hiçbir akışta çökmez: üretim veritabanı
  bağlantısı ve gömülü içerik (besin/tarif/kanıt) açılışta yüklenir;
  besin araması ilk günden çalışır.
- Uygulama geç tepki verme (ANR) giderildi: veritabanı işlemleri arka
  plan izolesinde çalışır.
- Onboarding her açılışta tekrar edilmez; geçerli onam varsa doğrudan
  Bugün açılır.
- Onboarding'de seçilen dil sonraki açılışlarda uygulanır (cihaz dili
  Türkçe değilse bile).
- Kayıt sonrası sekmeler ve Bugün kartları anında güncel veriyi
  gösterir; günlükte ölçümün en yakın önceki öğüne zamansal bağı
  ("X saat sonra — yalnızca zaman bağlamı, etki beyanı değildir")
  görünür.
- Semptom kaydı onay metni doğru ("Semptom kaydedildi."); haftalık plan
  satırlarında okunur tarif başlıkları gösterilir.

### İçerik veri sürümü

- `evidence` içerik paketi: henüz yayınlanmadı (T25'te v1.0).
