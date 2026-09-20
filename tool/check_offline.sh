#!/usr/bin/env bash
# N Keto Tracker offline kanıtı (MASTER_PROMPT §14.1 / AC3).
#
# 1) Android manifest'lerinde (main/debug/profile) INTERNET izni olmamalı.
# 2) pubspec.yaml DOĞRUDAN bağımlılıklarında ağ/telemetri/reklam/analytics
#    paketi olmamalı.
#
# Yasaklı bulgu → exit 1 (CI release engelleyicisidir).
set -uo pipefail

cd "$(dirname "$0")/.."
status=0

# --- 1) INTERNET izni taraması ---
manifest_hits="$(grep -rn --include='AndroidManifest.xml' 'android.permission.INTERNET' android/app/src 2>/dev/null || true)"
if [ -n "$manifest_hits" ]; then
  echo "FAIL: INTERNET izni bulundu:"
  echo "$manifest_hits"
  status=1
else
  echo "OK: Android manifest'lerinde INTERNET izni yok"
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
