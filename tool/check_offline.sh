#!/usr/bin/env bash
# N Keto Tracker offline kanıtı (MASTER_PROMPT §14.1 / AC3).
#
# 1) Android manifest izinleri allowlist'te olmalı (ağ yalnız reklam+ödeme).
# 1b) Ağ kodu yalnız lib/core/monetization içinde olmalı.
# 2) pubspec.yaml DOĞRUDAN bağımlılıklarında ağ/telemetri/reklam/analytics
#    paketi olmamalı.
#
# Not: C-001 ADR-PB-012 ile revize edildi — sağlık verisi cihazdan çıkmaz.
# Yasaklı bulgu → exit 1 (CI release engelleyicisidir).
set -uo pipefail

cd "$(dirname "$0")/.."
status=0

# --- 1) İzin allowlist'i (ADR-PB-012): ağ yalnız reklam + ödeme içindir ---
allowed_perms='android.permission.INTERNET|android.permission.ACCESS_NETWORK_STATE'
bad_perms="$(grep -rhn --include='AndroidManifest.xml' -o 'uses-permission[^/]*android:name="[^"]*"' android/app/src 2>/dev/null   | sed -E 's/.*android:name="([^"]*)".*/\1/' | sort -u | grep -Ev "^($allowed_perms)$" || true)"
if [ -n "$bad_perms" ]; then
  echo "FAIL: izinsiz (allowlist dışı) izin bulundu:"
  echo "$bad_perms"
  status=1
else
  echo "OK: manifest izinleri allowlist içinde (INTERNET yalnız reklam+ödeme)"
fi

# --- 1b) Ağ kodu yalnız lib/core/monetization içinde olabilir ---
net_hits="$(grep -rln --include='*.dart' -E "HttpClient|dart:io.*Socket|package:http/" lib 2>/dev/null | grep -v '^lib/core/monetization/' | grep -v '\.g\.dart$' || true)"
if [ -n "$net_hits" ]; then
  echo "FAIL: ağ kodu monetization dışında:"
  echo "$net_hits"
  status=1
else
  echo "OK: ağ kodu yalnız lib/core/monetization içinde"
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
