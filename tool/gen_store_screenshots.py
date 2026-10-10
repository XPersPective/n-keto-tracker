#!/usr/bin/env python3
"""Mağaza ekran görüntülerini üretmek için mcode-tools generate_image
çağrısının JSON argümanını yazar. Ardından aynı JSON ile mcode-tools
çağrılır. 6 ekran görüntüsü: Bugün, Ölçüm, Günlük, Kanıt, Plan, Rehber.
"""
import json
import os
import subprocess
import sys
import time

OUTPUT_DIR = os.path.join(
    os.path.dirname(os.path.abspath(__file__)),
    '..', 'docs', 'marketing', 'screenshots'
)
os.makedirs(OUTPUT_DIR, exist_ok=True)

REQUESTS = [
    {
        'aspect_ratio': '9:16',
        'output_file': 'nketo-screen-1-today',
        'resolution': '1K',
        'prompt': (
            'Smartphone mockup screenshot of a keto tracking app home '
            'screen. The app is named "N Keto Tracker". A dark teal hero '
            'card at the top shows a large GKI metric reading "GKI 2.0" '
            'with mmol/L values. Below it four rounded quick-action tiles '
            'labeled "Add measurement", "Add meal", "Add weight", '
            '"Add symptom" with small icons. Bottom shows a medical '
            'disclaimer. Clean, minimal Material Design 3, light theme, '
            'premium look, no brand watermark, no UI chrome.'
        ),
    },
    {
        'aspect_ratio': '9:16',
        'output_file': 'nketo-screen-2-measurement',
        'resolution': '1K',
        'prompt': (
            'Smartphone mockup screenshot of a keto app measurement '
            'session form. Two text fields labeled "Glucose (mg/dL)" with '
            'value 90 and "Blood ketone BHB (mmol/L)" with value 2.5. A '
            'primary blue "Save measurement session" button. Clean '
            'Material Design 3 form, premium look, no brand watermark.'
        ),
    },
    {
        'aspect_ratio': '9:16',
        'output_file': 'nketo-screen-3-log',
        'resolution': '1K',
        'prompt': (
            'Smartphone mockup screenshot of a keto app daily log '
            'timeline view. A vertical list of cards showing glucose and '
            'BHB measurement entries with GKI 2.0, 5.0 mmol/L, gki-v1 '
            'labels. Honest "this is not an effect statement" footnote. '
            'Light theme, clean Material Design 3, no brand watermark.'
        ),
    },
    {
        'aspect_ratio': '9:16',
        'output_file': 'nketo-screen-4-evidence',
        'resolution': '1K',
        'prompt': (
            'Smartphone mockup screenshot of a keto app evidence '
            'section. A list of cards with cited sources for keto diet. '
            'Each card has a small "Copy link" icon. Filters at the top. '
            'Light theme, clean Material Design 3, premium look, no '
            'brand watermark.'
        ),
    },
    {
        'aspect_ratio': '9:16',
        'output_file': 'nketo-screen-5-plan',
        'resolution': '1K',
        'prompt': (
            'Smartphone mockup screenshot of a keto app weekly meal plan '
            'and shopping list. Day cards titled "Day 1", "Day 2" etc '
            'with recipe names like "Cheese omelette" and "Grilled '
            'salmon". A floating action button to add. Light theme, clean '
            'Material Design 3, no brand watermark.'
        ),
    },
    {
        'aspect_ratio': '9:16',
        'output_file': 'nketo-screen-6-guide',
        'resolution': '1K',
        'prompt': (
            'Smartphone mockup screenshot of a keto app beginner guide '
            'with three groups "Basics", "Macros", "Common mistakes". '
            'Each group has 2-3 cards with short text. Light theme, clean '
            'Material Design 3, premium look, no brand watermark.'
        ),
    },
]


def main():
    args_file = os.path.join(os.environ.get('TEMP', '/tmp'),
                              'gen_args_py.json')
    with open(args_file, 'w', encoding='utf-8') as f:
        json.dump({'requests': REQUESTS}, f, ensure_ascii=False)
    print(f'Wrote {args_file}')
    cmd = [r'C:\Users\rubicon\.minimax\bin\mcode-tools.cmd', 'connector', 'call',
           'connector__matrix__generate_image', f'--args-file={args_file}']
    print('Running:', ' '.join(cmd))
    proc = subprocess.run(cmd, capture_output=True, text=True, timeout=600)
    print('STDOUT:')
    print(proc.stdout)
    if proc.stderr:
        print('STDERR:')
        print(proc.stderr)
    sys.exit(proc.returncode)


if __name__ == '__main__':
    main()
