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
check "Uninstall workspace HUD cleanup" grep -Fq 'workspace-hud" --stop' uninstall.sh
check "Uninstall new UX helpers" grep -Fq "audio-control" uninstall.sh
check "Uninstall Fastfetch config" grep -Fq '"$HOME/.config/fastfetch"' uninstall.sh
check "Uninstall launch helper" grep -Fq '"$HOME/.local/bin/xlfr4n-launch"' uninstall.sh
check "Uninstall workspace rail" grep -Fq '"$HOME/.local/bin/workspace-rail"' uninstall.sh
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
  config/fastfetch/config.jsonc
  config/fastfetch/xLFr4n.logo
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
  docs/FINAL-AUDIT.md
  scripts/autostart
  scripts/kali-menu
  scripts/rofi-xlfr4n
  scripts/vmware-tools
  scripts/doctor.sh
  scripts/xlfr4n-banner
  scripts/xlfr4n-pulse
  scripts/xlfr4n-date
  scripts/xlfr4n-launch
  scripts/target-copy
  scripts/fullscreen-toggle
  scripts/dock
  scripts/mission-control
  scripts/desktop-style
  scripts/session-profile
  scripts/workspace-hud
  scripts/workspace-rail
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
check "Fastfetch deployment" grep -Fq "fastfetch; do" install.sh
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
check "Workspace rail offset above dock" grep -Fq "offset-y = 70pt" config/polybar/config.ini
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
check "Kitty cursor trail" grep -Fq "cursor_trail 20" config/kitty/kitty.conf
check "Kitty single-window border" grep -Fq "draw_window_borders_for_single_window yes" config/kitty/kitty.conf
check "Kitty input latency" grep -Fq "input_delay 2" config/kitty/kitty.conf
check "Kitty tab shortcuts" grep -Fq "map ctrl+shift+t new_tab" config/kitty/kitty.conf
check "Fastfetch Kali logo source" grep -Fq '"source": "~/.config/fastfetch/xLFr4n.logo"' config/fastfetch/config.jsonc
check "Fastfetch Kali logo shape" grep -Fq ".............." config/fastfetch/xLFr4n.logo
check "Fastfetch xLFr4n signature" grep -Fq '⚡ xLFr4n' config/fastfetch/xLFr4n.logo
check "Fastfetch Kali blue palette" grep -Fq '"1": "blue"' config/fastfetch/config.jsonc
check "Fastfetch target module" grep -Fq '"key": "TARGET"' config/fastfetch/config.jsonc
check "Fastfetch local IP module" grep -Fq '"type": "localip"' config/fastfetch/config.jsonc
check "Fastfetch date module" grep -Fq '"type": "datetime"' config/fastfetch/config.jsonc
check "Zsh starts Fastfetch" grep -Fq "command -v fastfetch" config/zshrc
check_not_present "Zsh does not auto-start ASCII banner" grep -Fq "xlfr4n-banner --animate" config/zshrc
check "Unified launch feedback helper" grep -Fq "xLFr4n // OPENING" scripts/xlfr4n-launch
check "Launch helper accepts WM class" grep -Fq -- '--class' scripts/xlfr4n-launch
check "Launch feedback in super Return" grep -Fq 'xlfr4n-launch "Kitty"' config/sxhkd/sxhkdrc
check "Kitty hyperlink underline mode" grep -Fq "underline_hyperlinks hover" config/kitty/kitty.conf
check_not_present "Kitty invalid hyperlink underline mode" grep -Fq "underline_hyperlinks yes" config/kitty/kitty.conf
check "Workspace HUD subscribe" grep -Fq "bspc subscribe desktop_focus" scripts/workspace-hud
check "Workspace HUD stack tag" grep -Fq "x-dunst-stack-tag" scripts/workspace-hud
check "Network follows default route" grep -Fq "ip route show default" scripts/network-status
check "Battery is optional" grep -Fq "BAT*" scripts/battery-status
check "Network state coloring" grep -Fq '%{F%s}%s %s%%{F-}' scripts/network-status
check "Battery state coloring" grep -Fq '%{F%s}%s %s%%{F-}' scripts/battery-status
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
check "Menu system snapshot" grep -Fq "SYSTEM    Terminal system snapshot" scripts/kali-menu
check "Menu dock" grep -Fq "DOCK      Toggle floating dock" scripts/kali-menu
check "Desktop docs" grep -Fq "xLFr4n" docs/DESKTOP-STYLE.md
check "xLFr4n identity in scripts" grep -Rqs "xlfr4n" scripts --exclude="README.md"
check "Fullscreen binding" grep -Fq "fullscreen-toggle" config/sxhkd/sxhkdrc
check "System snapshot hotkey" grep -Fq "xlfr4n-banner --static" config/sxhkd/sxhkdrc
check "Target clipboard binding" grep -Fq "click-left = target-copy" config/polybar/config.ini
check "Interactive comment paste" grep -Fq "setopt interactivecomments" config/zshrc
check "Fastfetch startup guard" grep -Fq "KALI_BSPWM_FASTFETCH_DONE" config/zshrc
check "Dock launch feedback" grep -Fq "xLFr4n // OPENING" scripts/dock-launch
check "Lab uses xLFr4n banner" grep -Fq "xlfr4n-banner --static" scripts/lab
check "Launcher startup notification" grep -Fq "StartupNotify=true" scripts/dock
check "Banner ASCII frame" grep -Fq "+------------------------------------------------------------------+" scripts/xlfr4n-banner
check "Banner animation" grep -Fq '"BOOT" "LINK" "SYNC" "DRAW" "READY"' scripts/xlfr4n-banner
check "Banner localized clock" grep -Fq "LC_TIME" scripts/xlfr4n-banner
check "Pulse animation reads theme" grep -Fq "theme-state/current" scripts/xlfr4n-pulse
check "Pulse animation keeps xLFr4n identity" grep -Fq "xLFr4n" scripts/xlfr4n-pulse
check "Pulse animation keeps KALI marker" grep -Fq "KALI" scripts/xlfr4n-pulse
check "Pulse animation signal frames" grep -Fq "[●···]" scripts/xlfr4n-pulse
check "Pulse animation cadence" grep -Fq "interval = 0.12" config/polybar/config.ini
check "Localized date helper" grep -Fq "date '+%A, %-d" scripts/xlfr4n-date
check "Spanish date default" grep -Fq 'XLFR4N_DATE_LOCALE:-es' scripts/xlfr4n-date
check "Workspace HUD ready frame" grep -Fq "focus ready" scripts/workspace-hud
check "Workspace rail script" grep -Fq "polybar workspace" scripts/workspace-rail
check "Workspace rail staged after dock" grep -Fq "workspace-rail" scripts/autostart
check "Uninstall date helper" grep -Fq "xlfr4n-date" uninstall.sh
check "Wallpaper fixed default" grep -Fq '/usr/share/backgrounds/kali/kali-hack-16x9.jpg' scripts/wallpaper
check "Autostart uses fixed wallpaper" grep -Fq 'wallpaper" --default' scripts/autostart
check "Default wallpaper preserves source image" grep -Fq 'XLFR4N_WALLPAPER_RAW=1 set_wallpaper "$DEFAULT_WALLPAPER"' scripts/wallpaper
check "Polybar fallback dock uses launch helper" grep -Fq "click-left = dock-launch kitty" config/polybar/config.ini
check "Kali Lab shortcut uses launch helper" grep -Fq 'xlfr4n-launch "Kali Lab"' config/sxhkd/sxhkdrc
check "Screenshot menu uses launch helper" grep -Fq 'xlfr4n-launch "Screenshot"' scripts/screenshot-menu

