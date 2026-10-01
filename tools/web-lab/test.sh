#!/usr/bin/env bash
set -Eeuo pipefail

BASE_URL="${1:-http://127.0.0.1:8080}"
command -v curl >/dev/null 2>&1 || { echo 'curl is required.' >&2; exit 1; }
command -v jq >/dev/null 2>&1 || { echo 'jq is required.' >&2; exit 1; }

echo '⚡ xLFr4n // WEB LAB // SMOKE'
health="$(curl -fsS "$BASE_URL/healthz")"
printf '%s\n' "$health" | jq -e '.status == "ok" and .service == "xlfr4n-web-lab"' >/dev/null
echo '[OK] healthz'

curl -fsS "$BASE_URL/" | grep -Fq 'xLFr4n Web Lab'
echo '[OK] landing page'

curl -fsS "$BASE_URL/api/config" | jq -e '.training_mode == true and .environment == "isolated-lab"' >/dev/null
echo '[OK] training configuration'

curl -fsS "$BASE_URL/api/users/1" | jq -e '.username == "alice"' >/dev/null
echo '[OK] synthetic user endpoint'

curl -fsS "$BASE_URL/api/admin/users" | jq -e 'length == 3' >/dev/null
echo '[OK] synthetic admin dataset'

echo 'Web Lab smoke: PASS'
