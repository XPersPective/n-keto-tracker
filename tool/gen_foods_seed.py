"""N Keto Tracker — seed besin veri seti üreticisi (T15).

Kaynak: USDA FoodData Central (SR Legacy / Foundation Foods) yayımlı
referans değerlerinden derleme; ABD kamu malı (17 USC §105). Atkı
(adil kullanım nezaketi): "U.S. Department of Agriculture, FoodData
Central" — bkz. docs/FOOD_DATA_PROVENANCE.md.

Çıktı: assets/seed/foods.json
Kural: netCarb = max(0, totalCarb − fiber); şeker alkolü otomatik
çıkarılmaz (MASTER_PROMPT §8.1).

Kullanım: python tool/gen_foods_seed.py
"""

import json

# (slug, name_tr, name_en, category, kcal, protein, fat, carb, fiber,
#  serving_tr, serving_en, serving_grams)
# Değerler: 100 g başına, USDA SR Legacy referans tablolarından derleme.
FOODS = [
    # ── Et, tavuk, balık ──────────────────────────────────────────────
    ("beef-ground-fatty", "Yağlı dana kıyma", "Beef, ground, ~20% fat", "meat", 254, 17.2, 20.0, 0.0, 0.0, "porsiyon", "portion", 150),
    ("beef-ground-lean", "Yağsız dana kıyma", "Beef, ground, ~5% fat", "meat", 137, 21.4, 5.3, 0.0, 0.0, "porsiyon", "portion", 150),
    ("beef-steak-sirloin", "Dana bonfile/sirloin", "Beef, sirloin steak", "meat", 206, 29.9, 8.7, 0.0, 0.0, "porsiyon", "portion", 200),
    ("lamb-chop", "Kuzu pirzola", "Lamb, chop", "meat", 282, 24.3, 20.1, 0.0, 0.0, "porsiyon", "portion", 150),
    ("lamb-leg-roast", "Kuzu but (fırın)", "Lamb, leg, roasted", "meat", 234, 27.6, 12.9, 0.0, 0.0, "porsiyon", "portion", 150),
    ("chicken-breast", "Tavuk göğsü (ızgara)", "Chicken, breast, grilled", "poultry", 165, 31.0, 3.6, 0.0, 0.0, "porsiyon", "portion", 150),
    ("chicken-thigh", "Tavuk but ( derisiz)", "Chicken, thigh, skinless", "poultry", 209, 26.0, 10.9, 0.0, 0.0, "porsiyon", "portion", 150),
    ("chicken-thigh-skin", "Tavuk but (derili)", "Chicken, thigh, skin on", "poultry", 245, 24.7, 15.8, 0.0, 0.0, "porsiyon", "portion", 150),
    ("turkey-breast", "Hindi göğsü", "Turkey, breast", "poultry", 135, 30.1, 1.0, 0.0, 0.0, "porsiyon", "portion", 150),
    ("salmon", "Somon", "Salmon, Atlantic", "fish", 208, 20.4, 13.4, 0.0, 0.0, "fileto", "fillet", 150),
    ("sardine", "Sardalya", "Sardines, canned in oil", "fish", 208, 24.6, 11.5, 0.0, 0.0, "kutu", "can", 90),
    ("anchovy", "Hamsi", "Anchovy, raw", "fish", 131, 20.1, 4.8, 0.0, 0.0, "porsiyon", "portion", 120),
    ("sea-bass", "Levrek", "Sea bass, raw", "fish", 124, 23.6, 2.6, 0.0, 0.0, "porsiyon", "portion", 180),
    ("sea-bream", "Çupra", "Sea bream, raw", "fish", 118, 22.2, 2.7, 0.0, 0.0, "porsiyon", "portion", 180),
    ("mackerel", "Uskumru", "Mackerel, raw", "fish", 205, 18.6, 13.9, 0.0, 0.0, "porsiyon", "portion", 150),
    ("trout", "Alabalık", "Trout, rainbow", "fish", 168, 20.8, 8.7, 0.0, 0.0, "porsiyon", "portion", 150),
    ("tuna-canned", "Konserve ton balığı (suda)", "Tuna, canned in water", "fish", 116, 25.5, 0.8, 0.0, 0.0, "kutu", "can", 100),
    ("shrimp", "Karides", "Shrimp, cooked", "fish", 99, 24.0, 0.3, 0.2, 0.0, "porsiyon", "portion", 120),
    ("mussel", "Midye", "Mussels, cooked", "fish", 172, 23.8, 4.5, 7.4, 0.0, "porsiyon", "portion", 120),
    ("beef-liver", "Dana ciğeri", "Beef liver", "meat", 175, 26.5, 5.1, 5.1, 0.0, "porsiyon", "portion", 120),
    ("sucuk", "Sucuk", "Turkish beef sausage (sucuk)", "meat", 460, 19.0, 41.0, 2.0, 0.0, "dilim", "slice", 30),
    ("pastirma", "Pastırma", "Turkish cured beef (pastirma)", "meat", 210, 38.0, 6.0, 1.0, 0.0, "dilim", "slice", 20),
    # ── Yumurta ve süt ürünleri ───────────────────────────────────────
    ("egg", "Yumurta (bütün)", "Egg, whole", "dairy", 143, 12.6, 9.5, 0.7, 0.0, "adet (~50 g)", "piece (~50 g)", 50),
    ("egg-white", "Yumurta akı", "Egg white", "dairy", 52, 10.9, 0.2, 0.7, 0.0, "adet (~33 g)", "piece (~33 g)", 33),
    ("egg-yolk", "Yumurta sarısı", "Egg yolk", "dairy", 322, 15.9, 26.5, 3.6, 0.0, "adet (~17 g)", "piece (~17 g)", 17),
    ("white-cheese", "Beyaz peynir", "White brined cheese (feta-type)", "dairy", 264, 14.2, 21.3, 4.1, 0.0, "dilim", "slice", 40),
    ("kasar-cheese", "Kaşar peyniri", "Kashar cheese", "dairy", 375, 24.0, 30.0, 3.0, 0.0, "dilim", "slice", 30),
    ("cheddar", "Cheddar peyniri", "Cheddar cheese", "dairy", 403, 24.9, 33.1, 1.3, 0.0, "dilim", "slice", 30),
    ("parmesan", "Parmesan", "Parmesan, grated", "dairy", 431, 37.8, 28.6, 4.1, 0.0, "yemek kaşığı", "tablespoon", 10),
    ("mozzarella", "Mozzarella", "Mozzarella, whole milk", "dairy", 300, 22.2, 22.4, 2.2, 0.0, "porsiyon", "portion", 50),
    ("tulum-cheese", "Tulum peyniri", "Tulum cheese", "dairy", 345, 22.0, 27.5, 2.5, 0.0, "dilim", "slice", 40),
    ("greek-yogurt", "Süzme yoğurt (~%10 yağ)", "Strained yogurt (~10% fat)", "dairy", 130, 7.0, 8.5, 4.5, 0.0, "kase", "cup", 200),
    ("yogurt-whole", "Yoğurt (tam yağlı)", "Yogurt, whole milk", "dairy", 61, 3.5, 3.3, 4.7, 0.0, "kase", "cup", 200),
    ("ayran", "Ayran", "Ayran (yogurt drink)", "dairy", 37, 1.9, 1.9, 3.0, 0.0, "bardak", "glass", 200),
    ("whole-milk", "Tam yağlı süt", "Milk, whole", "dairy", 61, 3.2, 3.3, 4.8, 0.0, "bardak", "glass", 200),
    ("heavy-cream", "Kaymak/krema (%35)", "Heavy cream (~35% fat)", "dairy", 340, 2.1, 36.0, 2.8, 0.0, "yemek kaşığı", "tablespoon", 15),
    ("kaymak", "Kaymak (süt)", "Clotted cream (kaymak)", "dairy", 580, 2.0, 62.0, 3.5, 0.0, "tatlı kaşığı", "teaspoon", 10),
    ("butter", "Tereyağı", "Butter", "dairy", 717, 0.9, 81.1, 0.1, 0.0, "yemek kaşığı", "tablespoon", 14),
    # ── Yağlar ve kuruyemiş ───────────────────────────────────────────
    ("olive-oil", "Zeytinyağı", "Olive oil", "fats", 884, 0.0, 100.0, 0.0, 0.0, "yemek kaşığı", "tablespoon", 14),
    ("coconut-oil", "Hindistan cevizi yağı", "Coconut oil", "fats", 862, 0.0, 100.0, 0.0, 0.0, "yemek kaşığı", "tablespoon", 14),
    ("sunflower-oil", "Ayçiçek yağı", "Sunflower oil", "fats", 884, 0.0, 100.0, 0.0, 0.0, "yemek kaşığı", "tablespoon", 14),
    ("olives-green", "Yeşil zeytin", "Olives, green", "fats", 145, 1.0, 15.3, 3.9, 3.3, "adet", "piece", 4),
    ("olives-black", "Siyah zeytin", "Olives, black", "fats", 115, 0.8, 10.7, 6.3, 3.2, "adet", "piece", 4),
    ("almond", "Badem", "Almonds", "nuts", 579, 21.2, 49.9, 21.6, 12.5, "avuç", "handful", 30),
    ("walnut", "Ceviz", "Walnuts", "nuts", 654, 15.2, 65.2, 13.7, 6.7, "avuç", "handful", 30),
    ("hazelnut", "Fındık", "Hazelnuts", "nuts", 628, 15.0, 60.8, 16.7, 9.7, "avuç", "handful", 30),
    ("pistachio", "Antep fıstığı", "Pistachios", "nuts", 560, 20.2, 45.3, 27.2, 10.6, "avuç", "handful", 30),
    ("peanut", "Yer fıstığı", "Peanuts", "nuts", 567, 25.8, 49.2, 16.1, 8.5, "avuç", "handful", 30),
    ("cashew", "Kaju", "Cashews", "nuts", 553, 18.2, 43.9, 30.2, 3.3, "avuç", "handful", 30),
    ("sunflower-seed", "Ay çekirdeği", "Sunflower seeds", "nuts", 584, 20.8, 51.5, 20.0, 8.6, "avuç", "handful", 30),
    ("pumpkin-seed", "Kabak çekirdeği", "Pumpkin seeds", "nuts", 559, 30.2, 49.1, 10.7, 6.0, "avuç", "handful", 30),
    ("peanut-butter", "Fıstık ezmesi", "Peanut butter", "nuts", 588, 25.1, 50.4, 19.6, 6.0, "yemek kaşığı", "tablespoon", 16),
    ("tahini", "Tahin", "Tahini (sesame paste)", "nuts", 595, 17.0, 53.8, 21.2, 9.3, "yemek kaşığı", "tablespoon", 15),
    ("chia", "Chia tohumu", "Chia seeds", "nuts", 486, 16.5, 30.7, 42.1, 34.4, "yemek kaşığı", "tablespoon", 12),
    ("flaxseed", "Keten tohumu", "Flaxseed", "nuts", 534, 18.3, 42.2, 28.9, 27.3, "yemek kaşığı", "tablespoon", 10),
    # ── Sebzeler ──────────────────────────────────────────────────────
    ("spinach", "Ispanak", "Spinach", "vegetable", 23, 2.9, 0.4, 3.6, 2.2, "porsiyon", "portion", 150),
    ("kale", "Kara lahana (pazı)", "Kale/collards", "vegetable", 35, 2.9, 1.5, 4.4, 4.1, "porsiyon", "portion", 150),
    ("lettuce", "Marul", "Lettuce, romaine", "vegetable", 17, 1.2, 0.3, 3.3, 2.1, "porsiyon", "portion", 100),
    ("arugula", "Roka", "Arugula", "vegetable", 25, 2.6, 0.7, 3.7, 1.6, "porsiyon", "portion", 80),
    ("parsley", "Maydanoz", "Parsley", "vegetable", 36, 3.0, 0.8, 6.3, 3.3, "demet", "bunch", 60),
    ("dill", "Dereotu", "Dill", "vegetable", 43, 3.5, 1.1, 7.0, 2.1, "demet", "bunch", 40),
    ("cucumber", "Salatalık", "Cucumber", "vegetable", 15, 0.7, 0.1, 3.6, 0.5, "adet", "piece", 150),
    ("tomato", "Domates", "Tomato", "vegetable", 18, 0.9, 0.2, 3.9, 1.2, "adet", "piece", 120),
    ("green-pepper", "Yeşil biber", "Pepper, green", "vegetable", 20, 0.9, 0.2, 4.6, 1.7, "adet", "piece", 100),
    ("eggplant", "Patlıcan", "Eggplant", "vegetable", 25, 1.0, 0.2, 5.9, 3.0, "adet", "piece", 200),
    ("zucchini", "Kabak", "Zucchini", "vegetable", 17, 1.2, 0.3, 3.1, 1.0, "adet", "piece", 200),
    ("cauliflower", "Karnabahar", "Cauliflower", "vegetable", 25, 1.9, 0.3, 5.0, 2.0, "porsiyon", "portion", 150),
    ("broccoli", "Brokoli", "Broccoli", "vegetable", 34, 2.8, 0.4, 6.6, 2.6, "porsiyon", "portion", 150),
    ("cabbage", "Beyaz lahana", "Cabbage, white", "vegetable", 25, 1.3, 0.1, 5.8, 2.5, "porsiyon", "portion", 150),
    ("green-beans", "Yeşil fasulye", "Green beans", "vegetable", 31, 1.8, 0.2, 7.0, 2.7, "porsiyon", "portion", 150),
    ("okra", "Bamya", "Okra", "vegetable", 33, 1.9, 0.2, 7.5, 3.2, "porsiyon", "portion", 150),
    ("mushroom", "Mantar (beyaz)", "Mushroom, white", "vegetable", 22, 3.1, 0.3, 3.3, 1.0, "porsiyon", "portion", 100),
    ("onion", "Soğan", "Onion", "vegetable", 40, 1.1, 0.1, 9.3, 1.7, "adet", "piece", 110),
    ("garlic", "Sarımsak", "Garlic", "vegetable", 149, 6.4, 0.5, 33.1, 2.1, "diş", "clove", 3),
    ("leek", "Pırasa", "Leek", "vegetable", 61, 1.5, 0.3, 14.2, 1.8, "adet", "piece", 150),
    ("carrot", "Havuç", "Carrot", "vegetable", 41, 0.9, 0.2, 9.6, 2.8, "adet", "piece", 80),
    ("pumpkin-veg", "Balkabağı", "Pumpkin", "vegetable", 26, 1.0, 0.1, 6.5, 0.5, "porsiyon", "portion", 150),
    ("beetroot", "Pancar", "Beetroot", "vegetable", 43, 1.6, 0.2, 9.6, 2.8, "adet", "piece", 100),
    ("avocado", "Avokado", "Avocado", "vegetable", 160, 2.0, 14.7, 8.5, 6.7, "adet (yarım)", "piece (half)", 100),
    ("olive-veg", "Zeytin (yeşil, sofra)", "Table olives, green", "vegetable", 145, 1.0, 15.3, 3.9, 3.3, "adet", "piece", 4),
    ("asparagus", "Kuşkonmaz", "Asparagus", "vegetable", 20, 2.2, 0.1, 3.9, 2.1, "porsiyon", "portion", 120),
    ("celeriac", "Kereviz", "Celeriac/celery root", "vegetable", 42, 1.5, 0.3, 9.2, 1.8, "adet", "piece", 200),
    ("spring-onion", "Taze soğan", "Spring onion", "vegetable", 32, 1.8, 0.2, 7.3, 2.6, "demet", "bunch", 50),
    # ── Meyveler ──────────────────────────────────────────────────────
    ("strawberry", "Çilek", "Strawberry", "fruit", 32, 0.7, 0.3, 7.7, 2.0, "porsiyon", "portion", 150),
    ("raspberry", "Ahududu", "Raspberry", "fruit", 52, 1.2, 0.7, 11.9, 6.5, "porsiyon", "portion", 120),
    ("blackberry", "Böğürtlen", "Blackberry", "fruit", 43, 1.4, 0.5, 9.6, 5.3, "porsiyon", "portion", 120),
    ("blueberry", "Yaban mersini", "Blueberry", "fruit", 57, 0.7, 0.3, 14.5, 2.4, "porsiyon", "portion", 120),
    ("lemon", "Limon", "Lemon", "fruit", 29, 1.1, 0.3, 9.3, 2.8, "adet", "piece", 60),
    ("orange", "Portakal", "Orange", "fruit", 47, 0.9, 0.1, 11.8, 2.4, "adet", "piece", 140),
    ("apple", "Elma", "Apple", "fruit", 52, 0.3, 0.2, 13.8, 2.4, "adet", "piece", 150),
    ("pear", "Armut", "Pear", "fruit", 57, 0.4, 0.1, 15.2, 3.1, "adet", "piece", 160),
    ("grapes", "Üzüm", "Grapes", "fruit", 69, 0.7, 0.2, 18.1, 0.9, "salkım", "bunch", 100),
    ("banana", "Muz", "Banana", "fruit", 89, 1.1, 0.3, 22.8, 2.6, "adet", "piece", 120),
    ("watermelon", "Karpuz", "Watermelon", "fruit", 30, 0.6, 0.2, 7.6, 0.4, "dilim", "slice", 200),
    ("melon", "Kavun", "Melon", "fruit", 34, 0.8, 0.2, 8.2, 0.9, "dilim", "slice", 200),
    ("peach", "Şeftali", "Peach", "fruit", 39, 0.9, 0.3, 9.5, 1.5, "adet", "piece", 130),
    ("apricot", "Kayısı", "Apricot", "fruit", 48, 1.4, 0.4, 11.1, 2.0, "adet", "piece", 60),
    ("fig", "İncir", "Fig", "fruit", 74, 0.8, 0.3, 19.2, 2.9, "adet", "piece", 50),
    ("pomegranate", "Nar", "Pomegranate", "fruit", 83, 1.7, 1.2, 18.7, 4.0, "adet", "piece", 200),
    ("dates", "Hurma (kuru)", "Dates, dried", "fruit", 282, 2.5, 0.4, 75.0, 6.7, "adet", "piece", 8),
    ("raisins", "Kuru üzüm", "Raisins", "fruit", 299, 3.1, 0.5, 79.2, 3.7, "yemek kaşığı", "tablespoon", 15),
    ("dried-apricot", "Kuru kayısı", "Apricots, dried", "fruit", 241, 3.4, 0.5, 63.9, 7.3, "adet", "piece", 7),
    ("dried-fig", "Kuru incir", "Figs, dried", "fruit", 249, 3.3, 1.0, 63.9, 9.8, "adet", "piece", 20),
    # ── Baklagil, tahıl, ekmek ────────────────────────────────────────
    ("chickpea-cooked", "Nohut (haşlanmış)", "Chickpeas, cooked", "legume", 164, 8.9, 2.6, 27.4, 7.6, "porsiyon", "portion", 150),
    ("lentil-cooked", "Mercimek (haşlanmış)", "Lentils, cooked", "legume", 116, 9.0, 0.4, 20.1, 7.9, "porsiyon", "portion", 150),
    ("kidney-bean-cooked", "Kuru fasulye (haşlanmış)", "Kidney beans, cooked", "legume", 127, 8.7, 0.5, 22.8, 6.4, "porsiyon", "portion", 150),
    ("white-bread", "Beyaz ekmek", "Bread, white", "grain", 265, 9.0, 3.2, 49.0, 2.7, "dilim", "slice", 25),
    ("whole-wheat-bread", "Tam buğday ekmeği", "Bread, whole wheat", "grain", 247, 13.0, 3.4, 41.0, 7.0, "dilim", "slice", 25),
    ("simit", "Simit", "Simit (sesame bread ring)", "grain", 310, 9.5, 4.5, 58.0, 2.5, "adet", "piece", 100),
    ("bulgur-cooked", "Bulgur (pilav)", "Bulgur, cooked", "grain", 83, 3.1, 0.2, 18.6, 4.5, "porsiyon", "portion", 150),
    ("rice-white-cooked", "Pirinç pilavı (beyaz)", "Rice, white, cooked", "grain", 130, 2.7, 0.3, 28.2, 0.4, "porsiyon", "portion", 150),
    ("pasta-cooked", "Makarna (haşlanmış)", "Pasta, cooked", "grain", 131, 5.0, 1.1, 25.1, 1.8, "porsiyon", "portion", 150),
    ("couscous-cooked", "Kuskus (haşlanmış)", "Couscous, cooked", "grain", 112, 3.8, 0.2, 23.2, 1.4, "porsiyon", "portion", 150),
    ("oatmeal-dry", "Yulaf ezmesi (kuru)", "Oats, dry", "grain", 389, 16.9, 6.9, 66.3, 10.6, "yemek kaşığı", "tablespoon", 12),
    ("corn", "Mısır (haşlanmış)", "Corn, cooked", "grain", 96, 3.4, 1.5, 20.9, 2.4, "adet", "piece", 90),
    ("potato-boiled", "Patates (haşlanmış)", "Potato, boiled", "tuber", 87, 1.9, 0.1, 20.1, 1.8, "adet", "piece", 150),
    ("sweet-potato", "Tatlı patates", "Sweet potato", "tuber", 90, 2.0, 0.2, 20.7, 3.3, "adet", "piece", 130),
    # ── İçecekler ve tatlılar ─────────────────────────────────────────
    ("turkish-coffee", "Türk kahvesi (şekersiz)", "Turkish coffee, unsweetened", "beverage", 2, 0.1, 0.0, 0.4, 0.0, "fincan", "cup", 70),
    ("black-tea", "Çay (şekersiz)", "Black tea, unsweetened", "beverage", 1, 0.0, 0.0, 0.3, 0.0, "bardak", "glass", 200),
    ("cola", "Kola", "Cola", "beverage", 41, 0.0, 0.0, 10.6, 0.0, "kutu", "can", 330),
    ("orange-juice", "Portakal suyu", "Orange juice", "beverage", 45, 0.7, 0.2, 10.4, 0.2, "bardak", "glass", 200),
    ("honey", "Bal", "Honey", "sweet", 304, 0.3, 0.0, 82.4, 0.2, "tatlı kaşığı", "teaspoon", 7),
    ("table-sugar", "Toz şeker", "Sugar, white", "sweet", 387, 0.0, 0.0, 100.0, 0.0, "tatlı kaşığı", "teaspoon", 4),
    ("milk-chocolate", "Sütlü çikolata", "Chocolate, milk", "sweet", 535, 7.6, 29.7, 59.4, 3.4, "kare", "square", 10),
    ("dark-chocolate-85", "Bitter çikolata (%85)", "Dark chocolate, 85%", "sweet", 592, 9.8, 46.0, 30.0, 11.0, "kare", "square", 10),
    ("baklava", "Baklava", "Baklava", "sweet", 428, 5.9, 23.9, 50.0, 1.9, "dilim", "slice", 60),
    ("potato-chips", "Cips (patates)", "Potato chips", "snack", 536, 7.0, 34.0, 52.0, 4.4, "paket (küçük)", "pack (small)", 40),
    ("popcorn", "Patlamış mısır", "Popcorn, plain", "snack", 387, 12.9, 4.5, 77.8, 14.5, "kase", "bowl", 25),
    # ── Hazır/karışık keto-uyumlu ─────────────────────────────────────
    ("menemen-no-bread", "Menemen (ekmeksiz)", "Menemen (no bread)", "prepared", 118, 5.8, 9.5, 3.2, 1.0, "porsiyon", "portion", 250),
    ("grilled-meatball", "Izgara köfte", "Grilled meatballs", "prepared", 240, 18.5, 17.2, 2.1, 0.3, "adet", "piece", 40),
    ("cauliflower-rice", "Karnabahar pilavı", "Cauliflower rice", "prepared", 40, 2.3, 1.2, 5.4, 2.4, "porsiyon", "portion", 150),
    ("bone-broth", "Kemik suyu/et suyu", "Bone broth", "prepared", 12, 1.8, 0.4, 0.4, 0.0, "kase", "cup", 240),
    ("tzatziki", "Cacık", "Tzatziki", "prepared", 55, 2.6, 3.2, 3.8, 0.4, "kase", "cup", 150),
    ("humus", "Humus", "Hummus", "prepared", 166, 7.9, 9.6, 14.3, 6.0, "yemek kaşığı", "tablespoon", 30),
    ("mayonnaise", "Mayonez", "Mayonnaise", "fats", 680, 1.0, 75.0, 1.5, 0.0, "yemek kaşığı", "tablespoon", 14),
    ("mustard", "Hardal", "Mustard", "fats", 66, 4.4, 3.3, 5.8, 3.3, "tatlı kaşığı", "teaspoon", 5),
    ("apple-cider-vinegar", "Elma sirkesi", "Apple cider vinegar", "beverage", 21, 0.0, 0.0, 0.9, 0.0, "yemek kaşığı", "tablespoon", 15),
    ("protein-powder-whey", "Whey protein tozu", "Whey protein powder", "prepared", 380, 80.0, 5.0, 6.0, 0.5, "ölçek (~30 g)", "scoop (~30 g)", 30),
    ("kefir", "Kefir (tam yağlı)", "Kefir, whole milk", "dairy", 60, 3.3, 3.5, 4.3, 0.0, "bardak", "glass", 200),
    ("labneh", "Labne peyniri", "Labneh (strained cheese)", "dairy", 250, 9.0, 22.0, 3.5, 0.0, "yemek kaşığı", "tablespoon", 25),
    ("gouda", "Gouda peyniri", "Gouda cheese", "dairy", 356, 24.9, 27.4, 2.2, 0.0, "dilim", "slice", 30),
    ("camembert", "Camembert", "Camembert cheese", "dairy", 300, 19.8, 24.3, 0.5, 0.0, "porsiyon", "portion", 40),
    ("beef-salami", "Salam/salami (dana)", "Beef salami", "meat", 336, 20.8, 27.1, 1.9, 0.0, "dilim", "slice", 20),
    ("chicken-shish", "Tavuk şiş (ızgara)", "Chicken shish, grilled", "prepared", 150, 27.0, 4.0, 1.0, 0.1, "şiş", "skewer", 120),
    ("red-lentil-soup", "Mercimek çorbası", "Red lentil soup", "prepared", 82, 4.6, 2.1, 11.5, 2.5, "kase", "cup", 250),
    ("calamari-fried", "Kalamar tava", "Fried calamari", "fish", 175, 15.4, 7.5, 10.8, 0.4, "porsiyon", "portion", 120),
    ("psyllium", "Psyllium husk", "Psyllium husk", "nuts", 200, 2.0, 0.5, 88.0, 80.0, "tatlı kaşığı", "teaspoon", 5),
    ("almond-flour", "Badem unu", "Almond flour", "nuts", 571, 21.4, 50.0, 21.0, 10.9, "yemek kaşığı", "tablespoon", 10),
    ("coconut-flour", "Hindistan cevizi unu", "Coconut flour", "nuts", 443, 17.0, 14.0, 60.0, 38.5, "yemek kaşığı", "tablespoon", 8),
    ("tomato-paste", "Domates salçası", "Tomato paste", "vegetable", 82, 4.3, 0.5, 17.0, 4.1, "yemek kaşığı", "tablespoon", 15),
    ("pickles", "Turşu (salatalık)", "Pickles, cucumber", "vegetable", 12, 0.3, 0.2, 2.3, 1.2, "adet", "piece", 60),
    ("cabbage-pickle", "Lahana turşusu", "Sauerkraut/pickled cabbage", "vegetable", 19, 0.9, 0.1, 4.3, 2.9, "porsiyon", "portion", 100),
]


