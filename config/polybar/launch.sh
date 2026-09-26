#!/usr/bin/env bash
# ⚡ xlfr4n // Kali BSPWM 2026

set -Eeuo pipefail

CONFIG="$HOME/.config/polybar/config.ini"
LOG="/tmp/kali-bspwm-polybar.log"

command -v polybar >/dev/null 2>&1 || exit 1
[ -r "$CONFIG" ] || exit 1

pkill -x polybar 2>/dev/null || true

for _ in $(seq 1 25); do
  pgrep -x polybar >/dev/null 2>&1 || break
  sleep 0.2
done

mapfile -t monitors < <(
  polybar -m 2>/dev/null |
    sed -nE 's/^Monitor ([^ ]+).*/\1/p' |
    sort -u
)

if [ "${#monitors[@]}" -eq 0 ]; then
  polybar main -c "$CONFIG" >>"$LOG" 2>&1 &
  exit 0
fi

for monitor in "${monitors[@]}"; do
  MONITOR="$monitor" polybar main -c "$CONFIG" >>"$LOG" 2>&1 &
done
