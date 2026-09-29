#!/usr/bin/env bash
# ⚡ xlfr4n // Kali BSPWM 2026
# Removes only this project's user/session layer. Packages are intentionally left installed.

set -Eeuo pipefail

[ "$(id -u)" -ne 0 ] || {
  echo "Run as a normal user."
  exit 1
}

for proc in sxhkd polybar dunst nm-applet picom plank; do
  pkill -x "$proc" 2>/dev/null || true
done
pkill -f '[p]olybar dock' 2>/dev/null || true

latest_backup="$(find "$HOME/.kali-bspwm-backups"   -mindepth 1 -maxdepth 1 -type d   -printf '%T@ %p
' 2>/dev/null |
  sort -nr |
  sed 's/^[^ ]* //' |
  head -1 || true)"

restore=0
if [ -n "$latest_backup" ]; then
  echo "Latest backup: $latest_backup"
  read -r -p "Restore this backup after removing the xlfr4n layer? [y/N] " ans
  [[ "$ans" =~ ^[Yy]$ ]] && restore=1
fi

rm -rf   "$HOME/.config/bspwm"   "$HOME/.config/sxhkd"   "$HOME/.config/polybar"   "$HOME/.config/rofi"   "$HOME/.config/picom"   "$HOME/.config/kitty"   "$HOME/.config/dunst"   "$HOME/.config/plank"   "$HOME/.config/theme-state"   "$HOME/.config/wallpaper-state"

rm -f   "$HOME/.local/bin/settarget"   "$HOME/.local/bin/cleartarget"   "$HOME/.local/bin/st"   "$HOME/.local/bin/ct"   "$HOME/.local/bin/monitor-refresh"   "$HOME/.local/bin/theme-switch"   "$HOME/.local/bin/power-menu"   "$HOME/.local/bin/screenshot-menu"   "$HOME/.local/bin/keyboard"   "$HOME/.local/bin/start-picom"   "$HOME/.local/bin/doctor.sh"   "$HOME/.local/bin/wallpaper"   "$HOME/.local/bin/lab"   "$HOME/.local/bin/lock-screen"   "$HOME/.local/bin/session-reload"   "$HOME/.local/bin/autostart"   "$HOME/.local/bin/kali-menu"   "$HOME/.local/bin/vmware-tools"   "$HOME/.local/bin/dock"   "$HOME/.local/bin/mission-control"   "$HOME/.local/bin/desktop-style"

sudo rm -f /usr/share/xsessions/bspwm.desktop

rm -f "$HOME/.local/share/applications"/xLFr4n-*.desktop
rm -f "$HOME/.local/share/icons/hicolor/scalable/apps"/xlfr4n-*.svg

# The installer owns this deployed file; restore the user's previous copy below when requested.
rm -f "$HOME/.zshrc"

if [ "$restore" -eq 1 ]; then
  cp -a "$latest_backup/." "$HOME/"
  echo "Backup restored."
fi

printf 'Kali BSPWM user configuration removed. Packages were intentionally left installed.\n'
printf 'Your timestamped backups remain under ~/.kali-bspwm-backups/.\n'
