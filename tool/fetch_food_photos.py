"""Besin ve tarif fotoğraflarını İngilizce Vikipedi makale görselinden alır.

Kaynak: her besinin İngilizce Vikipedi makalesinin başlık görseli (pageimages),
dosya Wikimedia Commons'ta olmalı ve açık lisanslı olmalı. Kabul edilen lisanslar:
CC0, Public domain, CC BY, CC BY-SA (sürüm ne olursa olsun). GFDL, NC ve ND reddedilir.
Çizim, harita, logo, bayrak gibi dosyalar reddedilir.

Uygun görsel bulunamayan besinde dosya üretilmez; uygulama o besinde kategori
ikonu gösterir. Tarifler için aynı kural uygulanır.

Çıktı:
  assets/food_images/<id>.webp            480x360, kırpılmış
  assets/food_images/credits.json         kaynak, yazar, lisans (ve eksikler)
  assets/food_images/CREDITS.md           insan okunur atıf listesi

    python tool/fetch_food_photos.py            # hepsi
    python tool/fetch_food_photos.py --limit 5  # test

Ağ kullanır; uygulama çalışma zamanında ağa çıkmaz (C-001).
"""

import argparse
import io
import json
import os
import re
import time
import urllib.parse
import urllib.request

from PIL import Image

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
OUT_DIR = os.path.join(ROOT, 'assets', 'food_images')
UA = 'NKetoTracker-assets/1.0 (https://github.com/XPersPective/n-keto-tracker)'
WP_API = 'https://en.wikipedia.org/w/api.php'
CM_API = 'https://commons.wikimedia.org/w/api.php'
SIZE = (480, 360)
PAUSE = 0.4

# Elle verilen Vikipedi makale başlıkları (id -> başlık). Otomatik başlık
# tutmazsa buraya eklenir.
OVERRIDES = {}

BAD_FILE = re.compile(
    r'illustrat|drawing|painting|engrav|etching|woodcut|map|logo|flag|coat|'
    r'diagram|chart|icon|svg|signature|stamp|coin|poster|book|page|scan|'
    r'figure|plate|sketch|lithograph|museum|still.?life',
    re.I,
)


def api_get(api, params):
    url = api + '?' + urllib.parse.urlencode(dict(params, format='json'))
    req = urllib.request.Request(url, headers={'User-Agent': UA})
    with urllib.request.urlopen(req, timeout=40) as r:
        return json.load(r)


def license_ok(short):
    s = (short or '').strip()
    low = s.lower()
    if not low:
        return None
    if low.startswith('cc0'):
        return 'CC0'
    if 'public domain' in low or low.startswith('pd'):
        return 'Public domain'
    if 'nc' in low or '-nd' in low or ' nd' in low or 'gfdl' in low or 'fdl' in low:
        return None
    if low.startswith('cc by'):
        return s
    return None


def strip_html(s):
    return re.sub(r'<[^>]+>', '', s or '').strip()


def lead_image(title):
    """Vikipedi makalesinin başlık görselinin dosya adı (yoksa None)."""
    d = api_get(WP_API, {
        'action': 'query', 'prop': 'pageimages', 'piprop': 'name',
        'titles': title, 'redirects': 1,
    })
    for p in (d.get('query') or {}).get('pages', {}).values():
        if 'pageimage' in p:
            return p['pageimage']
    return None


def commons_file(filename):
    """Commons dosyasının (lisans, yazar, küçük görsel URL'si) bilgisi."""
    d = api_get(CM_API, {
        'action': 'query', 'titles': 'File:' + filename, 'prop': 'imageinfo',
        'iiprop': 'url|extmetadata|size|mime', 'iiurlwidth': 960,
    })
    for p in (d.get('query') or {}).get('pages', {}).values():
        if 'missing' in p or 'imageinfo' not in p:
            return None
        ii = p['imageinfo'][0]
        em = ii.get('extmetadata', {})
        lic = license_ok(em.get('LicenseShortName', {}).get('value'))
        if not lic:
            return None
        if ii.get('mime', '') not in ('image/jpeg', 'image/png'):
            return None
        if ii.get('width', 0) < 800 or ii.get('thumburl') is None:
            return None
        ratio = ii['width'] / ii['height']
        if not (0.6 <= ratio <= 2.0):
            return None
        if BAD_FILE.search(filename):
            return None
        return {
            'title': 'File:' + filename,
            'thumb': ii['thumburl'],
            'page': ii.get('descriptionurl', ''),
            'author': strip_html(em.get('Artist', {}).get('value', '')) or 'unknown',
            'license': lic,
        }
    return None