def build():
    foods = []
    seen = set()
    for row in FOODS:
        (slug, tr, en, cat, kcal, protein, fat, carb, fiber,
         s_tr, s_en, s_grams) = row
        assert slug not in seen, f"tekrar: {slug}"
        seen.add(slug)
        net_carb = max(0.0, round(carb - fiber, 2))
        foods.append({
            "id": f"seed-{slug}",
            "canonicalName": en,
            "nameTr": tr,
            "nameEn": en,
            "category": cat,
            "servingOptions": [
                {"labelTr": s_tr, "labelEn": s_en, "grams": s_grams,
                 "default": True},
                {"labelTr": "100 g", "labelEn": "100 g", "grams": 100,
                 "default": False},
            ],
            "kcalPer100g": kcal,
            "proteinGPer100g": protein,
            "fatGPer100g": fat,
            "carbohydrateTotalGPer100g": carb,
            "fiberGPer100g": fiber,
            "netCarbGPer100g": net_carb,
            "dataSource": "USDA FoodData Central (SR Legacy reference values)",
            "sourceVersion": "food-seed-v1.0 (2026-09-20)",
            "sourceRecordId": f"FDC-SR-transcribed:{slug}",
            "license": "Public domain (U.S. Government work, USDA); courtesy attribution requested",
            "lastReviewedAt": "2026-09-20",
            "isUserCreated": False,
            "notes": "",
        })
    return foods


def main():
    foods = build()
    doc = {
        "$comment": (
            "N Keto Tracker seed besin veri seti. Provenance: "
            "docs/FOOD_DATA_PROVENANCE.md. netCarb = max(0, totalCarb - "
            "fiber); seker alkolu cikarilmaz. Kaynak: USDA FoodData Central, "
            "kamu malı."
        ),
        "contentVersion": "food-seed-v1.0",
        "releasedAt": "2026-09-20",
        "count": len(foods),
        "foods": foods,
    }
    out = "assets/seed/foods.json"
    with open(out, "w", encoding="utf-8", newline="\n") as f:
        f.write(json.dumps(doc, ensure_ascii=False, indent=2) + "\n")
    print(f"yazıldı: {out} — {len(foods)} besin")


if __name__ == "__main__":
    main()
