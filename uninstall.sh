#!/usr/bin/env bash
set -Eeuo pipefail
[ "$(id -u)" -ne 0 ] || { echo "Run as a normal user."; exit 1; }
latest_backup="$(find "$HOME/.kali-bspwm-backups" -mindepth 1 -maxdepth 1 -type d -printf '%T@ %p\n' 2>/dev/null | sort -nr | sed 's/^[^ ]* //' | head -1 || true)"
if [ -n "$latest_backup" ]; then
  echo "Latest backup: $latest_backup"
  read -r -p "Restore this backup before removing the environment? [y/N] " ans
  if [[ "$ans" =~ ^[Yy]$ ]]; then cp -a "$latest_backup/." "$HOME/"; echo "Backup restored."; fi
fi
rm -rf "$HOME/.config/bspwm" "$HOME/.config/sxhkd" "$HOME/.config/polybar" "$HOME/.config/rofi" "$HOME/.config/picom" "$HOME/.config/kitty" "$HOME/.config/dunst" "$HOME/.config/theme-state" "$HOME/.config/wallpaper-state"
rm -f "$HOME/.local/bin"/{settarget,cleartarget,st,ct,monitor-refresh,theme-switch,power-menu,screenshot-menu,keyboard,start-picom,doctor.sh,wallpaper,lab,lock-screen,session-reload}
sudo rm -f /usr/share/xsessions/bspwm.desktop
printf 'Kali BSPWM user configuration removed. Package removal was intentionally not automatic.\n'