# ── Hardening / regression guards (2026-09-30 review) ─────────────────────
check "syntax brightness-control" bash -n scripts/brightness-control
check "syntax keys-help" bash -n scripts/keys-help
check "Wallpaper temp index is per-process" grep -Fq 'tmp_index="$INDEX_FILE.tmp.$$"' scripts/wallpaper
check_not_present "No predictable /tmp logs in scripts" grep -rqE '/tmp/kali-bspwm' scripts config
check_not_present "No duplicated sxhkd command bindings" bash -c "awk '/^[^[:space:]#]/{k=\$0;next} /^[[:space:]]+[^[:space:]]/{c=\$0; sub(/^[[:space:]]+/,\"\",c); if(c==\"mission-control\"||c==\"theme-switch\")n[c]++} END{exit !(n[\"mission-control\"]>1||n[\"theme-switch\"]>1)}' config/sxhkd/sxhkdrc"
check "Media keys bound" grep -Fq "XF86AudioPlay" config/sxhkd/sxhkdrc
check "Brightness keys bound" grep -Fq "brightness-control up" config/sxhkd/sxhkdrc
check "Keybinding cheat sheet bound" grep -Fq "keys-help" config/sxhkd/sxhkdrc
check "Polkit agent staged in autostart" grep -Fq "polkit" scripts/autostart
check "Idle lock is opt-in" grep -Fq ".config/xlfr4n/autolock" scripts/autostart
check "Keyboard layout configurable" grep -Fq "XLFR4N_KB_LAYOUT" scripts/keyboard
check "Installer skips unavailable extra packages" grep -Fq "EXTRA_PACKAGES" install.sh
check "Zsh completion enabled" grep -Fq "compinit" config/zshrc
check "Zsh syntax-highlighting sourced last" bash -c "tail -n 3 config/zshrc | grep -Fq zsh-syntax-highlighting"
for _s in $(ls scripts | grep -v '^README.md$'); do
  case "$_s" in st|ct) continue ;; esac
  check "Uninstall removes $_s" grep -Fq "\"\$HOME/.local/bin/$_s\"" uninstall.sh
