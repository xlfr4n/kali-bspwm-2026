#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"
command -v docker >/dev/null 2>&1 || { echo 'docker is required.' >&2; exit 1; }
if docker compose version >/dev/null 2>&1; then
  docker compose down --remove-orphans
  docker compose up -d --build
else
  echo 'Docker Compose v2 is required.' >&2
  exit 1
fi
echo '⚡ xLFr4n Web Lab reset complete.'
