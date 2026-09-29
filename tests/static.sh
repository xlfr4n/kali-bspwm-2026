#!/usr/bin/env bash
# ⚡ xlfr4n // Kali BSPWM 2026
# Static guardrail with explicit diagnostics. No system changes, no runtime dependencies.
set -Eeuo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

pass=0
fail=0

check() {
  local label="$1"
  shift
  if "$@"; then
    printf "[PASS] %s\n" "$label"
    pass=$((pass + 1))
  else
    printf "[FAIL] %s\n" "$label" >&2
    fail=$((fail + 1))
    return 1
  fi
}

check_not_present() {
  local label="$1"
  shift
  if "$@"; then
    printf "[FAIL] %s\n" "$label" >&2
    fail=$((fail + 1))
    return 1
  else
    printf "[PASS] %s\n" "$label"
    pass=$((pass + 1))
  fi
}

check "syntax install.sh" bash -n install.sh
check "syntax uninstall.sh" bash -n uninstall.sh
check "syntax bspwmrc" bash -n config/bspwm/bspwmrc
check "syntax polybar launch" bash -n config/polybar/launch.sh

while IFS= read -r -d "" file; do
  check "syntax $file" bash -n "$file"
done < <(find scripts -maxdepth 1 -type f ! -name "README.md" -print0 | sort -z)

required_files=(
  config/bspwm/bspwmrc
  config/sxhkd/sxhkdrc
  config/polybar/config.ini
  config/polybar/launch.sh
  config/kitty/kitty.conf
  config/rofi/launcher.rasi
  config/rofi/fallback.rasi
  config/dunst/dunstrc
  config/picom/picom.conf
  config/zshrc
  config/bspwm.desktop
  config/plank/xLFr4n/dock.theme
  config/plank/README.md
  config/tint2/tint2rc
  config/tint2/README.md
  scripts/autostart
  scripts/kali-menu
  scripts/rofi-xlfr4n
  scripts/vmware-tools
  scripts/doctor.sh
  scripts/xlfr4n-banner
  scripts/xlfr4n-pulse
  scripts/target-copy
  scripts/fullscreen-toggle
  scripts/dock
  scripts/mission-control
  scripts/desktop-style
)

for file in "${required_files[@]}"; do
  check "required file: $file" test -s "$file"
done

check "binding: kali-menu" grep -Fq "kali-menu" config/sxhkd/sxhkdrc
check "binding: Rofi drun" grep -Fq "rofi-xlfr4n -show drun" config/sxhkd/sxhkdrc
check "binding: Rofi run" grep -Fq "rofi-xlfr4n -show run" config/sxhkd/sxhkdrc
check "VirtualBox service detection" grep -Fq "virtualbox-guest-utils.service" install.sh
check "VirtualBox doctor detection" grep -Fq "virtualbox-guest-utils.service" scripts/doctor.sh
check "Polybar restack" grep -Fq "wm-restack = bspwm" config/polybar/config.ini
check "Polybar IPC" grep -Fq "enable-ipc = true" config/polybar/config.ini
check "Polybar glass" grep -Fq "glass = #E50B0E12" config/polybar/config.ini
check "Polybar border" grep -Fq "border = #55ff3344" config/polybar/config.ini
check "Polybar width" grep -Fq "width = 96%" config/polybar/config.ini
check "Polybar radius" grep -Fq "radius = 14" config/polybar/config.ini
check "Plank fallback reference" grep -Fq "plank" install.sh
check "Tint2 reference" grep -Fq "tint2" install.sh
check "Rofi fallback reference" grep -Fq "fallback.rasi" scripts/rofi-xlfr4n
check "Workspace bar" grep -Fq "[bar/workspace]" config/polybar/config.ini
check "Workspace modules" grep -Fq "modules-left = bspwm" config/polybar/config.ini
check "Clock module" grep -Fq "modules-right = date" config/polybar/config.ini
check "Workspace launch" grep -Fq "polybar workspace -c" config/polybar/launch.sh
check "Dock bar" grep -Fq "[bar/dock]" config/polybar/config.ini
check "Dock Polybar backend" grep -Fq "Polybar dock" scripts/dock
check "Dock Polybar fallback" grep -Fq "polybar-fallback" scripts/dock
check "Dock Tint2 backend" grep -Fq "tint2" scripts/dock
check "Tint2 launcher-only" grep -Fq "panel_items = L" config/tint2/tint2rc
check "Dock launcher helper" grep -Fq "dock-launch" scripts/dock
check "System Monitor launcher" grep -Fq "System Monitor" scripts/dock
check "Screenshot launcher" grep -Fq "screenshot" scripts/dock-launch
check "Nine BSPWM desktops" grep -Fq "bspc monitor -d 1 2 3 4 5 6 7 8 9" config/bspwm/bspwmrc
check "Nine workspace bindings" grep -Fq "super + {1,2,3,4,5,6,7,8,9}" config/sxhkd/sxhkdrc
check_not_present "No nm-applet startup" grep -Fq "command -v nm-applet" scripts/autostart
check "Menu Spotlight" grep -Fq "SPOTLIGHT Launch apps" scripts/kali-menu
check "Menu Mission Control" grep -Fq "MISSION   Window overview" scripts/kali-menu
check "Menu dock" grep -Fq "DOCK      Toggle floating dock" scripts/kali-menu
check "Desktop docs" grep -Fq "Super" docs/DESKTOP-STYLE.md
check "xLFr4n identity in scripts" grep -Fq "xlfr4n" scripts/*.sh scripts/*
check "Fullscreen binding" grep -Fq "fullscreen-toggle" config/sxhkd/sxhkdrc
check "Target clipboard binding" grep -Fq "click-left = target-copy" config/polybar/config.ini
check "Interactive comment paste" grep -Fq "setopt interactivecomments" config/zshrc
check "Banner guard" grep -Fq "XLFR4N_BANNER_DONE" config/zshrc
check "Launch feedback" grep -Fq "xLFr4n • Launching" scripts/dock-launch
check "Lab uses xLFr4n banner" grep -Fq "xlfr4n-banner --static" scripts/lab
check "Launcher startup notification" grep -Fq "StartupNotify=true" scripts/dock

printf "\nStatic checks: %d PASS, %d FAIL\n" "$pass" "$fail"
[ "$fail" -eq 0 ]
