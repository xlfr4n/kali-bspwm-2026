#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"
command -v docker >/dev/null 2>&1 || { echo 'docker is required.' >&2; exit 1; }

echo '⚡ xLFr4n // WEB LAB // RESET'
docker compose down --remove-orphans
docker compose up -d --build --force-recreate
echo 'Web Lab is running explicitly; it will not auto-restart after host reboot.'
echo "Bind: \${WEB_LAB_BIND:-127.0.0.1}"
echo '⚡ xLFr4n Web Lab reset complete.'
