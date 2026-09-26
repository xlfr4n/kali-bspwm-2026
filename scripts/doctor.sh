#!/usr/bin/env bash
set -u
ok=0
fail=0
check(){
  local label="$1" cmd="$2"
  if eval "$cmd" >/dev/null 2>&1; then printf '[OK] %s\n' "$label"; ok=$((ok+1)); else printf '[FAIL] %s\n' "$label"; fail=$((fail+1)); fi
}
session_type="$(printenv XDG_SESSION_TYPE 2>/dev/null || true)"
display="$(printenv DISPLAY 2>/dev/null || true)"
virt="$(systemd-detect-virt 2>/dev/null || true)"
check "Kali Linux" 'grep -qi "^ID=kali" /etc/os-release'
check "X11 session" '[ "$session_type" = "x11" ] || [ -n "$display" ]'
check "bspwm" 'command -v bspwm'
check "sxhkd" 'command -v sxhkd'
check "polybar" 'command -v polybar'
check "kitty" 'command -v kitty'
check "rofi" 'command -v rofi'
check "picom" 'command -v picom'
check "dunst" 'command -v dunst'
check "Audio stack available" 'command -v wpctl || command -v pactl'
check "BSPWM config" '[ -f "$HOME/.config/bspwm/bspwmrc" ] && [ -f "$HOME/.config/sxhkd/sxhkdrc" ]'
check "Polybar config" '[ -f "$HOME/.config/polybar/config.ini" ]'
check "Target helper" 'command -v settarget'
check "Monitor helper" 'command -v monitor-refresh'
check "Theme helper" 'command -v theme-switch'
printf '[INFO] virtualization: %s\n' "$virt"
if [ "$virt" = "vmware" ]; then check "VMware tools service" 'systemctl is-active --quiet open-vm-tools'; fi
printf '\nSummary: %d OK, %d FAIL\n' "$ok" "$fail"
exit $((fail > 0 ? 1 : 0))
