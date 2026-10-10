#!/usr/bin/env python3
"""6 temel mağaza ekran görüntüsünün üstüne her dil için yerelleştirilmiş
başlık bandı basar. Çıktı: docs/marketing/screenshots/<code>/screen-N-*.jpg.

408 görsel (6 × 68) otomatik üretilir; her Play Store girişinde dil
başına 6 görsel kullanılabilir.
"""
import os
import re
from PIL import Image, ImageDraw, ImageFont

ROOT = os.path.dirname(os.path.abspath(__file__))
SCREEN_DIR = os.path.join(ROOT, '..', 'docs', 'marketing', 'screenshots')

# 6 temel görsel (generate_image ile üretildi)
BASES = [
    ('screen-1-today', 'today'),
    ('screen-2-measurement', 'measurement'),
    ('screen-3-log', 'log'),
    ('screen-4-evidence', 'evidence'),
    ('screen-5-plan', 'plan'),
    ('screen-6-guide', 'guide'),
]

# Mağaza listelerinden tagline çıkar (68 dil)
LISTING_DIR = os.path.join(ROOT, '..', 'docs', 'marketing')
TAGLINE = {}
for f in sorted(os.listdir(LISTING_DIR)):
    if not f.startswith('STORE_LISTING_') or not f.endswith('.md'):
        continue
    code = f.removeprefix('STORE_LISTING_').removesuffix('.md').lower()
    with open(os.path.join(LISTING_DIR, f), 'r', encoding='utf-8') as fh:
        text = fh.read()
    m = re.search(r'\*\*Subtitle \(≤30\):\*\* (.+)', text)
    if m:
        TAGLINE[code] = m.group(1).strip()
    else:
        TAGLINE[code] = 'Keto Journal & GKI Tracker'
TAGLINE['en'] = 'Keto Journal & GKI Tracker'
TAGLINE['tr'] = 'Keto Günlüğü ve GKI Takibi'


def find_font_for(text: str) -> str:
    """Karakter setine göre font dene. Windows sistem fontları."""
    candidates = []
    if re.search(r'[\u4e00-\u9fff\u3040-\u30ff\u3400-\u4dbf]', text):
        # CJK
        candidates = [
            'C:/Windows/Fonts/msyh.ttc',
            'C:/Windows/Fonts/msyh.ttf',
            'C:/Windows/Fonts/simhei.ttf',
            'C:/Windows/Fonts/simsun.ttc',
            'C:/Windows/Fonts/msgothic.ttc',
        ]
    elif re.search(r'[\u0600-\u06ff]', text):
        # Arabic
        candidates = [
            'C:/Windows/Fonts/arabtype.ttf',
            'C:/Windows/Fonts/seguiemj.ttf',
        ]
    elif re.search(r'[\u0590-\u05ff]', text):
        # Hebrew
        candidates = [
            'C:/Windows/Fonts/seguiemj.ttf',
        ]
    elif re.search(r'[\u0900-\u097f]', text):
        # Devanagari
        candidates = [
            'C:/Windows/Fonts/mangal.ttf',
        ]
    elif re.search(r'[\u0e00-\u0e7f]', text):
        # Thai
        candidates = [
            'C:/Windows/Fonts/arial.ttf',
        ]
    candidates += [
        'C:/Windows/Fonts/segoeui.ttf',
        'C:/Windows/Fonts/arial.ttf',
        'C:/Windows/Fonts/calibri.ttf',
    ]
    for c in candidates:
        if os.path.isfile(c):
            return c
    return None


def draw_overlay(base_path: str, out_path: str, app: str, tagline: str):
    img = Image.open(base_path).convert('RGBA')
    w, h = img.size
    band_h = 200
    # Şerit: yarı saydam siyah arka plan + beyaz metin
    band = Image.new('RGBA', (w, band_h), (15, 30, 45, 230))
    d = ImageDraw.Draw(band)
    font_path = find_font_for(tagline + app)
    try:
        title_font = ImageFont.truetype(font_path, 56) if font_path else ImageFont.load_default()
        sub_font = ImageFont.truetype(font_path, 36) if font_path else ImageFont.load_default()
    except Exception:
        title_font = ImageFont.load_default()
        sub_font = ImageFont.load_default()
    # Ortala
    def centered(text, y, font, fill=(255, 255, 255, 255)):
        bbox = d.textbbox((0, 0), text, font=font)
        tw = bbox[2] - bbox[0]
        d.text(((w - tw) / 2, y), text, font=font, fill=fill)
    centered(f'N  {app}', 50, title_font)
    centered(tagline, 125, sub_font)
    img.paste(band, (0, 0), band)
    img.convert('RGB').save(out_path, 'JPEG', quality=90)


def main():
    total = 0
    for code, tagline in TAGLINE.items():
        out_dir = os.path.join(SCREEN_DIR, code)
        os.makedirs(out_dir, exist_ok=True)
        for base_name, _ in BASES:
            src = os.path.join(SCREEN_DIR, f'nketo-{base_name}.jpg')
            dst = os.path.join(out_dir, f'nketo-{base_name}.jpg')
            if not os.path.isfile(src):
                print(f'MISSING base: {src}')
                continue
            draw_overlay(src, dst, 'Keto Tracker', tagline)
            total += 1
    print(f'Generated {total} localized screenshots in {len(TAGLINE)} dirs')


if __name__ == '__main__':
    main()
