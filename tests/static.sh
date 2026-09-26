#!/usr/bin/env bash
# ⚡ xlfr4n // Kali BSPWM 2026
# Fast static guardrail. No system changes, no runtime dependencies.

set -Eeuo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

files=(
  install.sh
  uninstall.sh
  config/bspwm/bspwmrc
  config/polybar/launch.sh
)
while IFS= read -r -d '' file; do
  files+=("$file")
done < <(find scripts -maxdepth 1 -type f ! -name 'README.md' -print0 | sort -z)

for file in "${files[@]}"; do
  bash -n "$file"
done

if grep -RFn -- '\${' install.sh uninstall.sh config scripts >/dev/null 2>&1; then
  echo 'Found a literal backslash before a Bash variable expansion.' >&2
  exit 1
fi

required=(
  config/bspwm/bspwmrc
  config/sxhkd/sxhkdrc
  config/polybar/config.ini
  config/polybar/launch.sh
  config/kitty/kitty.conf
  config/rofi/launcher.rasi
  config/dunst/dunstrc
  config/picom/picom.conf
  config/zshrc
  config/bspwm.desktop
  scripts/autostart
  scripts/kali-menu
  scripts/vmware-tools
)

for file in "${required[@]}"; do
  test -s "$file"
done

grep -Fq 'kali-menu' config/sxhkd/sxhkdrc
grep -Fq 'vmware-tools' config/sxhkd/sxhkdrc
grep -Fq 'wm-restack = bspwm' config/polybar/config.ini
grep -Fq 'enable-ipc = true' config/polybar/config.ini
grep -Fq 'xlfr4n' scripts/*.sh scripts/* 2>/dev/null || true

echo 'Static checks: OK'
