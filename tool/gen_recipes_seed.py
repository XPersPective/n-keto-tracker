"""N Keto Tracker — seed tarif üreticisi (T19, MASTER §10.1).

Malzemeler foods.json'daki seed besin kimliklerine REFERANSLIDIR
(bağımsız besin verisi kopyalanmaz); porsiyon başı enerji/makrolar
malzemelerden hesaplanır. Porsiyon değişimi UI'da deterministik
ölçeklemeyle (scaleItem) yapılır.

Kullanım: python tool/gen_recipes_seed.py
"""

import json

# foods.json'daki id'ler: (food_id, grams)
R = [
    # 1 Menemen (ekmeksiz)
    ("menemen", "Menemen (ekmeksiz)", "Menemen (no bread)", "breakfast", 2,
     "Yumurtayı yağda pişirin; sebzeleri ekleyip karıştırın. Tuz ve "
     "karabiberle servis edin.",
     "Crack eggs into hot oil; add vegetables and stir until set. Season "
     "with salt and pepper.",
     ["süt ürünü/jumurta"], 15, "Buzdolabında 1 gün.",
     "Ekmek yerine yeşillik tabağıyla servis edin.",
     [("seed-egg", 150), ("seed-tomato", 100), ("seed-green-pepper", 50),
      ("seed-olive-oil", 10)]),
    # 2 Izgara somon + brokoli
    ("salmon-broccoli", "Izgara somon ve brokoli", "Grilled salmon with "
     "broccoli", "dinner", 2,
     "Somonu baharatlayıp ızgarada pişirin; buharda brokoliyi yanına alın.",
     "Season and grill the salmon; steam broccoli as a side.",
     ["balık"], 20, "Aynı gün tüketin.",
     "Limon ve zeytinyağı ile tatlandırın.",
     [("seed-salmon", 300), ("seed-broccoli", 200), ("seed-olive-oil", 10)]),
    # 3 Tavuk salata
    ("chicken-salad", "Tavuklu yeşil salata", "Chicken green salad",
     "lunch", 2,
     "Izgara tavuğu dilimleyin; yeşillikler ve zeytinyağıyla karıştırın.",
     "Slice grilled chicken; toss with greens and olive oil.",
     ["yumurta"], 25, "Sosuz buzdolabında 1 gün.",
     "Avokado ekleyebilirsiniz.",
     [("seed-chicken-breast", 250), ("seed-lettuce", 100),
      ("seed-cucumber", 100), ("seed-olive-oil", 15)]),
    # 4 Peynirli omlet
    ("cheese-omelette", "Peynirli omlet", "Cheese omelette", "breakfast", 1,
     "Yumurtaları çırpın; tavada pişirin; peyniri ekleyip katlayın.",
     "Whisk eggs; cook in a pan; add cheese and fold.",
     ["yumurta"], 10, "Aynı gün tüketin.",
     "Yeşil biber ekleyin.",
     [("seed-egg", 100), ("seed-white-cheese", 40), ("seed-butter", 8)]),
    # 5 Et sote
    ("beef-saute", "Et sote", "Beef sauté", "dinner", 3,
     "Etleri kendi suyunca pişirin; biber ve baharat ekleyin.",
     "Cook beef in its juices; add peppers and spices.",
     ["et"], 30, "Buzdolabında 2 gün.",
     "Kabak da ekleyebilirsiniz.",
     [("seed-beef-ground-lean", 400), ("seed-green-pepper", 100),
      ("seed-olive-oil", 15)]),
    # 6 Karnabahar püresi + köfte
    ("cauliflower-mash-meatballs", "Karnabahar püresi ve köfte",
     "Cauliflower mash with meatballs", "dinner", 2,
     "Karnabaharı haşlayıp ezip tereyağıyla püre yapın; köfteleri "
     "ayrı tavada pişirin.",
     "Boil and mash cauliflower with butter; pan-fry meatballs.",
     ["et"], 35, "Buzdolabında 2 gün.",
     "Püreye sarımsak ekleyin.",
     [("seed-cauliflower", 400), ("seed-butter", 20),
      ("seed-beef-ground-lean", 300)]),
    # 7 Yoğurtlu ceviz
    ("walnut-yogurt", "Cevizli süzme yoğurt", "Strained yogurt with "
     "walnuts", "snack", 1,
     "Yoğurdu kaseye alın; ceviz ve tarçınla süsleyin.",
     "Spoon yogurt into a bowl; top with walnuts.",
     ["süt ürünü"], 5, "Taze tüketin.",
     "Tatlılık için tarçıyin yeterli; bal EKLEMEYİN.",
     [("seed-greek-yogurt", 200), ("seed-walnut", 20)]),
    # 8 Tavuk çorbası (kremasız)
    ("chicken-soup", "Tavuk çorbası", "Chicken soup", "lunch", 4,
     "Kemik suyunu kaynatın; tavuk ve sebzeleri ekleyip 15 dk pişirin.",
     "Simmer broth; add chicken and vegetables, cook 15 min.",
     ["et"], 25, "Buzdolabında 3 gün.",
     "Yumurta ekleyerek proteinini artırın.",
     [("seed-bone-broth", 800), ("seed-chicken-breast", 200),
      ("seed-carrot", 50), ("seed-celeriac", 80)]),
    # 9 Avokado yumurta
    ("avocado-egg", "Avokadolu yumurta tabağı", "Avocado and egg plate",
     "breakfast", 1,
     "Avokadoyu dilimleyin; yanına haşlanmış yumurtaları alın.",
     "Slice avocado; serve with boiled eggs.",
     ["yumurta"], 15, "Taze tüketin.",
     "Üzerine pul biber.",
     [("seed-avocado", 100), ("seed-egg", 100)]),
    # 10 Fırın tavuk but + kabak
    ("baked-thigh-zucchini", "Fırın tavuk but ve kabak",
     "Baked chicken thigh with zucchini", "dinner", 2,
     "Hepsini tepsiye alıp zeytinyağı ve baharatla 200°C'de pişirin.",
     "Place everything in a tray with olive oil and spices; bake at 200°C.",
     ["tavuk"], 45, "Buzdolabında 2 gün.",
     "Kabakları büyük kesin.",
     [("seed-chicken-thigh", 300), ("seed-zucchini", 200),
      ("seed-olive-oil", 15)]),
    # 11 Ton balıklı salata
    ("tuna-salad", "Ton balıklı salata", "Tuna salad", "lunch", 2,
     "Tonu süzüp yeşilliklerle karıştırın; zeytinyağı ekleyin.",
     "Drain tuna; mix with greens and olive oil.",
     ["balık"], 10, "Taze tüketin.",
     "Zeytin ekleyin.",
     [("seed-tuna-canned", 150), ("seed-lettuce", 100),
      ("seed-tomato", 80), ("seed-olive-oil", 12)]),
    # 12 Peynir-ceviz tabağı
    ("cheese-walnut-plate", "Peynir ve ceviz tabağı",
     "Cheese and walnut plate", "snack", 1,
     "Peynirleri dilimleyip cevizle servis edin.",
     "Slice cheeses; serve with walnuts.",
     ["süt ürünü"], 5, "Taze tüketin.",
     "Zeytin de ekleyin.",
     [("seed-kasar-cheese", 60), ("seed-white-cheese", 50),
      ("seed-walnut", 20)]),
    # 13 Sebzeli omlet
    ("veggie-omelette", "Sebzeli omlet", "Vegetable omelette", "breakfast",
     1,
     "Sebzeleri soteleyin; çırpılmış yumurtayı ekleyip pişirin.",
     "Sauté vegetables; pour whisked eggs and cook.",
     ["yumurta"], 15, "Aynı gün tüketin.",
     "Mantar da olur.",
     [("seed-egg", 100), ("seed-spinach", 50), ("seed-mushroom", 60),
      ("seed-olive-oil", 10)]),
    # 14 Karides tavası
    ("shrimp-pan", "Karides tavası", "Shrimp pan", "dinner", 2,
     "Karidesi tereyağında sarımsakla pişirin.",
     "Cook shrimp in butter with garlic.",
     ["deniz ürünü"], 15, "Aynı gün tüketin.",
     "Limon sıkın.",
     [("seed-shrimp", 250), ("seed-butter", 15),
      ("seed-garlic", 5)]),
    # 15 Kuzu fırın + mevsim yeşillik
    ("baked-lamb", "Kuzu but (fırın) ve yeşillik",
     "Roasted lamb leg with greens", "dinner", 4,
     "Kuzuyu baharatlayıp 180°C'de pişirin; yeşillikle servis edin.",
     "Season lamb; roast at 180°C; serve with greens.",
     ["et"], 90, "Buzdolabında 2 gün.",
     "Pişme süresi ağırlığa göre değişir.",
     [("seed-lamb-leg-roast", 600), ("seed-arugula", 80),
      ("seed-olive-oil", 15)]),
    # 16 Badem unlu ekmek
    ("almond-bread", "Badem unlu ekmek", "Almond flour bread", "breakfast",
     8,
     "Malzemeleri karıştırıp kalıpta 180°C'de 30 dk pişirin.",
     "Mix ingredients; bake in a loaf pan at 180°C for 30 min.",
     ["yumurta, kuruyemiş"], 35, "Dilimleyip dondurun.",
     "Tost makinesinde ısıtın.",
     [("seed-almond-flour", 200), ("seed-egg", 150),
      ("seed-butter", 30)]),
    # 17 Mantarlı tavuk
    ("chicken-mushroom", "Mantarlı tavuk sote", "Chicken with mushrooms",
     "lunch", 2,
     "Tavuğu soteleyin; mantarı ekleyip suyunu çekene dek pişirin.",
     "Sauté chicken; add mushrooms and cook until dry.",
     ["tavuk"], 25, "Buzdolabında 2 gün.",
     "Krema ekleyebilirsiniz.",
     [("seed-chicken-breast", 250), ("seed-mushroom", 150),
      ("seed-olive-oil", 12)]),
    # 18 Ispanaklı yumurta
    ("spinach-eggs", "Ispanaklı yumurta", "Eggs with spinach",
     "breakfast", 1,
     "Ispanağı soteleyin; üzerine yumurta kırıp pişirin.",
     "Sauté spinach; crack eggs on top and cook.",
     ["yumurta"], 12, "Aynı gün tüketin.",
     "Peynir serpin.",
     [("seed-spinach", 150), ("seed-egg", 100), ("seed-olive-oil", 10)]),
    # 19 Somon salata
    ("salmon-salad", "Somon salata", "Salmon salad", "lunch", 2,
     "Pişmiş somonu yeşilliklerle karıştırın.",
     "Flake cooked salmon over greens.",
     ["balık"], 15, "Taze tüketin.",
     "Avokado ekleyin.",
     [("seed-salmon", 200), ("seed-lettuce", 80),
      ("seed-avocado", 50), ("seed-olive-oil", 10)]),
    # 20 Mercimek yerine: brokoli çorbası
    ("broccoli-soup", "Brokoli çorbası", "Broccoli soup", "lunch", 3,
     "Brokoli ve soğanı kemik suyunda yumuşayana dek pişirin; blenderdan "
     "geçirin.",
     "Simmer broccoli and onion in broth until soft; blend.",
     ["sebze"], 20, "Buzdolabında 3 gün.",
     "Krema ile servis edin.",
     [("seed-broccoli", 400), ("seed-onion", 80),
      ("seed-bone-broth", 600), ("seed-heavy-cream", 50)]),
]


