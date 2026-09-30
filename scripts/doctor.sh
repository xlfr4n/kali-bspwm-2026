#!/usr/bin/env bash
# shellcheck disable=SC2317,SC2329
# ⚡ xlfr4n // Kali BSPWM 2026
# Diagnostics are read-only: this script never "fixes" a broken session.

set -u

ok=0
fail=0

check() {
  local label="$1"
  shift
  if "$@" >/dev/null 2>&1; then
    printf '[OK] %s\n' "$label"
    ok=$((ok + 1))
  else
    printf '[FAIL] %s\n' "$label"
    fail=$((fail + 1))
  fi
}

info() {
  printf '[INFO] %s\n' "$*"
}

x11_check() {
  [ "${XDG_SESSION_TYPE:-}" = "x11" ] || [ -n "${DISPLAY:-}" ]
}

bspwm_config_check() {
  [ -f "$HOME/.config/bspwm/bspwmrc" ] &&
  [ -f "$HOME/.config/sxhkd/sxhkdrc" ]
}

polybar_config_check() {
  [ -f "$HOME/.config/polybar/config.ini" ] &&
  [ -x "$HOME/.config/polybar/launch.sh" ]
}

visual_layout_check() {
  local cfg="$HOME/.config/polybar/config.ini"
  grep -Fq "[bar/main]" "$cfg" &&
  grep -Fq "background = #00000000" "$cfg" &&
  grep -Fq "border-size = 0pt" "$cfg" &&
  grep -Fq "[bar/workspace]" "$cfg" &&
  grep -Fq "border_width 0" "$HOME/.config/bspwm/bspwmrc" &&
  grep -Fq "bottom_padding 0" "$HOME/.config/bspwm/bspwmrc" &&
  grep -Fq "offset-y = 40pt" "$cfg" &&
  grep -Fq "label-focused-margin = 1" "$cfg" &&
  grep -Fq "modules-right = date time" "$cfg" &&
  grep -Fq "margin-bottom = 0pt" "$cfg"
}

workspace_hud_process_check() {
  local pid_file="$HOME/.cache/xlfr4n-workspace-hud.pid" pid
  [ -s "$pid_file" ] || return 1
  pid="$(cat "$pid_file" 2>/dev/null || true)"
  [[ "$pid" =~ ^[0-9]+$ ]] || return 1
  kill -0 "$pid" 2>/dev/null
}

dock_single_backend_check() {
  local active=0
  pgrep -u "$UID" -x tint2 >/dev/null 2>&1 && active=$((active + 1))
  pgrep -u "$UID" -x plank >/dev/null 2>&1 && active=$((active + 1))
  pgrep -u "$UID" -af '[p]olybar dock' >/dev/null 2>&1 && active=$((active + 1))
  [ "$active" -le 1 ]
}

rofi_launcher_files_check() {
  local app
  for app in     xLFr4n-kali-menu.desktop     xLFr4n-brave.desktop     xLFr4n-terminal.desktop     xLFr4n-files.desktop     xLFr4n-editor.desktop     xLFr4n-code.desktop     xLFr4n-burp.desktop     xLFr4n-lab.desktop     xLFr4n-target.desktop     xLFr4n-btop.desktop     xLFr4n-settings.desktop     xLFr4n-network.desktop     xLFr4n-screenshot.desktop
  do
    [ -s "$HOME/.local/share/applications/$app" ] || return 1
  done
}

rofi_theme_check() {
  rofi -no-config -theme "$HOME/.config/rofi/launcher.rasi" -dump-theme
}

theme_check() {
  local theme
  theme="$(cat "$HOME/.config/theme-state/current" 2>/dev/null || printf 'cyber-red')"
  case "$theme" in
    cyber-red|htb-green|nord|purple) return 0 ;;
    *) return 1 ;;
  esac
}

target_check() {
  [ ! -e "$HOME/.config/polybar/target" ] ||
  [ -f "$HOME/.config/polybar/target" ]
}

desktop_count_check() {
  local count
  count="$(bspc query -D 2>/dev/null | wc -l)"
  [ "$count" -eq 9 ]
}

virt="$(systemd-detect-virt 2>/dev/null || true)"

