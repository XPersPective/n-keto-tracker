#!/usr/bin/env bash
# N Keto Tracker offline kanıtı (MASTER_PROMPT §14.1 / AC3).
#
# 1) Üretim manifest'lerinde (main/profile/release) INTERNET izni olmamalı.
#    Debug, Flutter'ın yerel VM servisi için bu izni taşıyabilir; release'e
#    sızmadığı ayrıca derlenmiş APK üzerinde doğrulanır.
# 2) pubspec.yaml DOĞRUDAN bağımlılıklarında ağ/telemetri/reklam/analytics
#    paketi olmamalı.
#
# Yasaklı bulgu → exit 1 (CI release engelleyicisidir).
set -uo pipefail

cd "$(dirname "$0")/.."
status=0

# --- 1) INTERNET izni taraması ---
manifest_hits="$(grep -rn --include='AndroidManifest.xml' 'android.permission.INTERNET' android/app/src/main android/app/src/profile android/app/src/release 2>/dev/null || true)"
if [ -n "$manifest_hits" ]; then
  echo "FAIL: Üretim varyantlarında INTERNET izni bulundu:"
  echo "$manifest_hits"
  status=1
else
  echo "OK: main/profile/release manifest'lerinde INTERNET izni yok"
fi

debug_hits="$(grep -rn --include='AndroidManifest.xml' 'android.permission.INTERNET' android/app/src/debug 2>/dev/null || true)"
if [ -n "$debug_hits" ]; then
  echo "INFO: Flutter VM servisi için debug-only INTERNET izni:"
  echo "$debug_hits"
fi

# --- 2) Yasaklı doğrudan bağımlılık taraması ---
# Bağımlılık adları `dependencies:` bölümünden (dev_dependencies hariç)
# iki boşluk girintili satırlardan çıkarılır; flutter sdk satırları atlanır.
forbidden_re='^(firebase[^ ]*|.*analytics|.*admob|.*crashlytics|.*sentry|http|dio|.*webview.*|.*web_view.*|socket[^ ]*|.*telemetry|.*facebook.*|.*appsflyer.*|.*onesignal.*|openai|.*chatgpt.*)$'

deps="$(sed -n '/^dependencies:$/,/^dev_dependencies:$/p' pubspec.yaml \
  | grep -E '^  [a-zA-Z_][a-zA-Z0-9_]*:' \
  | sed -E 's/^  ([a-zA-Z_][a-zA-Z0-9_]*):.*/\1/' || true)"

for dep in $deps; do
  if printf '%s' "$dep" | grep -Eq "$forbidden_re"; then
    echo "FAIL: yasaklı bağımlılık: $dep"
    status=1
  fi
done
[ $status -eq 0 ] && echo "OK: pubspec doğrudan bağımlılıkları yasaklı desen içermiyor"

exit $status
