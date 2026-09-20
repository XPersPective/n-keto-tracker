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

### İçerik veri sürümü

- `evidence` içerik paketi: henüz yayınlanmadı (T25'te v1.0).
