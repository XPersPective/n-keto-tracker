"""Vikipedi kaynağında fotoğrafı olmayan besin ve tariflere Wikidata görseli (P18) ekler.

Yalnızca credits.json içindeki 'missing' kayıtları işlenir; mevcut fotoğraflar
değişmez. Varlık seçimi: İngilizce Wikidata arama sonuçlarından, açıklaması
gıda/bitki/balık/peynir vb. anahtar kelimeleri içeren ve P18 görseli olan ilk
varlık. Lisans kuralları fetch_food_photos.py ile aynıdır (CC0, PD, CC BY,
CC BY-SA; GFDL/NC/ND reddedilir). Tarifler için ana malzeme anahtar kelimesi de
denenir.

    python tool/fetch_food_photos_wikidata.py
"""

import json
import os
import re
import sys
import time
import urllib.parse
import urllib.request

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fetch_food_photos as base  # noqa: E402

ROOT = base.ROOT
OUT_DIR = base.OUT_DIR
WD_API = 'https://www.wikidata.org/w/api.php'
PAUSE = 0.4

FOOD_WORDS = re.compile(
    r'food|fruit|vegetable|plant|fish|species|nut|seed|cheese|bread|meat|dish|drink|'
    r'beverage|spice|oil|grain|legume|bean|tuber|dairy|egg|sweet|cake|sauce|wine|tea|'
    r'coffee|herb|mushroom|berry|edible|cultivar|taxon|crop|cereal|yogurt|yoghurt|milk|'
    r'sausage|ham|cured|pasta|soup|pastry|snack|chip|juice|cabbage|squash|pepper|'
    r'onion|garlic|nut|flour|sugar|honey|vinegar|butter|cream',
    re.I,
)
EXCLUDE_DESC = re.compile(
    r'family name|given name|surname|district|village|town|city|municipality|album|film|'
    r'song|novel|painting|dataset|software|company|disease|bacteri|genus of bacteria|'
    r'person|politician|actor|musician|river|lake|mountain|asteroid|disambiguation|'
    r'rock|band|game|video|book|surname',
    re.I,
)

# Ana malzeme anahtar kelimeleri (tarif başlığında ilk eşleşen kullanılır).
INGREDIENT_HINTS = [
    'salmon', 'tuna', 'shrimp', 'fish', 'chicken', 'beef', 'lamb', 'egg', 'cheese',
    'yogurt', 'avocado', 'spinach', 'mushroom', 'walnut', 'almond', 'cauliflower',
    'zucchini', 'broccoli', 'meatball', 'pork', 'bread', 'soup', 'salad', 'omelette',
    'omelet', 'tomato', 'chia', 'olive', 'lentil',
]


def wd_get(params):
    url = WD_API + '?' + urllib.parse.urlencode(dict(params, format='json'))
    req = urllib.request.Request(url, headers={'User-Agent': base.UA})
    # Ağ zaman aşımında birkaç kez yeniden dene.
    for attempt in range(4):
        try:
            with urllib.request.urlopen(req, timeout=60) as r:
                return json.load(r)
        except Exception:
            if attempt == 3:
                return {}
            time.sleep(3 * (attempt + 1))


def candidates(query):
    """Açıklaması gıda ile ilgili ve P18 görseli olan Wikidata varlıkları."""
    res = wd_get({'action': 'wbsearchentities', 'search': query, 'language': 'en',
                  'type': 'item', 'limit': 8})
    ids = [h['id'] for h in res.get('search', [])]
    out = []
    for qid in ids:
        ent = wd_get({'action': 'wbgetentities', 'ids': qid, 'props': 'claims|descriptions',
                      'languages': 'en'})
        e = ent.get('entities', {}).get(qid, {})
        desc = (e.get('descriptions', {}).get('en', {}) or {}).get('value', '')
        if not desc or EXCLUDE_DESC.search(desc) or not FOOD_WORDS.search(desc):
            time.sleep(PAUSE)
            continue
        p18 = e.get('claims', {}).get('P18', [])
        if not p18:
            time.sleep(PAUSE)
            continue
        out.append(p18[0]['mainsnak']['datavalue']['value'])
        time.sleep(PAUSE)
        if len(out) >= 3:
            break
    return out


def pick_for(name, is_recipe):
    queries = []
    base_name = name.split(',')[0].strip()
    queries.append(base_name)
    if ' ' in base_name:
        queries.append(base_name.split(' ')[0])
    if is_recipe:
        low = name.lower()
        for hint in INGREDIENT_HINTS:
            if hint in low:
                queries.insert(0, hint)
                break
    seen = set()
    for q in queries:
        if q.lower() in seen:
            continue
        seen.add(q.lower())
        for fn in candidates(q):
            hit = base.commons_file(fn)
            if hit:
                hit['article'] = 'Wikidata:' + q
                return hit
        time.sleep(PAUSE)
    return None


def main():
    with open(os.path.join(OUT_DIR, 'credits.json'), encoding='utf-8') as f:
        data = json.load(f)
    items, missing = data['items'], list(data['missing'])
    with open(os.path.join(ROOT, 'assets', 'seed', 'foods.json'), encoding='utf-8') as f:
        names = {x['id']: (x.get('nameEn') or x['canonicalName']) for x in json.load(f)['foods']}
    with open(os.path.join(ROOT, 'assets', 'seed', 'recipes.json'), encoding='utf-8') as f:
        for r in json.load(f)['recipes']:
            names[r['id']] = r.get('titleEn') or r.get('titleTr') or r['id']

    still = []
    for n, item_id in enumerate(missing, 1):
        name = names.get(item_id, item_id)
        try:
            hit = pick_for(name, item_id.startswith('seed-recipe-'))
        except Exception as e:
            print('lookup error', item_id, e, flush=True)
            hit = None
        if not hit:
            still.append(item_id)
            print(f'[{n}/{len(missing)}] MISS {item_id} ({name})', flush=True)
            continue
        try:
            raw = base.fetch_image(hit['thumb'])
            base.to_webp(raw, os.path.join(OUT_DIR, item_id + '.webp'))
            items[item_id] = {k: hit[k] for k in ('title', 'article', 'author', 'license', 'page')}
            print(f'[{n}/{len(missing)}] ok {item_id} <- {hit["article"]} / {hit["title"]} ({hit["license"]})', flush=True)
        except Exception as e:
            still.append(item_id)
            print(f'[{n}/{len(missing)}] DL-ERR {item_id} {e}', flush=True)
        time.sleep(PAUSE)

    data['items'] = items
    data['missing'] = still
    with open(os.path.join(OUT_DIR, 'credits.json'), 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
    lines = ['# Görsel atıfları', '',
             "Besin ve tarif fotoğrafları Vikipedi makalelerinden ya da Wikidata'dan (Wikimedia Commons, açık lisans) alınmıştır.",
             'Görseller 480x360 olarak kırpılıp küçültülmüştür.', '']
    for item_id in sorted(items):
        c = items[item_id]
        title = c['title'].replace('File:', '', 1)
        lines.append(f'- `{item_id}`: [{title}]({c["page"]}) — {c["author"]}, {c["license"]} (kaynak: {c["article"]})')
    with open(os.path.join(OUT_DIR, 'CREDITS.md'), 'w', encoding='utf-8') as f:
        f.write('\n'.join(lines) + '\n')
    print('done: ok', len(items), 'missing', len(still), flush=True)


if __name__ == '__main__':
    main()
