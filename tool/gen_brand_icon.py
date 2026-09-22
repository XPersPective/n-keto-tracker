"""N Keto Tracker marka kaynağı ikonu üretici (T27).

Tasarım (ORTAK §4; MASTER §22.4): sakin arka plan, tek vurgu rengi;
neon/alev/şimşek/beyin/hastane imgesi YOK. Motif: koyu deniz mavisi
zemin üzerinde sade beyaz 'N' glifi ve altında ince bir keton çizgisi
(yatay, yumuşak). Tamamen özgün, dış varlık içermez.

Kullanım: python tool/gen_brand_icon.py
"""

from PIL import Image, ImageDraw, ImageFont

SIZE = 1024
BG = (10, 61, 102, 255)        # #0A3D66 koyu deniz mavisi
FG = (245, 250, 252, 255)      # #F5FAFC kırık beyaz
ACCENT = (0, 150, 136, 255)    # #009688 teal (uygulama tohum rengiyle uyumlu)


def rounded_rect(draw, box, radius, fill):
    draw.rounded_rectangle(box, radius=radius, fill=fill)


def main() -> None:
    img = Image.new("RGBA", (SIZE, SIZE), BG)
    draw = ImageDraw.Draw(img)

    # Merkez 'N' glifi: kalın, geometrik (font bağımsız çizim).
    # Sütunlar: sol dikey, çapraz, sağ dikey.
    bar_w = 92
    glyph_top = 250
    glyph_bottom = 700
    left_x = 330
    right_x = 610

    # Sol dikey çubuk
    draw.rectangle(
        [left_x, glyph_top, left_x + bar_w, glyph_bottom], fill=FG
    )
    # Sağ dikey çubuk
    draw.rectangle(
        [right_x, glyph_top, right_x + bar_w, glyph_bottom], fill=FG
    )
    # Çapraz (sol üstten sağ alta)
    draw.polygon(
        [
            (left_x, glyph_bottom),
            (left_x, glyph_top + 140),
            (right_x + bar_w, glyph_bottom - 140),
            (right_x + bar_w, glyph_bottom),
        ],
        fill=FG,
    )

    # Alt ince keton çizgisi: yumuşak dalga (tek vurgu rengi).
    line_y = 800
    pts = []
    for x in range(280, 745, 5):
        import math
        y = line_y + int(18 * math.sin((x - 280) / 60))
        pts.append((x, y))
    draw.line(pts, fill=ACCENT, width=14, joint="curve")

    img.save("assets/brand/brand_icon_1024.png")
    print("yazıldı: assets/brand/brand_icon_1024.png")


if __name__ == "__main__":
    main()
