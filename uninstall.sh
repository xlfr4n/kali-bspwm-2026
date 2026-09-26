#!/usr/bin/env bash
# ⚡ xlfr4n // Kali BSPWM 2026
# Removes only this project's user/session layer. Packages are intentionally left installed.

set -Eeuo pipefail

[ "$(id -u)" -ne 0 ] || {
  echo "Run as a normal user."
  exit 1
}

for proc in sxhkd polybar dunst nm-applet picom; do
  pkill -x "$proc" 2>/dev/null || true
done

latest_backup="$(find "$HOME/.kali-bspwm-backups" \
  -mindepth 1 -maxdepth 1 -type d \
  -printf '%T@ %p\n' 2>/dev/null |
  sort -nr |
  sed 's/^[^ ]* //' |
  head -1 || true)"

if [ -n "$latest_backup" ]; then
  echo "Latest backup: $latest_backup"
  read -r -p "Restore this backup before removing the environment? [y/N] " ans
  if [[ "$ans" =~ ^[Yy]$ ]]; then
    cp -a "$latest_backup/." "$HOME/"
    echo "Backup restored."
  fi
fi

rm -rf \
  "$HOME/.config/bspwm" \
  "$HOME/.config/sxhkd" \
  "$HOME/.config/polybar" \
  "$HOME/.config/rofi" \
  "$HOME/.config/picom" \
  "$HOME/.config/kitty" \
  "$HOME/.config/dunst" \
  "$HOME/.config/theme-state" \
  "$HOME/.config/wallpaper-state"

rm -f \
  "$HOME/.config/zshrc" \
  "$HOME/.local/bin/settarget" \
  "$HOME/.local/bin/cleartarget" \
  "$HOME/.local/bin/st" \
  "$HOME/.local/bin/ct" \
  "$HOME/.local/bin/monitor-refresh" \
  "$HOME/.local/bin/theme-switch" \
  "$HOME/.local/bin/power-menu" \
  "$HOME/.local/bin/screenshot-menu" \
  "$HOME/.local/bin/keyboard" \
  "$HOME/.local/bin/start-picom" \
  "$HOME/.local/bin/doctor.sh" \
  "$HOME/.local/bin/wallpaper" \
  "$HOME/.local/bin/lab" \
  "$HOME/.local/bin/lock-screen" \
  "$HOME/.local/bin/session-reload" \
  "$HOME/.local/bin/autostart" \
  "$HOME/.local/bin/kali-menu" \
  "$HOME/.local/bin/vmware-tools"

sudo rm -f /usr/share/xsessions/bspwm.desktop

printf 'Kali BSPWM user configuration removed. Packages were intentionally left installed.\n'
printf 'Your timestamped backups remain under ~/.kali-bspwm-backups/.\n'
