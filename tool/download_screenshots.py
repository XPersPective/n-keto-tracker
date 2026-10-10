#!/usr/bin/env python3
"""Üretilen 6 mağaza ekran görüntüsünü node_id'den URL alıp docs/marketing/
screenshots/ altına indirir.
"""
import json
import os
import subprocess
import sys

OUTPUT_DIR = os.path.join(
    os.path.dirname(os.path.abspath(__file__)),
    '..', 'docs', 'marketing', 'screenshots'
)
os.makedirs(OUTPUT_DIR, exist_ok=True)

MCODE = r'C:\Users\rubicon\.minimax\bin\mcode-tools.cmd'

NODES = [
    ('450747102412896', 'nketo-screen-1-today.jpg'),
    ('450748224929949', 'nketo-screen-2-measurement.jpg'),
    ('450746010558767', 'nketo-screen-3-log.jpg'),
    ('450748839788614', 'nketo-screen-4-evidence.jpg'),
    ('450748834447432', 'nketo-screen-5-plan.jpg'),
    ('450748224929953', 'nketo-screen-6-guide.jpg'),
]


def get_url(node_id: str) -> str:
    proc = subprocess.run(
        [MCODE, 'get_asset_url', node_id],
        capture_output=True, text=True, timeout=60,
    )
    if proc.returncode != 0:
        raise RuntimeError(f'get_asset_url failed: {proc.stderr}')
    return json.loads(proc.stdout)['download_url']


def main():
    for node_id, name in NODES:
        url = get_url(node_id)
        target = os.path.join(OUTPUT_DIR, name)
        # PowerShell Invoke-WebRequest
        ps = (
            f"Invoke-WebRequest -Uri '{url}' -OutFile '{target}'"
        )
        proc = subprocess.run(
            ['powershell', '-NoProfile', '-Command', ps],
            capture_output=True, text=True, timeout=120,
        )
        if proc.returncode != 0:
            print(f'FAIL {name}: {proc.stderr}')
            continue
        size = os.path.getsize(target)
        print(f'OK {name} ({size} bytes)')


if __name__ == '__main__':
    main()
