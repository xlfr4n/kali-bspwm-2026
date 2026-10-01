#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"
command -v docker >/dev/null 2>&1 || { echo 'docker is required.' >&2; exit 1; }
docker compose down --remove-orphans
docker compose up -d --build
echo '⚡ xLFr4n Web Lab reset complete.'
