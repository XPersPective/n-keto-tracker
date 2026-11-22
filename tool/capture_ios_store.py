"""Capture the existing store screenshot harness on a hosted iOS simulator."""

import argparse
import json
import os
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


def verify_screenshot(path, family):
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
    simctl("ui", udid, "appearance", "light")
    simctl(
        "status_bar", udid, "override", "--time", "9:41",
        "--dataNetwork", "wifi", "--wifiMode", "active", "--wifiBars", "3",
        "--cellularMode", "active", "--cellularBars", "4",
        "--batteryState", "discharging", "--batteryLevel", "100",
    )
    command = [
        "flutter", "drive", "--no-pub", "--no-publish-port", "-d", udid,
        "--driver=test_driver/integration_test.dart",
        "--target=integration_test/store_screenshots_test.dart",
        "--dart-define=SHOT_LOCALES=" + ",".join(LANGUAGES),
        "--dart-define=SHOT_USE_DRIVER=true",
    ]
    subprocess.run(
        command, check=True, timeout=23 * 60,
        env={**os.environ, "SHOT_DIR": str(output.resolve())},
    )
    expected = {
        output / language / f"{screen}.png"
        for language in LANGUAGES
        for screen in SCREENS
    }
    if expected != set(output.rglob("*.png")):
        raise RuntimeError("Unexpected store screenshot file set")
    for path in sorted(expected):
        verify_screenshot(path, family)
    print(f"Verified {len(expected)} {family} screenshots with App Store dimensions.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("family", choices=DEVICES)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    capture(args.family, args.output)
