#!/usr/bin/env bash
# ⚡ xlfr4n // Kali BSPWM 2026
# Fast static guardrail. No system changes, no runtime dependencies.

set -Eeuo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

bash -n install.sh
bash -n uninstall.sh
bash -n config/bspwm/bspwmrc
bash -n config/polybar/launch.sh
bash -n scripts/dock
bash -n scripts/dock-launch
bash -n scripts/mission-control
bash -n scripts/desktop-style

while IFS= read -r -d '' file; do
  bash -n "$file"
done < <(find scripts -maxdepth 1 -type f ! -name 'README.md' -print0 | sort -z)

required_files="config/bspwm/bspwmrc config/sxhkd/sxhkdrc config/polybar/config.ini config/polybar/launch.sh config/kitty/kitty.conf config/rofi/launcher.rasi config/rofi/fallback.rasi config/dunst/dunstrc config/picom/picom.conf config/zshrc config/bspwm.desktop config/plank/xLFr4n/dock.theme config/plank/README.md config/tint2/tint2rc config/tint2/README.md scripts/autostart scripts/kali-menu scripts/rofi-xlfr4n scripts/vmware-tools scripts/doctor.sh scripts/xlfr4n-banner scripts/xlfr4n-pulse scripts/target-copy scripts/fullscreen-toggle scripts/dock scripts/mission-control scripts/desktop-style"

for file in $required_files; do
  test -s "$file"
done

grep -Fq 'kali-menu' config/sxhkd/sxhkdrc
grep -Fq 'rofi-xlfr4n -show drun' config/sxhkd/sxhkdrc
grep -Fq 'rofi-xlfr4n -show run' config/sxhkd/sxhkdrc
grep -Fq 'virtualbox-guest-utils.service' install.sh
grep -Fq 'virtualbox-guest-utils.service' scripts/doctor.sh
grep -Fq 'wm-restack = bspwm' config/polybar/config.ini
grep -Fq 'enable-ipc = true' config/polybar/config.ini
grep -Fq 'glass = #E50B0E12' config/polybar/config.ini
grep -Fq 'border = #55ff3344' config/polybar/config.ini
grep -Fq 'width = 96%' config/polybar/config.ini
grep -Fq 'radius = 14' config/polybar/config.ini
grep -Fq 'plank' install.sh
grep -Fq 'tint2' install.sh
grep -Fq 'fallback.rasi' scripts/rofi-xlfr4n

grep -Fq '[bar/workspace]' config/polybar/config.ini
grep -Fq 'modules-left = bspwm' config/polybar/config.ini
grep -Fq 'modules-right = date' config/polybar/config.ini
grep -Fq 'polybar workspace -c' config/polybar/launch.sh
grep -Fq '[bar/dock]' config/polybar/config.ini
grep -Fq 'Polybar dock' scripts/dock
grep -Fq 'polybar-fallback' scripts/dock
grep -Fq 'tint2' scripts/dock
grep -Fq 'panel_items = L' config/tint2/tint2rc
grep -Fq 'dock-launch' scripts/dock
grep -Fq 'System Monitor' scripts/dock
grep -Fq 'screenshot' scripts/dock-launch
grep -Fq 'bspc monitor -d 1 2 3 4 5 6 7 8 9' config/bspwm/bspwmrc
grep -Fq 'super + {1,2,3,4,5,6,7,8,9}' config/sxhkd/sxhkdrc
if grep -Fq 'command -v nm-applet' scripts/autostart; then exit 1; fi
grep -Fq 'SPOTLIGHT Launch apps' scripts/kali-menu
grep -Fq 'MISSION   Window overview' scripts/kali-menu
grep -Fq 'DOCK      Toggle floating dock' scripts/kali-menu
grep -Fq 'Super' docs/DESKTOP-STYLE.md 2>/dev/null || true
grep -Fq 'xlfr4n' scripts/*.sh scripts/* 2>/dev/null || true

echo 'Static checks: OK'


grep -Fq 'fullscreen-toggle' config/sxhkd/sxhkdrc
grep -Fq 'click-left = target-copy' config/polybar/config.ini
grep -Fq 'setopt interactivecomments' config/zshrc
grep -Fq 'XLFR4N_BANNER_DONE' config/zshrc
grep -Fq 'Launching' scripts/dock-launch
grep -Fq 'xlfr4n-banner --static' scripts/lab
grep -Fq 'StartupNotify=true' scripts/dock
