"""N Keto Tracker — gıda rehberi seed içeriği üreticisi (T17, MASTER §9).

Üç grup; ahlaki/korkutucu dil yasak; her kartta Neden? + kanıt etiketi
(E6 genel eğitim) + alternatifler. Tipik porsiyon/net karb değerleri
foods.json'dan besin kimliğiyle bağlanır (ui katmanı birleştirir).

Kullanım: python tool/gen_food_guide_seed.py
"""

import json

# (slug, group, reasonTr, reasonEn, alternatives, portionTr, portionEn, grams)
# group: prefer | limit | avoid  (MASTER §9 üç grup; yargı dili yok)
CARDS = [
    ("prefer-meat-fish-eggs", "prefer",
     "Protein ve doğal yağ sağlar; karbonhidratı çok düşüktür. Porsiyon "
     "çeşitliliği besin örüntüsünü dengeler.",
     "Provides protein and natural fat with very low carbohydrate. Varying "
     "portions helps balance your overall food pattern.",
     "bitkisel protein çeşitleri", "plant protein options",
     "porsiyon", "portion", 150),
    ("prefer-low-carb-vegetables", "prefer",
     "Lif, vitamin ve hacim sağlar; net karbonhidratı düşüktür.",
     "Provides fiber, vitamins, and volume with low net carbs.",
     "mevsim sebzeleri", "seasonal vegetables",
     "porsiyon", "portion", 150),
    ("prefer-fats-oils", "prefer",
     "Ketojenik hedeflerde enerjinin önemli bölümü yağlardan gelir; "
     "porsiyon ölçüsü kalori dengesi için belirleyicidir.",
     "In ketogenic patterns most energy comes from fat; measured portions "
     "matter for energy balance.",
     "zeytinyağı, tereyağı, avokado", "olive oil, butter, avocado",
     "yemek kaşığı", "tablespoon", 14),
    ("prefer-nuts-seeds", "prefer",
     "Yağ, protein ve lif dengesi iyidir; karbonhidrat türe göre değişir.",
     "Good balance of fat, protein, and fiber; carbs vary by type.",
     "badem, ceviz, fındık", "almonds, walnuts, hazelnuts",
     "avuç", "handful", 30),
    ("prefer-berries", "limit",
     "Meyveler içinde net karbonhidratı en düşük gruptadır; porsiyon "
     "küçük tutulduğunda ketojenik hedefe sıklıkla uyabilir.",
     "Among fruits these have the lowest net carbs; small portions often "
     "fit ketogenic targets.",
     "avokado, zeytin", "avocado, olives",
     "küçük porsiyon", "small portion", 100),
    ("prefer-dairy-full-fat", "limit",
     "Yağ ve protein iyi; laktoz nedeniyle karbonhidrat sıfır değildir. "
     "Porsiyon büyüdükçe birikir.",
     "Good fat and protein; lactose means carbs are not zero and add up "
     "with larger portions.",
     "süzme yoğurt, sert peynirler", "strained yogurt, hard cheeses",
     "porsiyon", "portion", 100),
    ("limit-fruit", "limit",
     "Doğal şeker içerir; net karbonhidrat porsiyonla hızlı birikir. "
     "Yasak değildir; miktar belirleyicidir.",
     "Contains natural sugars; net carbs add up quickly with portion. "
     "Not forbidden — amount is what matters.",
     "çilek, ahududu gibi düşük karbonhidratlı meyveler",
     "lower-carb fruit such as berries",
     "adet", "piece", 120),
    ("limit-legumes", "limit",
     "Protein ve lif değerlidir; karbonhidratı yüksektir. Küçük porsiyon "
     "bazı hedeflere sığabilir.",
     "Valuable protein and fiber, but high in carbs; small portions may "
     "still fit some targets.",
     "et, balık, yumurta", "meat, fish, eggs",
     "küçük porsiyon", "small portion", 100),
    ("limit-milk-drinks", "limit",
     "Laktoz doğal şekerdir; sıvı biçimde porsiyon kontrolü zordur.",
     "Lactose is a natural sugar; liquid portions are easy to overpour.",
     "süzme yoğurt, ayran (küçük), krema", "strained yogurt, small ayran, cream",
     "bardak", "glass", 200),
    ("avoid-sugary-drinks", "avoid",
     "Sıvı şeker hızlı ve yoğun karbonhidrat sağlar; küçük miktarda bile "
     "günlük karbonhidrat hedefini aşmayı kolaylaştırır.",
     "Liquid sugar delivers fast, dense carbohydrate; even small amounts "
     "can easily exceed a daily carb target.",
     "şekersiz çay/kahve, su, buz gibi su", "unsweetened tea/coffee, water",
     "kutu", "can", 330),
    ("avoid-starches", "avoid",
     "Ekmek, pirinç ve patates sindirimde büyük ölçüde glukoza dönüşen "
     "nişasta içerir; porsiyon küçültmek bile bazı ketojenik hedefler için "
     "yeterli olmayabilir.",
     "Bread, rice, and potato are mostly starch that digests to glucose; "
     "even small portions may exceed some ketogenic targets.",
     "karnabahar pilavı, badem unu ekmekleri", "cauliflower rice, almond-flour breads",
     "porsiyon", "portion", 150),
    ("avoid-sweets", "avoid",
     "Yoğun şeker/nişasta içerir; ketojenik hedefle genellikle uyumsuzdur. "
     "Tadında ısrar varsa porsiyon-kontrol edilmiş bitter çikolata "
     "(%85+) alternatif olabilir.",
     "Dense in sugar/starch; generally incompatible with ketogenic targets. "
     "If sweetness matters, portion-controlled 85%+ dark chocolate is an "
     "alternative.",
     "%85+ bitter çikolata (küçük kare)", "85%+ dark chocolate (small square)",
     "porsiyon", "portion", 60),
]