def main():
    foods = json.load(
        open("assets/seed/foods.json", encoding="utf-8"))["foods"]
    food_by_id = {f["id"]: f for f in foods}

    recipes = []
    for (slug, tr, en, meal, servings, steps_tr, steps_en, allergens,
         minutes, storage_tr, storage_en, items) in R:
        kcal = protein = fat = carb = fiber = 0.0
        for food_id, grams in items:
            f = food_by_id.get(food_id)
            assert f is not None, f"food_id yok: {food_id}"
            kcal += f["kcalPer100g"] * grams / 100
            protein += f["proteinGPer100g"] * grams / 100
            fat += f["fatGPer100g"] * grams / 100
            carb += f["carbohydrateTotalGPer100g"] * grams / 100
            fiber += f["fiberGPer100g"] * grams / 100
        net_carb = max(0.0, carb - fiber)
        r = round(servings) or 1
        recipes.append({
            "id": f"seed-recipe-{slug}",
            "titleTr": tr,
            "titleEn": en,
            "mealType": meal,
            "servings": r,
            "prepMinutes": minutes,
            "allergens": allergens,
            "stepsTr": steps_tr,
            "stepsEn": steps_en,
            "storageTr": storage_tr,
            "storageEn": storage_en,
            "netCarbMethodNote": (
                "Net karbonhidrat = toplam karbonhidrat - lif; malzeme "
                "değerleri foods.json kaynaklı, porsiyona göre ölçeklenir."
            ),
            "perServing": {
                "kcal": round(kcal / r, 1),
                "proteinG": round(protein / r, 1),
                "fatG": round(fat / r, 1),
                "carbohydrateTotalG": round(carb / r, 1),
                "fiberG": round(fiber / r, 1),
                "netCarbG": round(net_carb / r, 1),
            },
            "ingredients": [
                {"foodId": fid, "grams": g} for fid, g in items
            ],
            "isUserCreated": False,
            "contentVersion": "recipe-seed-v1.0",
        })
    doc = {
        "$comment": (
            "N Keto Tracker seed tarifleri. Malzemeler foods.json "
            "kayitlarina referanslidir; porsiyon basi degerler "
            "malzemelerden hesaplandi (netCarb = max(0, total - fiber))."
        ),
        "contentVersion": "recipe-seed-v1.0",
        "releasedAt": "2026-09-20",
        "count": len(recipes),
        "recipes": recipes,
    }
    out = "assets/seed/recipes.json"
    with open(out, "w", encoding="utf-8", newline="\n") as f:
        f.write(json.dumps(doc, ensure_ascii=False, indent=2) + "\n")
    print(f"yazıldı: {out} — {len(recipes)} tarif")


if __name__ == "__main__":
    main()
