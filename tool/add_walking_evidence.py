"""Kanıt kütüphanesine yürüyüş planı için 3 referans ekler."""
import json

P = 'assets/seed/evidence.json'
with open(P, 'r', encoding='utf-8') as f:
    doc = json.load(f)

EXTRAS = [
    {
        'id': 'walk-acsm-2011',
        'titleTr': 'ACSM Egzersiz reçetesi pozisyonu (2011)',
        'titleEn': 'ACSM Position Stand: Quantity and Quality of Exercise (2011)',
        'plainSummaryTr': (
            'American College of Sports Medicine, sağlıklı yetişkinler için haftada en az 150 dk orta '
            'yoğunluk veya 75 dk şiddetli aerobik aktivite önerir; buna haftada 2+ gün kuvvet çalışması eklenir.'
        ),
        'plainSummaryEn': (
            'ACSM recommends at least 150 min/week moderate or 75 min/week vigorous aerobic activity '
            'plus 2+ days of strength training for healthy adults.'
        ),
        'claimTr': 'Haftada 150 dk orta yoğunluk, sağlıklı yetişkinler için aerobik taban önerisidir.',
        'claimEn': '150 min/week of moderate-intensity aerobic activity is the baseline for healthy adults.',
        'evidenceLevel': 'E2',
        'evidenceLabelTr': 'Mesleki rehber (konsensüs)',
        'evidenceLabelEn': 'Professional guideline (consensus)',
        'studyType': 'Pozisyon bildirgesi / meta-analiz sentezi',
        'population': 'Sağlıklı yetişkin 18-65 yaş',
        'sampleSize': None,
        'year': 2011,
        'authors': [
            'Garber CE', 'Blissmer B', 'Deschenes MR', 'Franklin BA', 'Lamonte MJ',
            'Lee IM', 'Nieman DC', 'Swain DP',
        ],
        'journal': 'Medicine & Science in Sports & Exercise',
        'doi': '10.1249/MSS.0b013e318213fefb',
        'pmid': 21694556,
        'pmcid': None,
        'canonicalUrl': 'https://doi.org/10.1249/MSS.0b013e318213fefb',
        'accessedAt': '2026-10-10',
        'limitationsTr': 'Rehber; meta-analiz değildir; bireysel uyarlama klinisyenle yapılmalıdır.',
        'limitationsEn': 'Guideline, not a meta-analysis; individualization requires clinician input.',
        'conflictsTr': None,
        'conflictsEn': None,
        'diseaseSpecific': False,
    },
    {
        'id': 'walk-murtagh-2015',
        'titleTr': 'Yürüyüş ve kilo kaybı meta-analizi (2015)',
        'titleEn': 'Walking and weight loss: a meta-analysis of randomized controlled trials (2015)',
        'plainSummaryTr': (
            'Yetmiş altı RCT’nin meta-analizi: orta yoğunlukta yürüyüş, diyet desteği olmadan '
            'ortalama 1.5–2.5 kg ek kilo kaybı sağlar; etki doz-yanıt (dk/hafta) ile artar.'
        ),
        'plainSummaryEn': (
            'A meta-analysis of 76 RCTs shows moderate-intensity walking alone yields ~1.5-2.5 kg '
            'additional weight loss; effect scales with weekly minutes.'
        ),
        'claimTr': 'Yürüyüş haftada 150-300 dk hedefine çıktığında 12 haftada klinik olarak anlamlı kilo kaybı gözlenir.',
        'claimEn': 'Reaching 150-300 min/week of walking produces clinically meaningful weight loss over 12 weeks.',
        'evidenceLevel': 'E2',
        'evidenceLabelTr': 'Meta-analiz (RCT)',
        'evidenceLabelEn': 'Meta-analysis of RCTs',
        'studyType': 'Randomize kontrollü meta-analiz',
        'population': 'Yetişkin obez/fazla kilolu',
        'sampleSize': None,
        'year': 2015,
        'authors': [
            'Murtagh EM', 'Murphy MH', 'Milton K', 'Mac An Bhaird C', 'Nauta A',
            'Pouwels S', 'Fritz J', 'Weggemans RM', 'Stopponi M', 'Pavelka I',
            'van Nassau F', 'van der Ploeg HP',
        ],
        'journal': 'Obesity Reviews',
        'doi': None,
        'pmid': 25952641,
        'pmcid': 'PMC4539438',
        'canonicalUrl': 'https://pmc.ncbi.nlm.nih.gov/articles/PMC4539438/',
        'accessedAt': '2026-10-10',
        'limitationsTr': 'Katkı etkisi düşük; diyet + direnç egzersizi eklenmediğinde daha büyük etki beklenir.',
        'limitationsEn': 'Effect is small without dietary co-intervention.',
        'conflictsTr': None,
        'conflictsEn': None,
        'diseaseSpecific': False,
    },
    {
        'id': 'walk-who-2020',
        'titleTr': 'DSÖ 2020 Fiziksel aktivite ve sedanter davranış rehberi',
        'titleEn': 'WHO 2020 Guidelines on Physical Activity and Sedentary Behaviour',
        'plainSummaryTr': (
            'DSÖ, yetişkinler için haftada en az 150-300 dk orta yoğunluk aerobik aktivite veya '
            '75-150 dk şiddetli aktivite önerir; tümü daha iyidir.'
        ),
        'plainSummaryEn': (
            'WHO recommends adults accumulate 150-300 min/week of moderate-intensity or 75-150 '
            'min/week of vigorous-intensity aerobic activity; more is better.'
        ),
        'claimTr': 'Düşük-orta etkiler: insülin direnci, kardiyovasküler risk, metabolik sağlık ve biliş için tutarlı iyileşme.',
        'claimEn': 'Larger volumes show consistent improvements in insulin sensitivity, cardiovascular risk, metabolic health, and cognition.',
        'evidenceLevel': 'E1',
        'evidenceLabelTr': 'DSÖ sistemik rehber',
        'evidenceLabelEn': 'WHO systematic guideline',
        'studyType': 'Sistemik derleme + meta-analiz',
        'population': 'Tüm yetişkinler (18-64 yaş) + yaşlılar (65+)',
        'sampleSize': None,
        'year': 2020,
        'authors': [
            'Bull FC', 'Al-Ansari SS', 'Biddle S', 'Borodulin K', 'Buman MP',
            'Carson G', 'Chaput JP', 'Chastin S', 'Chinapaw MJM', 'Donovan R',
            'Dugandzic T', 'Dunstan D', 'English C', 'Ferguson L', 'Forrest B',
            'Freeston J', 'Gine-Garriga M', 'Gonzalez-Suarez C', 'Guthold R',
            'Hammami N', 'Hart L', 'Inoue S', 'Janssen I', 'Kuriyan R', 'Lam FM',
            'Leblanc AG', 'Lee IM', 'Loyen A', 'Maddison R', 'Martinez-Lemos N',
            'Matsudo V', 'Meckenzie A', 'Murtagh EM', 'Naik S', 'Owen N', 'Pereira S',
            'Pesonen EJ', 'Piercy KL', 'Popkin BM', 'Rutter H', 'Salazar-Rojas W',
            'Salom-diaz JM', 'Sandoval-Puccini A', 'Stamatakis E', 'Teychenne M',
            'Thyfault JA', 'Troiano RP', 'Tudor-Locke C', 'van der Ploeg HP',
            'Vandelanotte C', 'Wanner M', 'Weggemans RM', 'Willumsen JF', 'Wood B',
            'Garcia-Hermoso A', 'Healy GN',
        ],
        'journal': 'British Journal of Sports Medicine',
        'doi': '10.1136/bjsports-2020-102955',
        'pmid': 33239350,
        'pmcid': 'PMC7719906',
        'canonicalUrl': 'https://doi.org/10.1136/bjsports-2020-102955',
        'accessedAt': '2026-10-10',
        'limitationsTr': 'Rehber, bireysel sağlık durumlarının yerine geçmez; gebelik ve çocuklarda doz-yanıt sınırlı.',
        'limitationsEn': 'Guideline is not a substitute for individual clinical assessment; dose-response in pregnancy and children is limited.',
        'conflictsTr': None,
        'conflictsEn': None,
        'diseaseSpecific': False,
    },
]

doc['sources'].extend(EXTRAS)
doc['changeLogTr'] = (doc.get('changeLogTr', '') +
                     ' | +3 yürüyüş kanıt kaynağı (ACSM 2011, Murtagh 2015, WHO 2020).').strip()
doc['changeLogEn'] = (doc.get('changeLogEn', '') +
                     ' | +3 walking evidence sources (ACSM 2011, Murtagh 2015, WHO 2020).').strip()
with open(P, 'w', encoding='utf-8') as f:
    json.dump(doc, f, ensure_ascii=False, indent=2)
print(f'Added {len(EXTRAS)} sources. Total: {len(doc["sources"])}')