# grubun kapsadığı besin kategorileri/örnekleri (ui eşlemesi için örnek id'ler)
GROUP_COVERAGE = {
    "prefer": [
        "seed-beef-steak-sirloin", "seed-salmon", "seed-egg",
        "seed-spinach", "seed-avocado", "seed-olive-oil", "seed-almond",
    ],
    "limit": [
        "seed-strawberry", "seed-greek-yogurt", "seed-whole-milk",
        "seed-chickpea-cooked", "seed-apple",
    ],
    "avoid": [
        "seed-cola", "seed-white-bread", "seed-rice-white-cooked",
        "seed-potato-boiled", "seed-honey", "seed-table-sugar",
        "seed-baklava", "seed-milk-chocolate", "seed-potato-chips",
    ],
}


def main():
    cards = []
    for (slug, group, tr, en, alt_tr, alt_en, p_tr, p_en, grams) in CARDS:
        cards.append({
            "id": f"guide-{slug}",
            "group": group,
            "reasonTr": tr,
            "reasonEn": en,
            "alternativesTr": alt_tr,
            "alternativesEn": alt_en,
            "portionTr": p_tr,
            "portionEn": p_en,
            "typicalGrams": grams,
            # Tüm kartlar E6 genel eğitimdir (MASTER §2.1): klinik sonuç
            # iddiası içermez.
            "evidenceLevel": "E6",
            "evidenceLabelTr": "Genel eğitim",
            "evidenceLabelEn": "General information",
            "exampleFoodIds": GROUP_COVERAGE[group],
        })
    doc = {
        "$comment": (
            "N Keto Tracker gida rehberi seed. Uc grup (MASTER 9): prefer "
            "= genellikle tercih edilebilir, limit = porsiyon/siklik "
            "sinirli olabilir, avoid = ketojenik hedefle genellikle "
            "uyumsuz. Ahlaki/korkutucu dil yasak (icerik lint testi var)."
        ),
        "contentVersion": "food-guide-v1.0",
        "releasedAt": "2026-09-20",
        "cards": cards,
    }
    out = "assets/seed/food_guide.json"
    with open(out, "w", encoding="utf-8", newline="\n") as f:
        f.write(json.dumps(doc, ensure_ascii=False, indent=2) + "\n")
    print(f"yazıldı: {out} — {len(cards)} kart")


if __name__ == "__main__":
    main()
