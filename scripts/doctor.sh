#!/usr/bin/env bash
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

# shellcheck disable=SC2317
x11_check() {
  [ "${XDG_SESSION_TYPE:-}" = "x11" ] || [ -n "${DISPLAY:-}" ]
}

# shellcheck disable=SC2317
bspwm_config_check() {
  [ -f "$HOME/.config/bspwm/bspwmrc" ] &&
    [ -f "$HOME/.config/sxhkd/sxhkdrc" ]
}

# shellcheck disable=SC2317
polybar_config_check() {
  [ -f "$HOME/.config/polybar/config.ini" ]
}

virt="$(systemd-detect-virt 2>/dev/null || true)"

check "Kali Linux" grep -qi '^ID=kali$' /etc/os-release
check "X11 session" x11_check
check "bspwm" command -v bspwm
check "sxhkd" command -v sxhkd
check "polybar" command -v polybar
check "kitty" command -v kitty
check "rofi" command -v rofi
check "picom" command -v picom
check "dunst" command -v dunst
check "Audio stack available" sh -c 'command -v wpctl >/dev/null 2>&1 || command -v pactl >/dev/null 2>&1'
check "BSPWM config" bspwm_config_check
check "Polybar config" polybar_config_check
check "Target helper" command -v settarget
check "Monitor helper" command -v monitor-refresh
check "Theme helper" command -v theme-switch
check "Wallpaper helper" command -v wallpaper
check "Lab helper" command -v lab
check "Lock helper" command -v lock-screen

printf '[INFO] virtualization: %s\n' "$virt"

if [ "$virt" = "vmware" ]; then
  check "VMware tools service" systemctl is-active --quiet open-vm-tools
  check "VMware desktop service" systemctl is-active --quiet open-vm-tools-desktop
fi

printf '\nSummary: %d OK, %d FAIL\n' "$ok" "$fail"
exit $((fail > 0 ? 1 : 0))
