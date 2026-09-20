# Bilimsel Kaynak Doğrulama — N Keto Tracker

Doğrulama tarihi: **2026-09-20**. Amaç: MASTER_PROMPT §21'deki 7 başlangıç kaynağının künye doğruluğunun kanıtlanması ve GKI formülü/bölge önerilerinin birincil kaynaklardan alıntılanması. `docs/MASTER_PROMPT.md` değiştirilmez; bu dosya doğrulama kaydıdır ve içerik yazımında (T25, T33) bağlayıcı düzeltmeleri bildirir.

## Doğrulama özeti

| # | Kaynak (master prompt'taki ad) | Sonuç | Düzeltme/bulgu |
|---|---|---|---|
| 1 | Meidenbauer, Mukherjee, Seyfried (2015) | **MATCH** | Künye birebir doğru. Dönüşüm katsayısı nüansı: tam metin 18,016 kullanır (aşağıda) |
| 2 | Duraj ve ark. (2024) | **MATCH + PMID/PMCID eklendi** | PMID: 39639257; PMCID: PMC11622503 (master prompt'ta yoktu). Europe PMC türü: brief-report/review |
| 3 | Persiani ve ark. (2026) | **MATCH** | Nutrients, 2026 Tem 3; künye doğru |
| 4 | Voss ve ark. (2020) ERGO2 | **MATCH** | Künye doğru; PMCID yok (doğru — kapalı erişimli özet) |
| 5 | **"Klein P, et al. (2025)"** | **YAZIM HATASI BULUNDU** | DOI/PMID/PMCID/başlık/dergi doğru; ancak ilk yazar **Amaral LJ**, Gresham G, Kim S (PubMed 40595067). "Klein P" bu makalenin ilk yazarı değil (Klein P, Duraj 2024'ün eş-yazarı — muhtemelen karışıklık kaynağı). Uygulama içi künyelerde "Amaral LJ, ve ark." kullanılacak |
| 6 | Martin-McGill ve ark. (2020) KEATING | **MATCH** | Künye birebir doğru |
| 7 | Mifflin ve ark. (1990) | **MATCH** | AJCN 51(2):241–247; künye doğru |

## Kaynak künyeleri (doğrulanmış hâliyle)

### 1. Meidenbauer JJ, Mukherjee P, Seyfried TN (2015)
- Başlık: *The glucose ketone index calculator: a simple tool to monitor therapeutic efficacy for metabolic management of brain cancer.*
- Dergi/yıl: Nutrition & Metabolism (London), 2015; 12:12.
- DOI: 10.1186/s12986-015-0009-2 · PMID: 25798181 · PMCID: PMC4367849.
- Erişim: https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pubmed&id=25798181&retmode=json (2026-09-20); tam metin: https://www.ebi.ac.uk/europepmc/webservices/rest/PMC4367849/fullTextXML (2026-09-20).
- **Formül alıntıları (tam metin, Methods):** GKI = "the molar ratio of circulating glucose over β-OHB, which is the major circulating ketone body"; hesaplayıcı glukozu mg/dL'den mM'ye "**dividing by 18.016**" ile çevirir ve mM keton değerine böler.
- **Bölge alıntıları (Discussion):** "The zone of metabolic management is likely entered with GKI values between 1 and 2 for humans. Optimal management is predicted for values approaching 1.0." Ölçüm zamanı önerisi: "2–3 hours postprandial, twice a day if possible".
- **Dönüşüm katsayısı kaydı (uygulama kararı):** Birincil kaynak 18,016 (glukoz mol kütlesi 180,16 g/mol) kullanır; MASTER_PROMPT §2.4 formül spesini **18,0** olarak sabitler ve 90 mg/dL + 2,5 mmol/L → tam 2,0 referans vektörünü zorunlu kılar. 18,016 ile: 90/18,016 = 4,9956 mmol/L; GKI = 1,998 (gösterimde 2,0 ama tam değil). Uygulama, normatif spec gereği **18,0**'ı FORMULA_VERSION ile sabitler; fark (%0,09) gösterim hassasiyetinin (1 ondalık) altındadır. Kaynağa sadakat bu dosyada belgelendi; katsayı değişirse yalnızca yeni FORMULA_VERSION + güncellenmiş referans vektörleriyle yapılır (MASTER §2.4).

### 2. Duraj T, ve ark. (2024) — Seyfried TN son yazar
- Başlık: *Clinical research framework proposal for ketogenic metabolic therapy in glioblastoma.*
- Dergi/yıl: BMC Medicine, 2024; 22(1):578.
- DOI: 10.1186/s12916-024-03775-4 · PMID: 39639257 · PMCID: PMC11622503.
- Erişim: https://www.ebi.ac.uk/europepmc/webservices/rest/search?query=DOI%3A%2210.1186%2Fs12916-024-03775-4%22&format=json (2026-09-20); tam metin: https://www.ebi.ac.uk/europepmc/webservices/rest/PMC11622503/fullTextXML (2026-09-20).
- Yazarlar (ilk + son): Duraj T, Kalamian M, Zuccoli G, …, Mukherjee P, Seyfried TN (43 yazar).
- **Bölge alıntıları (tam metin):** "Allow for a sustained GKI of 2.0 or below, ideally 1.0 or below"; "GKI ≤ 2.0, ideally ≤ 1.0, with absolute glucose levels < 90 mg/dl (5 mM)"; terapötik bölge: "glucose levels are less than two-fold ketone levels", optimal: "glucose levels are equal or lower than ketone levels (e.g., 4 mM glucose, 4 mM βHB, GKI ≤ 1)".
- **Reçete olmadığına dair alıntı (Fig. 2 başlığı):** "the suggested glucose and ketone levels are representative of inter-individual and intra-individual variability, not prescriptive". Glukoz <90 mg/dL eşiği için: "this is an arbitrary, statistically derived cut-off … and does not define a known [threshold]".
- **Kullanım kuralı:** Uygulamada yalnızca isteğe bağlı araştırma bantları olarak (MASTER §6.4); bölge etiketleri: ≤1,0 "önerilen optimal araştırma bölgesi", 1,0<x≤2,0 "önerilen terapötik araştırma bölgesi", >2,0 "≤2 araştırma bölgesinin dışında"; "kötü/başarısız/tehlikeli" dili yok. Europe PMC yayın türü "brief-report; review" — klinik kılavuz değildir.

### 3. Persiani M, Dallolio L, Masini A, ve ark. (2026)
- Başlık: *Ketogenic Diet in the Treatment of Malignant Gliomas: A Systematic Review.*
- Dergi/yıl: Nutrients, 2026 Jul 3; 18(13):2166.
- DOI: 10.3390/nu18132166 · PMID: 42451166 · PMCID: PMC13363701.
- Erişim: https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pubmed&id=42451166&retmode=json (2026-09-20).
- Doğrulama: künye (23 çalışma/306 hasta bağlamı master promptta; sayıların içerikteki karşılığı T25'te tam metinden teyit edilecek — abstract düzeyinde bu sayılar doğrulanmadı, künye doğrulandı).

### 4. Voss M, Wagner M, von Mettenheim N, ve ark. (2020)
- Başlık: *ERGO2: A Prospective, Randomized Trial of Calorie-Restricted Ketogenic Diet and Fasting in Addition to Reirradiation for Malignant Glioma.*
- Dergi/yıl: International Journal of Radiation Oncology, Biology, Physics, 2020 Nov 15; 108(4):1046–1055.
- DOI: 10.1016/j.ijrobp.2020.06.021 · PMID: 32619561 · PMCID: yok.
- Erişim: https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pubmed&id=32619561&retmode=json (2026-09-20).

### 5. Amaral LJ, Gresham G, Kim S, ve ark. (2025) — master prompttaki "Klein P, et al." düzeltmesi
- Başlık: *A phase 1 safety and feasibility trial of a ketogenic diet plus standard of care for patients with recently diagnosed glioblastoma.*
- Dergi/yıl: Scientific Reports, 2025 Jul 1; 15.
- DOI: 10.1038/s41598-025-06675-6 · PMID: 40595067 · PMCID: PMC12215994.
- Erişim: https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pubmed&id=40595067&retmode=json (2026-09-20).
- **Bulgu:** DOI/PMID/PMCID ve başlık master promptla aynı; yazar ataması yanlıştı. İlk yazarlar Amaral LJ, Gresham G, Kim S. Uygulama içi ve doküman künyelerinde "Amaral LJ, ve ark. (2025)" yazılır; kanıt sınıfı E3 (küçük, tek kollü faz 1) değişmez.

### 6. Martin-McGill KJ, Marson AG, Tudur Smith C, ve ark. (2020)
- Başlık: *Ketogenic diets as an adjuvant therapy for glioblastoma (KEATING): a randomized, mixed methods, feasibility study.*
- Dergi/yıl: Journal of Neuro-Oncology, 2020 Mar; 147(3):561–572.
- DOI: 10.1007/s11060-020-03417-8 · PMID: 32036576 · PMCID: PMC7076054.
- Erişim: https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pubmed&id=32036576&retmode=json (2026-09-20).

### 7. Mifflin MD, St Jeor ST, Hill LA, ve ark. (1990)
- Başlık: *A new predictive equation for resting energy expenditure in healthy individuals.*
- Dergi/yıl: The American Journal of Clinical Nutrition, 1990 Feb; 51(2):241–247.
- DOI: 10.1093/ajcn/51.2.241 · PMID: 2305711 · PMCID: yok.
- Erişim: https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pubmed&id=2305711&retmode=json (2026-09-20).
- Kullanım: Mifflin–St Jeor REE denklemi (erkek +5 / kadın −161) yalnızca **genel tahmin** olarak; klinik enerji reçetesi değil (MASTER §7).

## Kanıt sınıfı atamaları (MASTER §2.1'e göre, T25'te kullanılacak)

| Kaynak | Sınıf | Gerekçe |
|---|---|---|
| Meidenbauer 2015 | E6 (araç tanımı) + E5 (bölge önerisi) | Hesaplayıcı tanımı genel eğitim; 1–2 bölgesi yazar öngörüsü ("is likely entered", "predicted") |
| Duraj 2024 | E5 | Araştırma çerçevesi önerisi; "not prescriptive" açıkça yazılı |
| Persiani 2026 | E2 | Sistematik derleme (insan verisi sentezi) |
| Voss 2020 | E2 | Randomize prospective insan çalışması |
| Amaral 2025 (eski adıyla Klein) | E3 | Tek kollü faz 1; güvenlik/uygulanabilirlik sinyali, etkinlik kanıtı değil |
| Martin-McGill 2020 | E3 | Randomize ama uygulanabilirlik (feasibility) tasarımı |
| Mifflin 1990 | E6/E2 | Sağlıklı yetişkinlerde türetilmiş tahmin denklemi (kıyaslamalı ölçüm çalışması) |

## Referans test vektörleri

`test/fixtures/gki_reference_cases.json` bu dosyayla birlikte oluşturuldu (17 vektör; formül: `glucoseMmolL = glucoseMgDl / 18.0`, `GKI = glucoseMmolL / bhbMmolL`; MASTER_PROMPT §2.4 normatif). Divizör 18,016 konusu yukarıda belgelendi; spec 18,0'ı zorunlu kılıyor ve referans vektör 90+2,5→2,0 bunu kilitliyor.
