"""Capture the existing store screenshot harness on a hosted iOS simulator."""

import argparse
import json
from pathlib import Path
import re
import struct
import subprocess


DEVICES = {
    "iphone": (r"^iPhone .+ Pro Max$", {(1320, 2868), (1290, 2796), (1260, 2736)}),
    "ipad": (
        r"^iPad Pro \(?13-inch\)?",
        {(2064, 2752), (2048, 2732)},
    ),
}
SCREENS = {"1_today", "2_gki", "3_log", "4_trends", "5_plan"}
LANGUAGES = ("en", "tr")


def simctl(*args, **kwargs):
    return subprocess.run(["xcrun", "simctl", *args], check=True, **kwargs)


def select_device(family):
    data = json.loads(simctl("list", "-j", "devices", "available", capture_output=True).stdout)
    simulators = [
        (tuple(map(int, re.findall(r"\d+", runtime.rsplit(".iOS-", 1)[1]))), device)
        for runtime, devices in data["devices"].items()
        if ".iOS-" in runtime
        for device in devices
        if re.search(DEVICES[family][0], device["name"])
    ]
    if not simulators:
        raise RuntimeError(f"No suitable {family} simulator is installed")
    return max(simulators, key=lambda entry: (entry[0], entry[1]["name"]))[1]


def screenshot(udid, path, family):
    path.parent.mkdir(parents=True, exist_ok=True)
    simctl("io", udid, "screenshot", str(path))
    with path.open("rb") as image:
        header = image.read(24)
    if header[:8] != b"\x89PNG\r\n\x1a\n" or header[12:16] != b"IHDR":
        raise RuntimeError(f"Unexpected screenshot format: {path}")
    dimensions = struct.unpack(">II", header[16:24])
    if dimensions not in DEVICES[family][1]:
        raise RuntimeError(f"Unexpected {family} screenshot dimensions: {dimensions}")


def capture(family, output):
    device = select_device(family)
    udid = device["udid"]
    print(f"Capturing {device['name']} ({udid})", flush=True)
    if device["state"] != "Booted":
        simctl("boot", udid)
    simctl("bootstatus", udid, "-b")
    expected = {(language, screen) for language in LANGUAGES for screen in SCREENS}
    captured = set()
    command = [
        "flutter", "drive", "--no-pub", "--no-publish-port", "-d", udid,
        "--driver=test_driver/integration_test.dart",
        "--target=integration_test/store_screenshots_test.dart",
        "--dart-define=SHOT_LOCALES=" + ",".join(LANGUAGES),
    ]
    with subprocess.Popen(
        command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, bufsize=1,
    ) as driver:
        for line in driver.stdout:
            print(line, end="", flush=True)
            marker = re.search(r"SHOTREADY ([a-z]+)/([a-z\d_]+)", line)
            if marker:
                language, screen = marker.groups()
                key = (language, screen)
                if key in expected and key not in captured:
                    screenshot(udid, output / language / f"{screen}.png", family)
                    captured.add(key)
        if driver.wait() != 0:
            raise RuntimeError("The store screenshot harness failed")
    if expected != captured:
        raise RuntimeError(f"Missing screenshots: {sorted(expected - captured)}")
    print(f"Verified {len(captured)} {family} screenshots with App Store dimensions.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("family", choices=DEVICES)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    capture(args.family, args.output)
