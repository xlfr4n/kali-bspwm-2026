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
check "Uninstall workspace HUD cleanup" grep -Fq "workspace-hud --stop" uninstall.sh
check "Uninstall new UX helpers" grep -Fq "audio-control" uninstall.sh
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
  scripts/xlfr4n-date
  scripts/target-copy
  scripts/fullscreen-toggle
  scripts/dock
  scripts/mission-control
  scripts/desktop-style
  scripts/session-profile
  scripts/workspace-hud
  scripts/audio-control
  scripts/network-status
  scripts/battery-status
)

for file in "${required_files[@]}"; do
  check "required file: $file" test -s "$file"
done

check "binding: kali-menu" grep -Fq "kali-menu" config/sxhkd/sxhkdrc
check "binding: Rofi drun" grep -Fq "rofi-xlfr4n -show drun" config/sxhkd/sxhkdrc
check "binding: Rofi run" grep -Fq "rofi-xlfr4n -show run" config/sxhkd/sxhkdrc
check "Audio feedback binding" grep -Fq "audio-control up" config/sxhkd/sxhkdrc
check "Brave URL field" grep -Fq "Exec=dock-launch brave %U" config/applications/xLFr4n-brave.desktop
check "Dock Code launcher file" grep -Fq "Exec=sh -c \"dock-launch code\"" config/applications/xLFr4n-code.desktop
check "Dock monitor launcher file" grep -Fq "Exec=sh -c \"dock-launch btop\"" config/applications/xLFr4n-btop.desktop
check "Dock settings launcher file" grep -Fq "dock-launch settings" config/applications/xLFr4n-settings.desktop
check "Dock network launcher file" grep -Fq "dock-launch network" config/applications/xLFr4n-network.desktop
check "Dock screenshot launcher file" grep -Fq "dock-launch screenshot" config/applications/xLFr4n-screenshot.desktop
check "VirtualBox service detection" grep -Fq "virtualbox-guest-utils.service" install.sh
check "VirtualBox doctor detection" grep -Fq "virtualbox-guest-utils.service" scripts/doctor.sh
check "Polybar restack" grep -Fq "wm-restack = bspwm" config/polybar/config.ini
check "Polybar IPC" grep -Fq "enable-ipc = true" config/polybar/config.ini
check "Polybar transparent top rail" grep -Fq "background = #00000000" config/polybar/config.ini
check "Polybar borderless top rail" grep -Fq "border-size = 0pt" config/polybar/config.ini
check "Polybar width" grep -Fq "width = 94%" config/polybar/config.ini
check "Polybar flat top rail" grep -Fq "radius = 0" config/polybar/config.ini
check "Plank fallback reference" grep -Fq "plank" install.sh
check "Tint2 reference" grep -Fq "tint2" install.sh
check "Rofi fallback reference" grep -Fq "fallback.rasi" scripts/rofi-xlfr4n
check "Workspace bar" grep -Fq "[bar/workspace]" config/polybar/config.ini
check "Workspace modules" grep -Fq "modules-left = bspwm" config/polybar/config.ini
check "Compact workspace labels" grep -Fq "label-focused-margin = 1" config/polybar/config.ini
check "Workspace transparent background" grep -Fq "background = #00000000" config/polybar/config.ini
check "Clock modules" grep -Fq "modules-right = date time" config/polybar/config.ini
check "Workspace launch" grep -Fq "polybar workspace -c" config/polybar/launch.sh
check "Workspace rail offset" grep -Fq "offset-y = 25pt" config/polybar/config.ini
check "Workspace time module" grep -Fq "[module/time]" config/polybar/config.ini
check "Top rail transparent" grep -Fq "background = #00000000" config/polybar/config.ini
check "Workspace HUD width" grep -Fq "width = 94%" config/polybar/config.ini
check "Workspace click support" grep -Fq "enable-click = true" config/polybar/config.ini
check "Date and time right modules" grep -Fq "modules-right = date time" config/polybar/config.ini
check "Adaptive network module" grep -Fq "exec = ~/.local/bin/network-status" config/polybar/config.ini
check "Optional battery module" grep -Fq "exec = ~/.local/bin/battery-status" config/polybar/config.ini
check "Dock terminal id" grep -Fq "xLFr4n-terminal.desktop" config/tint2/tint2rc
check "Dock code id" grep -Fq "xLFr4n-code.desktop" config/tint2/tint2rc
check "Dock menu id" grep -Fq "xLFr4n-kali-menu.desktop" config/tint2/tint2rc
check "Kitty cursor animation" grep -Fq "cursor_blink_interval 0.5 ease-in-out" config/kitty/kitty.conf
check "Kitty cursor trail" grep -Fq "cursor_trail 18" config/kitty/kitty.conf
check "Kitty single-window border" grep -Fq "draw_window_borders_for_single_window yes" config/kitty/kitty.conf
check "Kitty input latency" grep -Fq "input_delay 2" config/kitty/kitty.conf
check "Kitty tab shortcuts" grep -Fq "map ctrl+shift+t new_tab" config/kitty/kitty.conf
check "Workspace HUD subscribe" grep -Fq "bspc subscribe desktop_focus" scripts/workspace-hud
check "Workspace HUD stack tag" grep -Fq "x-dunst-stack-tag" scripts/workspace-hud
check "Network follows default route" grep -Fq "ip route show default" scripts/network-status
check "Battery is optional" grep -Fq "BAT*" scripts/battery-status
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
check "Desktop docs" grep -Fq "xLFr4n" docs/DESKTOP-STYLE.md
check "xLFr4n identity in scripts" grep -Rqs "xlfr4n" scripts --exclude="README.md"
check "Fullscreen binding" grep -Fq "fullscreen-toggle" config/sxhkd/sxhkdrc
check "Target clipboard binding" grep -Fq "click-left = target-copy" config/polybar/config.ini
check "Interactive comment paste" grep -Fq "setopt interactivecomments" config/zshrc
check "Banner guard" grep -Fq "XLFR4N_BANNER_DONE" config/zshrc
check "Launch feedback" grep -Fq "xLFr4n • Launching" scripts/dock-launch
check "Lab uses xLFr4n banner" grep -Fq "xlfr4n-banner --static" scripts/lab
check "Launcher startup notification" grep -Fq "StartupNotify=true" scripts/dock
check "Banner ASCII frame" grep -Fq "+------------------------------------------------------------------+" scripts/xlfr4n-banner
check "Banner animation" grep -Fq '"BOOT" "LINK" "SYNC" "DRAW" "READY"' scripts/xlfr4n-banner
check "Banner localized clock" grep -Fq "LC_TIME" scripts/xlfr4n-banner
check "Pulse animation frames" grep -Fq "[●●●]" scripts/xlfr4n-pulse
check "Localized date helper" grep -Fq "date '+%A, %-d" scripts/xlfr4n-date
check "Workspace HUD ready frame" grep -Fq "focus ready" scripts/workspace-hud
check "Uninstall date helper" grep -Fq "xlfr4n-date" uninstall.sh

printf "\nStatic checks: %d PASS, %d FAIL\n" "$pass" "$fail"
[ "$fail" -eq 0 ]

check "Install guide" test -s docs/INSTALL.md
check "Fast autostart core phase" grep -Fq "phase=core ready" scripts/autostart
check "Autostart dispatches background polish" grep -Fq "phase=background staged" scripts/autostart
check "Autostart stages wallpaper" grep -Fq "nice -n 10" scripts/autostart
check "Autostart avoids startup theme rewrite" grep -Fq "without rewriting any files" scripts/autostart
check_not_present "Autostart does not restart themes" grep -Fq "theme-switch" scripts/autostart
check "Autostart starts Polybar directly" grep -Fq "polybar/launch.sh" scripts/autostart
check "Autostart starts Dunst" grep -Fq "dunst >/dev/null 2>&1 &" scripts/autostart
check "Autostart starts workspace HUD" grep -Fq "workspace-hud --daemon" scripts/autostart
check "Autostart stages workspace HUD" grep -Fq "workspace hud dispatched" scripts/autostart