def article_titles(item_id, name):
    if item_id in OVERRIDES:
        return [OVERRIDES[item_id]]
    base = name.split(',')[0].strip()
    base = re.sub(r'\s*\(.*?\)\s*', ' ', base).strip()
    base = re.sub(r'\s+', ' ', base)
    cands = [base, base.rstrip('s')]
    if ' ' in base:
        cands.append(base.split(' ')[-1])
    out, seen = [], set()
    for c in cands:
        if c and c.lower() not in seen:
            seen.add(c.lower())
            out.append(c)
    return out


def find_photo(item_id, name):
    for title in article_titles(item_id, name):
        try:
            fn = lead_image(title)
        except Exception as e:  # ağ hatasında sonraki başlığa geç
            print('wp error', item_id, title, e, flush=True)
            fn = None
        time.sleep(PAUSE)
        if not fn:
            continue
        try:
            hit = commons_file(fn)
        except Exception as e:
            print('commons error', item_id, fn, e, flush=True)
            hit = None
        time.sleep(PAUSE)
        if hit:
            hit['article'] = title
            return hit
    return None


def fetch_image(url):
    req = urllib.request.Request(url, headers={'User-Agent': UA})
    with urllib.request.urlopen(req, timeout=60) as r:
        return r.read()


def to_webp(raw, out_path):
    img = Image.open(io.BytesIO(raw)).convert('RGB')
    w, h = img.size
    target = SIZE[0] / SIZE[1]
    if w / h > target:  # fazla geniş: yandan kırp
        nw = int(h * target)
        x0 = (w - nw) // 2
        img = img.crop((x0, 0, x0 + nw, h))
    else:
        nh = int(w / target)
        y0 = (h - nh) // 2
        img = img.crop((0, y0, w, y0 + nh))
    img = img.resize(SIZE, Image.LANCZOS)
    img.save(out_path, 'WEBP', quality=80, method=6)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--limit', type=int, default=0)
    args = ap.parse_args()
    os.makedirs(OUT_DIR, exist_ok=True)

    with open(os.path.join(ROOT, 'assets', 'seed', 'foods.json'), encoding='utf-8') as f:
        foods = json.load(f)['foods']
    with open(os.path.join(ROOT, 'assets', 'seed', 'recipes.json'), encoding='utf-8') as f:
        recipes = json.load(f)['recipes']

    jobs = []
    for f in foods:
        jobs.append((f['id'], f.get('nameEn') or f['canonicalName']))
    for r in recipes:
        jobs.append((r['id'], r.get('titleEn') or r.get('titleTr') or r['id']))
    if args.limit:
        jobs = jobs[:args.limit]

    credits, missing = {}, []
    for n, (item_id, name) in enumerate(jobs, 1):
        hit = find_photo(item_id, name)
        if not hit:
            missing.append(item_id)
            print(f'[{n}/{len(jobs)}] MISS {item_id} ({name})', flush=True)
            continue
        try:
            raw = fetch_image(hit['thumb'])
            to_webp(raw, os.path.join(OUT_DIR, item_id + '.webp'))
            credits[item_id] = {k: hit[k] for k in ('title', 'article', 'author', 'license', 'page')}
            print(f'[{n}/{len(jobs)}] ok {item_id} <- {hit["article"]} / {hit["title"]} ({hit["license"]})', flush=True)
        except Exception as e:
            missing.append(item_id)
            print(f'[{n}/{len(jobs)}] DL-ERR {item_id} {e}', flush=True)
        time.sleep(PAUSE)

    with open(os.path.join(OUT_DIR, 'credits.json'), 'w', encoding='utf-8') as f:
        json.dump({'items': credits, 'missing': missing}, f, ensure_ascii=False, indent=2)
    lines = ['# Görsel atıfları', '',
             "Besin ve tarif fotoğrafları İngilizce Vikipedi makalelerinin başlık görselleridir (Wikimedia Commons, açık lisans).",
             'Görseller 480x360 olarak kırpılıp küçültülmüştür.', '']
    for item_id in sorted(credits):
        c = credits[item_id]
        title = c['title'].replace('File:', '', 1)
        lines.append(f'- `{item_id}`: [{title}]({c["page"]}) — {c["author"]}, {c["license"]}')
    with open(os.path.join(OUT_DIR, 'CREDITS.md'), 'w', encoding='utf-8') as f:
        f.write('\n'.join(lines) + '\n')
    print('done: ok', len(credits), 'missing', len(missing), flush=True)


if __name__ == '__main__':
    main()