done

check "Brightness targets backlight class" grep -Fq "brightnessctl -c backlight" scripts/brightness-control
check "Brightness is safe without backlight" grep -Fq "! brightnessctl -c backlight get" scripts/brightness-control
check "Brightness helper executable bit" bash -c 'git ls-files --stage scripts/brightness-control | grep -Eq "^100755 .+scripts/brightness-control$"'
check "Keys helper executable bit" bash -c 'git ls-files --stage scripts/keys-help | grep -Eq "^100755 .+scripts/keys-help$"'

printf "\nStatic checks: %d PASS, %d FAIL\n" "$pass" "$fail"
[ "$fail" -eq 0 ]

check "Install guide" test -s docs/INSTALL.md
check "CI workflow least privilege" grep -Fq "contents: read" .github/workflows/shellcheck.yml
check "CI stale run cancellation" grep -Fq "cancel-in-progress: true" .github/workflows/shellcheck.yml
check "CI manual trigger" grep -Fq "workflow_dispatch:" .github/workflows/shellcheck.yml
check "CI desktop validation" grep -Fq "desktop-file-validate" .github/workflows/shellcheck.yml
check "Fast autostart core phase" grep -Fq "phase=core ready" scripts/autostart
check "Autostart dispatches background polish" grep -Fq "phase=background staged" scripts/autostart
check "Autostart stages wallpaper" grep -Fq "nice -n 10" scripts/autostart
check "Autostart avoids startup theme rewrite" grep -Fq "without rewriting any files" scripts/autostart
check_not_present "Autostart does not restart themes" grep -Fq "theme-switch" scripts/autostart
check "Autostart starts Polybar directly" grep -Fq "polybar/launch.sh" scripts/autostart
check "Autostart starts Dunst" grep -Fq "dunst >/dev/null 2>&1 &" scripts/autostart
check "Launch helper guarantees Dunst" grep -Fq "ensure_dunst" scripts/xlfr4n-launch
check "Dock launch helper guarantees Dunst" grep -Fq "ensure_dunst" scripts/dock-launch
check "Autostart starts workspace HUD" grep -Fq 'workspace-hud" --daemon' scripts/autostart
check "Session reload restores workspace rail" grep -Fq 'workspace-rail" --restart' scripts/session-reload
check "Doctor checks workspace rail" grep -Fq 'Workspace rail' scripts/doctor.sh
check "Autostart single-instance lock" grep -Fq 'flock -n 9' scripts/autostart
check "Autostart user-scoped cleanup" grep -Fq 'pkill -u "$UID"' scripts/autostart
check "Polybar user-scoped cleanup" grep -Fq 'pkill -u "$UID"' config/polybar/launch.sh
check "Dock user-scoped cleanup" grep -Fq 'pkill -u "$UID"' scripts/dock
check "Fullscreen user-scoped cleanup" grep -Fq 'pkill -u "$UID"' scripts/fullscreen-toggle
check "Uninstall user-scoped cleanup" grep -Fq 'pkill -u "$UID"' uninstall.sh
check "Polybar target action opens terminal" grep -Fq 'Kali-Target -e settarget' config/polybar/config.ini
check "Polybar doctor action opens terminal" grep -Fq 'xLFr4n-Doctor -e doctor.sh' config/polybar/config.ini
check "Theme synchronizes Plank" grep -Fq 'PLANK_THEME' scripts/theme-switch
check "Theme feedback mentions Kitty reload" grep -Fq 'Ctrl+Shift+F5' scripts/theme-switch
check "VM-aware Picom backend" grep -Fq 'systemd-detect-virt' scripts/start-picom
check "VirtualBox guest helper" grep -Fq "VIRTUALBOX GUEST" scripts/vmware-tools
check "VMware guest helper" grep -Fq "VMWARE GUEST" scripts/vmware-tools
check "Wallpaper feedback" grep -Fq 'xLFr4n // WALLPAPER' scripts/wallpaper
check "Autostart stages workspace HUD" grep -Fq "workspace hud dispatched" scripts/autostart