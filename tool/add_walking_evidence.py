"""Kanıt kütüphanesine doğrulanmış iki yürüyüş kaynağı ekler.

Daha önce eklenen `walk-murtagh-2015` kaydı UYDURMAYDI ve PB-028'de
silindi: kaydın PMID olarak kullandığı 25952641 numarası yürüyüş
makalesi değildi (Europe PMC doğrulaması: J Vasc Interv Radiol 2015,
tavşan karaciğer embolizasyon deneyi).

Buradaki iki kaynak Europe PMC REST API ile 2026-10-13'te doğrulandı:
  https://www.ebi.ac.uk/europepmc/webservices/rest/search?query=EXT_ID:<pmid>&resultType=core&format=json

Idempotent: kayıt id'si zaten varsa eklemez.
"""
import json

P = 'assets/seed/evidence.json'
with open(P, 'r', encoding='utf-8') as f:
    doc = json.load(f)

EXTRAS = [
    {
        'id': 'walk-richardson-2008',
        'titleTr': 'Pedometer tabanlı yürüyüş müdahaleleri ve kilo kaybı meta-analizi (2008)',
        'titleEn': 'A meta-analysis of pedometer-based walking interventions and weight loss',
        'plainSummaryTr': (
            'Dokuz prospektif kohortun (307 katılımcı, medyan 16 hafta) meta-analizi: '
            'pedometer tabanlı yürüyüş programları başlangıçtan ortalama 1.27 kg (95% GA '
            '1.85-0.70) kilo kaybı sağlar; haftada ortalama 0.05 kg. Diyet müdahalesi '
            'içermeyen çalışmalar.'
        ),
        'plainSummaryEn': (
            'A meta-analysis of nine pedometer-based walking cohorts (307 participants, '
            'median 16 weeks) found a pooled mean weight change of -1.27 kg '
            '(95% CI -1.85 to -0.70), about 0.05 kg per week. These studies did not '
            'include a dietary intervention.'
        ),
        'claimTr': (
            'Pedometer destekli yürüyüş programları orta düzeyde kilo kaybı sağlar '
            '(havuzlanmış 1.27 kg); daha uzun programlar daha fazla kayıp verir.'
        ),
        'claimEn': (
            'Pedometer-based walking programmes produce modest weight loss '
            '(pooled -1.27 kg); longer programmes produce more.'
        ),
        'evidenceLevel': 'E2',
        'evidenceLabelTr': 'Meta-analiz (prospektif kohortlar)',
        'evidenceLabelEn': 'Meta-analysis of prospective cohorts',
        'studyType': 'Meta-analiz (prospektif kohortlar ve RCT)',
        'population': 'Yetişkin (obez ve fazla kilolu dahil)',
        'sampleSize': 307,
        'year': 2008,
        'authors': [
            'Richardson CR', 'Newton TL', 'Abraham JJ', 'Sen A', 'Jimbo M',
            'Swartz AM',
        ],
        'journal': 'Annals of Family Medicine',
        'doi': '10.1370/afm.761',
        'pmid': 18195317,
        'pmcid': 'PMC2203404',
        'canonicalUrl': 'https://doi.org/10.1370/afm.761',
        'accessedAt': '2026-10-13',
        'limitationsTr': (
            'Diyet müdahalesi yoktur; kohortlar heterojendir; bireysel yanıt çok '
            'değişkendir ve bireysel düzeyde öngörü yapılamaz.'
        ),
        'limitationsEn': (
            'No dietary co-intervention; heterogeneous cohorts; highly variable '
            'individual response.'
        ),
        'conflictsTr': None,
        'conflictsEn': None,
        'diseaseSpecific': False,
    },
    {
        'id': 'walk-swift-2018',
        'titleTr': 'Egzersiz ve fiziksel aktivitenin kilo kaybı ve sürdürmedeki etkisi (2018)',
        'titleEn': 'The Effects of Exercise and Physical Activity on Weight Loss and Maintenance',
        'plainSummaryTr': (
            'Uzman derlemesi: halk sağlığı asgarisindeki 150 dk/hafta orta yoğunluklu '
            'aerobik aktivite kardiyovasküler sağlığı iyileştirir, ancak enerji kısıtlaması '
            'olmadan klinik olarak anlamlı kilo kaybı için genellikle yetersizdir. '
            'Bireysel kilo kaybı yanıtı çok değişkendir.'
        ),
        'plainSummaryEn': (
            'Expert review concluding that the minimum public-health guideline of '
            '150 min/week moderate aerobic activity improves cardiovascular health but is '
            'generally inadequate for clinically significant weight loss without caloric '
            'restriction. Individual weight-loss response is highly variable.'
        ),
        'claimTr': (
            'Enerji kısıtlaması olmadan 150 dk/hafta aerobik aktivite tek başına klinik '
            'anlamlı kilo kaybı için genellikle yetersizdir.'
        ),
        'claimEn': (
            '150 min/week of aerobic activity alone is generally inadequate for '
            'clinically significant weight loss without caloric restriction.'
        ),
        'evidenceLevel': 'E3',
        'evidenceLabelTr': 'Uzman/narratif derleme',
        'evidenceLabelEn': 'Expert narrative review',
        'studyType': 'Narratift inceleme (meta-analiz değildir)',
        'population': 'Fazla kilolu ve obez yetişkinler',
        'sampleSize': None,
        'year': 2018,
        'authors': [
            'Swift DL', 'McGee JE', 'Earnest CP', 'Carlisle E', 'Nygard M',
            'Johannsen NM',
        ],
        'journal': 'Progress in Cardiovascular Diseases',
        'doi': '10.1016/j.pcad.2018.07.014',
        'pmid': 30003901,
        'pmcid': None,
        'canonicalUrl': 'https://doi.org/10.1016/j.pcad.2018.07.014',
        'accessedAt': '2026-10-13',
        'limitationsTr': (
            'Narratift derleme — sistematik arama ve havuzlama yoktur; nicel etki '
            'büyüklüğü vermez.'
        ),
        'limitationsEn': (
            'Narrative review - no systematic search or pooling; does not provide a '
            'quantitative effect size.'
        ),
        'conflictsTr': None,
        'conflictsEn': None,
        'diseaseSpecific': False,
    },
]

existing = {s['id'] for s in doc['sources']}
added = [s for s in EXTRAS if s['id'] not in existing]
doc['sources'].extend(added)

doc['changeLogTr'] = (
    doc.get('changeLogTr', '') +
    ' | PB-028: walk-murtagh-2015 kaldırıldı (PMID 25952641 yürüyüş makalesi '
    'değildi; J Vasc Interv Radiol 2015, tavşan embolizasyon deneyi). '
    '+2 doğrulanmış kaynak: Richardson 2008 pedometre meta-analizi, '
    'Swift 2018 egzersiz/kilo kaybı derlemesi.'
).strip()
doc['changeLogEn'] = (
    doc.get('changeLogEn', '') +
    ' | PB-028: removed walk-murtagh-2015 (PMID 25952641 was not a walking '
    'paper; J Vasc Interv Radiol 2015, rabbit embolization study). '
    '+2 verified sources: Richardson 2008 pedometer meta-analysis, '
    'Swift 2018 exercise/weight-loss review.'
).strip()

with open(P, 'w', encoding='utf-8') as f:
    json.dump(doc, f, ensure_ascii=False, indent=2)
    f.write('\n')

print(f'Eklenen: {len(added)} ({", ".join(s["id"] for s in added)})')
print(f'Toplam kaynak: {len(doc["sources"])}')