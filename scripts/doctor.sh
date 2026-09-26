#!/usr/bin/env bash
# shellcheck disable=SC2317
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
  [ "$count" -ge 10 ]
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
check "Picom" command -v picom
check "Dunst" command -v dunst
check "Feh" command -v feh
check "xrandr" command -v xrandr
check "Flameshot" command -v flameshot
check "tmux" command -v tmux
check "Neovim" command -v nvim
check "Eza or ls" sh -c 'command -v eza >/dev/null 2>&1 || command -v ls >/dev/null 2>&1'
check "Audio stack" sh -c 'command -v wpctl >/dev/null 2>&1 || command -v pactl >/dev/null 2>&1'
check "BSPWM config" bspwm_config_check
check "Polybar config" polybar_config_check
check "Target helper" command -v settarget
check "Monitor helper" command -v monitor-refresh
check "Theme helper" command -v theme-switch
check "Wallpaper helper" command -v wallpaper
check "Kali menu" command -v kali-menu
check "Lab helper" command -v lab
check "Lock helper" command -v lock-screen
check "VMware helper" command -v vmware-tools
check "Theme state" theme_check
check "Target state" target_check
check "10 BSPWM desktops" desktop_count_check
check "BSPWM session file" test -f /usr/share/xsessions/bspwm.desktop
check "Zsh configuration" test -f "$HOME/.zshrc"

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
fi

if [ -r "$HOME/.config/theme-state/current" ]; then
  info "theme: $(cat "$HOME/.config/theme-state/current" 2>/dev/null || true)"
fi

if [ -r "$HOME/.config/polybar/target" ]; then
  info "target: $(cat "$HOME/.config/polybar/target" 2>/dev/null || true)"
fi

printf '\nSummary: %d OK, %d FAIL\n' "$ok" "$fail"
exit $((fail > 0 ? 1 : 0))
