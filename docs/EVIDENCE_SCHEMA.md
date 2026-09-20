# Kanıt İçerik Şeması — N Keto Tracker

Sürüm: 1.0 · Tarih: 2026-09-20 · Kaynak: `docs/MASTER_PROMPT.md` §2.1 ve §2.3; doğrulanmış künyeler: `docs/research/EVIDENCE_VERIFICATION.md`.

## 1. EvidenceSource JSON Şeması

Bir `EvidenceSource` kaydı, paketli yerel `assets/seed/evidence.json` içinde şu şemayla saklanır (JSON Schema draft-07):

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "$id": "https://github.com/XPersPective/n-keto-tracker/docs/EVIDENCE_SCHEMA.md#evidenceSource",
  "title": "EvidenceSource",
  "type": "object",
  "additionalProperties": false,
  "required": [
    "id", "titleTr", "titleEn", "plainSummaryTr", "plainSummaryEn",
    "claimTr", "claimEn", "evidenceLevel", "studyType", "population",
    "year", "authors", "journal", "canonicalUrl", "accessedAt",
    "contentVersion", "lastReviewedAt", "reviewedByRole",
    "limitationsTr", "limitationsEn",
    "conflictsOrFundingNoteTr", "conflictsOrFundingNoteEn",
    "linkedFeatureIds"
  ],
  "properties": {
    "id":                { "type": "string", "pattern": "^ev-[a-z0-9-]+$" },
    "titleTr":           { "type": "string", "minLength": 1 },
    "titleEn":           { "type": "string", "minLength": 1 },
    "plainSummaryTr":    { "type": "string", "minLength": 1 },
    "plainSummaryEn":    { "type": "string", "minLength": 1 },
    "claimTr":           { "type": "string", "minLength": 1 },
    "claimEn":           { "type": "string", "minLength": 1 },
    "evidenceLevel":     { "type": "string", "enum": ["E1", "E2", "E3", "E4", "E5", "E6"] },
    "studyType":         { "type": "string", "minLength": 1 },
    "population":        { "type": "string", "minLength": 1 },
    "sampleSize":        { "type": ["integer", "null"], "minimum": 0 },
    "year":              { "type": "integer", "minimum": 1900, "maximum": 2100 },
    "authors":           { "type": "array", "items": { "type": "string" }, "minItems": 1 },
    "journal":           { "type": "string", "minLength": 1 },
    "doi":               { "type": ["string", "null"], "pattern": "^10\\.[0-9]{4,9}/\\S+$" },
    "pmid":              { "type": ["integer", "null"] },
    "pmcid":             { "type": ["string", "null"], "pattern": "^PMC[0-9]+$" },
    "canonicalUrl":      { "type": "string", "format": "uri" },
    "accessedAt":        { "type": "string", "format": "date" },
    "contentVersion":    { "type": "string", "pattern": "^v[0-9]+\\.[0-9]+$" },
    "lastReviewedAt":    { "type": "string", "format": "date" },
    "reviewedByRole":    { "type": "string", "minLength": 1 },
    "limitationsTr":     { "type": "string", "minLength": 1 },
    "limitationsEn":     { "type": "string", "minLength": 1 },
    "conflictsOrFundingNoteTr":  { "type": "string" },
    "conflictsOrFundingNoteEn":  { "type": "string" },
    "linkedFeatureIds":  { "type": "array", "items": { "type": "string" }, "uniqueItems": true }
  }
}
```

Kurallar:
- `doi`, `pmid`, `pmcid` nullable — ama her kayıtta en az biri dolu olmalı (şema + seed zamanı validator kontrolü; MASTER §16.5: kırık DOI/PMID biçimi build'i düşürür).
- `canonicalUrl` yalnızca **kopyalanabilir metin** olarak gösterilir; uygulama bağlantıyı kendisi açmaz (MASTER §2.3).
- `additionalProperties: false` — bilinmeyen alan şema dışıdır; içerik sürümü değişmeden yeni alan eklenmez.
- Telifli makale tam metni paketlenmez; `plainSummary*` özgün kısa özettir.

## 2. EvidenceClaim kaydı

Her `EvidenceClaim` (iddialar düzeyi) şu alanları taşır:

```json
{
  "id":              { "type": "string", "pattern": "^claim-[a-z0-9-]+$" },
  "sourceId":        { "type": "string", "pattern": "^ev-[a-z0-9-]+$" },
  "textTr":          { "type": "string" },
  "textEn":          { "type": "string" },
  "evidenceLevel":   { "type": "string", "enum": ["E1", "E2", "E3", "E4", "E5", "E6"] },
  "visibleLabelTr":  { "type": "string" },
  "visibleLabelEn":  { "type": "string" },
  "linkedFeatureIds":{ "type": "array", "items": { "type": "string" } }
}
```

`sourceId` geçerli bir `EvidenceSource.id` olmalı (FK); claim'in kanıt sınıfı kaynağın sınıfından **yüksek** olamaz (E1 en yüksek).

## 3. Kanıt sınıfları → görünür etiket eşlemesi (MASTER §2.1)

| Kod | Görünen etiket (TR) | Visible label (EN) | Anlamı |
|---|---|---|---|
| E1 | Klinik kılavuz / yüksek düzey kanıt | Clinical guideline / strong evidence | İlgili, güncel kılavuz veya güçlü insan verisi |
| E2 | İnsan çalışması | Human study | Randomize veya gözlemsel insan verisi; tasarım ve örneklem açıkça yazılır |
| E3 | Erken güvenlik bulgusu | Early safety signal | Genellikle küçük ve etkinlik için yetersiz insan çalışması |
| E4 | Laboratuvar/hayvan araştırması | Laboratory / animal research | Hücre, hayvan veya mekanizma; insan faydası anlamına gelmez |
| E5 | Araştırmacı görüşü | Researcher proposal | Hipotez, tartışma, konsensüs önerisi; doğrulanmamış çerçeve |
| E6 | Genel eğitim | General information | Klinik sonuç iddiası içermeyen temel beslenme/ölçüm bilgisi |

- `E1–E6` kodları yalnız içerik yönetimi/kalite kontrol içindir; sıradan kullanıcıya kod olarak gösterilmez.
- "Seyfried yaklaşımı" ayrı bir kanıt sınıfı değildir; her iddia çalışmanın gerçek tasarımına göre etiketlenir (MASTER §2.1).
- T2 atamaları (bağlayıcı): Meidenbauer 2015 → E6 (araç tanımı) + E5 (bölge öngörüsü); Duraj 2024 → E5; Persiani 2026 → E2; Voss 2020 → E2; **Amaral LJ 2025** → E3; Martin-McGill 2020 → E3; Mifflin 1990 → E6/E2.

## 4. Sunum katmanı kuralları (MASTER §2.1–2.2)

1. Kullanıcıya önce en fazla 2–3 cümlelik sade sonuç.
2. "Ayrıntıyı gör" → kanıt türü + sınırlılıklar.
3. "Bu bilgi nereden geliyor?" → yayın künyesi (doi/pmid/pmcid dahil).
4. Kaynaklar açılmadan da temel işlevler anlaşılabilir olmalı.
5. Hastalığa özel içerik yalnız kullanıcı bilinçli filtre açtığında listelenir; ana sayfada öneri olarak görünmez.

## 5. Build zamanı doğrulamaları (MASTER §16.5)

- Her `EvidenceClaim` için: `sourceId` + `evidenceLevel` + `lastReviewedAt` dolu.
- Kırık DOI/PMID/PMCID **biçimi** veya eksik inceleme tarihi veya kaynaksız referans bandı → build başarısız.
- Yasaklı kesin sağlık dili için TR/EN içerik lint listesi ("tedavi eder", "iyileştirir", "şifalı", "garantili" vb.).
- Çevirilerde sayısal eşik ve formüller aynı olmalı (TR/EN metin karşılaştırma testi).
- İçerik paketi sürümü + değişiklik günlüğü zorunlu (`contentVersion`, ContentVersion tablosu).