check "Kali Linux" grep -qi '^ID=kali$' /etc/os-release
check "X11 session" x11_check
check "BSPWM process" pgrep -x bspwm
check "SXHKD process" pgrep -x sxhkd
check "BSPWM command" command -v bspwm
check "SXHKD command" command -v sxhkd
check "Polybar" command -v polybar
check "Kitty" command -v kitty
check "Rofi" command -v rofi
check "Rofi theme" rofi_theme_check
check "Rofi xlfr4n wrapper" command -v rofi-xlfr4n
check "Picom" command -v picom
check "Dunst" command -v dunst
check "Dunst process" pgrep -u "$UID" -x dunst
check "Workspace HUD" command -v workspace-hud
check "Workspace HUD process" workspace_hud_process_check
check "Audio feedback" command -v audio-control
check "Network status helper" command -v network-status
check "Battery status helper" command -v battery-status
check "Desktop style helper" command -v desktop-style
check "Dock helper" command -v dock
check "Dock launcher" command -v dock-launch
check "Mission Control helper" command -v mission-control
check "Feh" command -v feh
check "xrandr" command -v xrandr
check "Flameshot" command -v flameshot
check "tmux" command -v tmux
check "Neovim" command -v nvim
check "xclip" command -v xclip
check "jq" command -v jq
check "Fullscreen toggle helper" command -v fullscreen-toggle
check "Target copy helper" command -v target-copy
check "xLFr4n pulse helper" command -v xlfr4n-pulse
check "xLFr4n terminal banner" command -v xlfr4n-banner
check "xLFr4n date helper" command -v xlfr4n-date
check "Fullscreen binding" grep -Fq "fullscreen-toggle" "$HOME/.config/sxhkd/sxhkdrc"
check "Target clipboard binding" grep -Fq "click-left = target-copy" "$HOME/.config/polybar/config.ini"
check "Eza or ls" sh -c 'command -v eza >/dev/null 2>&1 || command -v ls >/dev/null 2>&1'
check "Audio stack" sh -c 'command -v wpctl >/dev/null 2>&1 || command -v pactl >/dev/null 2>&1'
check "BSPWM config" bspwm_config_check
check "Polybar config" polybar_config_check
check "Final visual layout" visual_layout_check
check "Workspace rail spacing" grep -Fq "offset-y = 40pt" "$HOME/.config/polybar/config.ini"
check "BSPWM frameless windows" grep -Fq "border_width 0" "$HOME/.config/bspwm/bspwmrc"
check "Kitty frameless windows" grep -Fq "window_border_width 0" "$HOME/.config/kitty/kitty.conf"
check "Rofi frameless window" grep -Fq "border: 0px;" "$HOME/.config/rofi/launcher.rasi"
check "Tint2 frameless dock" grep -Fq "border_width = 0" "$HOME/.config/tint2/tint2rc"
check "Workspace rail process" workspace-rail --status
check "Polybar interactive status" grep -Fq "click-left = kitty --class xLFr4n-btop" "$HOME/.config/polybar/config.ini"
check "Date helper locale support" grep -Fq "LC_TIME" "$HOME/.local/bin/xlfr4n-date"
check "Single dock backend" dock_single_backend_check
check "Target helper" command -v settarget
check "Monitor helper" command -v monitor-refresh
check "Theme helper" command -v theme-switch
check "Wallpaper helper" command -v wallpaper
check "Kali menu" command -v kali-menu
check "Lab helper" command -v lab
check "Lock helper" command -v lock-screen
check "Virtualization helper" command -v vmware-tools
check "Session profiler" command -v session-profile
check "Theme state" theme_check
check "Target state" target_check
floating_dock_check() {
  [ -s "$HOME/.config/tint2/tint2rc" ] ||
  [ -s "$HOME/.config/plank/xLFr4n/dock.theme" ]
}

check "Floating dock configuration" floating_dock_check
check "Dock launchers" rofi_launcher_files_check
check "Notification sender" command -v notify-send
check "9 BSPWM desktops" desktop_count_check
check "BSPWM session file" test -f /usr/share/xsessions/bspwm.desktop
check "Zsh configuration" test -f "$HOME/.zshrc"
check "No red BSPWM window frame" grep -Fq "focused_border_color '#262a31'" "$HOME/.config/bspwm/bspwmrc"
check "No red Kitty window frame" grep -Fq "window_border_width 0" "$HOME/.config/kitty/kitty.conf"

if command -v tint2 >/dev/null 2>&1; then
  check "Tint2" command -v tint2
  check "Tint2 process" pgrep -u "$UID" -x tint2
fi

if command -v dock >/dev/null 2>&1; then
  info "floating dock backend: $(dock --backend 2>/dev/null || printf "unknown")"
fi

if [ -s "$HOME/.cache/xlfr4n-session.log" ]; then
  info "session log: $HOME/.cache/xlfr4n-session.log"
fi
info "virtualization: ${virt:-unknown}"
info "session: ${XDG_SESSION_TYPE:-unknown} DISPLAY=${DISPLAY:-unset}"

if [ "$virt" = "vmware" ]; then
  check "VMware tools service" systemctl is-active --quiet open-vm-tools
  check "VMware desktop integration" test -x /usr/bin/vmware-user
  if [ -d /mnt/hgfs ]; then
    info "VMware shared-folder mountpoint: /mnt/hgfs present"
  else
    info "VMware shared-folder mountpoint: /mnt/hgfs not present"
  fi
elif [ "$virt" = "oracle" ] || [ "$virt" = "virtualbox" ]; then
  check "VirtualBox Guest Utils" systemctl is-active --quiet virtualbox-guest-utils.service
  check "VBoxService binary" command -v VBoxService
  check "VBox guest modules" sh -c 'lsmod | grep -Eq "^vbox(guest|sf|video)[[:space:]]"'
fi

if [ -r "$HOME/.config/theme-state/current" ]; then
  info "theme: $(cat "$HOME/.config/theme-state/current" 2>/dev/null || true)"
fi

if [ -r "$HOME/.config/polybar/target" ]; then
  info "target: $(cat "$HOME/.config/polybar/target" 2>/dev/null || true)"
fi

printf '\nSummary: %d OK, %d FAIL\n' "$ok" "$fail"
exit $((fail > 0 ? 1 : 0))
