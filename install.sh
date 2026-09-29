#!/usr/bin/env bash
# ⚡ xlfr4n // Kali BSPWM 2026
# Conservative installer: Kali packages first, backups first, reversible by design.

set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="$HOME/.kali-bspwm-backups/$STAMP"
CONFIG_DIR="$HOME/.config"
BIN_DIR="$HOME/.local/bin"

log(){ printf '[*] %s\n' "$*"; }
ok(){ printf '[+] %s\n' "$*"; }
warn(){ printf '[!] %s\n' "$*" >&2; }
die(){ printf '[-] %s\n' "$*" >&2; exit 1; }

[ "$(id -u)" -ne 0 ] || die "Run this installer as your normal user, not root."
[ -f /etc/os-release ] || die "Cannot identify the operating system."
# shellcheck disable=SC1091
. /etc/os-release
[ "$ID" = "kali" ] || die "This project targets Kali Linux. Detected: ${PRETTY_NAME:-unknown}"

command -v sudo >/dev/null 2>&1 || die "sudo is required."
command -v apt-get >/dev/null 2>&1 || die "apt-get is required."
command -v systemd-detect-virt >/dev/null 2>&1 || die "systemd-detect-virt is required."

sudo -v
KEEPER_PID=""
cleanup(){ [ -z "$KEEPER_PID" ] || kill "$KEEPER_PID" 2>/dev/null || true; }
trap cleanup EXIT

while true; do
  sudo -n true
  sleep 45
done 2>/dev/null &
KEEPER_PID=$!

log "Updating Kali package metadata"
sudo apt-get update

HYPER="$(systemd-detect-virt 2>/dev/null || true)"
case "$HYPER" in
  vmware) HYPER="vmware" ;;
  oracle|virtualbox) HYPER="virtualbox" ;;
  none|'') HYPER="physical" ;;
  *) HYPER="other:$HYPER" ;;
esac
log "Virtualization detected: $HYPER"

PACKAGES=(
  bspwm sxhkd polybar picom kitty rofi dunst feh xclip xdotool wmctrl
  zsh zsh-autosuggestions zsh-syntax-highlighting git curl wget
  network-manager network-manager-gnome
  fastfetch fzf ripgrep fd-find bat eza btop htop glances
  flameshot playerctl pamixer pavucontrol jq rsync unzip
  thunar arandr gpick neovim tmux i3lock plank papirus-icon-theme
  x11-xserver-utils xserver-xorg lxappearance
  fonts-font-awesome fonts-jetbrains-mono
  xdg-utils
  libnotify-bin pipx python3-venv
  kali-tweaks kali-wallpapers-2026
)

if [ "$HYPER" = "vmware" ]; then
  PACKAGES+=(open-vm-tools open-vm-tools-desktop)
elif [ "$HYPER" = "virtualbox" ]; then
  PACKAGES+=(virtualbox-guest-utils virtualbox-guest-x11)
fi

log "Installing packages"
sudo apt-get install -y "${PACKAGES[@]}"

log "Creating backup: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

backup_path(){
  local p="$1"
  [ -e "$p" ] || [ -L "$p" ] || return 0
  local rel
  rel="$(realpath --relative-to="$HOME" "$p")"
  mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
  cp -a "$p" "$BACKUP_DIR/$rel"
}

for p in \
  "$CONFIG_DIR/bspwm" \
  "$CONFIG_DIR/sxhkd" \
  "$CONFIG_DIR/polybar" \
  "$CONFIG_DIR/rofi" \
  "$CONFIG_DIR/picom" \
  "$CONFIG_DIR/kitty" \
  "$CONFIG_DIR/dunst" \
  "$CONFIG_DIR/plank" \
  "$CONFIG_DIR/theme-state" \
  "$CONFIG_DIR/wallpaper-state" \
  "$HOME/.zshrc"
do
  backup_path "$p"
done

for p in "$HOME/.local/share/applications"/xLFr4n-*.desktop          "$HOME/.local/share/icons/hicolor/scalable/apps"/xlfr4n-*.svg; do
  [ -e "$p" ] || continue
  backup_path "$p"
done

log "Deploying BSPWM configuration"
mkdir -p "$CONFIG_DIR" "$BIN_DIR"

for dir in bspwm sxhkd polybar rofi picom kitty dunst plank; do
  if [ -L "$CONFIG_DIR/$dir" ]; then
    unlink "$CONFIG_DIR/$dir"
  elif [ -d "$CONFIG_DIR/$dir" ]; then
    # Older installers may have created user config as root. Normalize ownership
    # after the backup so future re-installs remain user-writable and reversible.
    sudo chown -R "$USER:$USER" "$CONFIG_DIR/$dir"
  fi
  mkdir -p "$CONFIG_DIR/$dir"
  cp -a "$ROOT_DIR/config/$dir/." "$CONFIG_DIR/$dir/"
done

if [ -L "$HOME/.zshrc" ]; then
  unlink "$HOME/.zshrc"
fi
install -Dm644 "$ROOT_DIR/config/zshrc" "$HOME/.zshrc"
cp -a "$ROOT_DIR/scripts/." "$BIN_DIR/"
chmod +x "$BIN_DIR"/* 2>/dev/null || true

mkdir -p "$HOME/.local/share/applications"
for desktop in "$ROOT_DIR"/config/applications/*.desktop; do
  install -Dm644 "$desktop" "$HOME/.local/share/applications/$(basename "$desktop")"
done

mkdir -p "$HOME/.local/share/icons/hicolor/scalable/apps"
for icon in "$ROOT_DIR"/config/icons/*.svg; do
  install -Dm644 "$icon" "$HOME/.local/share/icons/hicolor/scalable/apps/$(basename "$icon")"
done

ln -sfn "$BIN_DIR/settarget" "$BIN_DIR/st"
ln -sfn "$BIN_DIR/cleartarget" "$BIN_DIR/ct"

export PATH="$BIN_DIR:$PATH"

log "Registering BSPWM X11 session"
sudo install -Dm644 "$ROOT_DIR/config/bspwm.desktop" /usr/share/xsessions/bspwm.desktop

log "Configuring guest integration"
if [ "$HYPER" = "vmware" ]; then
  if sudo systemctl list-unit-files --type=service --no-legend 2>/dev/null | awk '{print $1}' | grep -qx 'open-vm-tools.service'; then
    sudo systemctl enable --now open-vm-tools.service || warn "open-vm-tools.service could not be started."
  else
    warn "VMware detected but open-vm-tools.service is not available."
  fi
elif [ "$HYPER" = "virtualbox" ]; then
  if sudo systemctl list-unit-files --type=service --no-legend 2>/dev/null | awk '{print $1}' | grep -qx 'virtualbox-guest-utils.service'; then
    sudo systemctl enable --now virtualbox-guest-utils.service || warn "virtualbox-guest-utils.service could not be started."
  elif sudo systemctl list-unit-files --type=service --no-legend 2>/dev/null | awk '{print $1}' | grep -qx 'vboxservice.service'; then
    sudo systemctl enable --now vboxservice.service || warn "vboxservice.service could not be started."
  else
    warn "VirtualBox detected but no supported Guest Utils service was found."
  fi
fi

fc-cache -f >/dev/null 2>&1 || true

if command -v desktop-style >/dev/null 2>&1; then
  desktop-style --apply --silent || warn "Desktop visual style could not be fully applied."
fi

if command -v dock >/dev/null 2>&1; then
  dock --start || warn "Plank dock could not be started during installation."
fi

if systemctl is-enabled display-manager.service >/dev/null 2>&1 || systemctl is-active display-manager.service >/dev/null 2>&1; then
  ok "Existing display manager preserved."
else
  warn "No active display-manager.service detected; start BSPWM through an existing X11 session manager."
fi

ZSH_BIN="$(command -v zsh || true)"
if [ -n "$ZSH_BIN" ] && [ "$SHELL" != "$ZSH_BIN" ]; then
  chsh -s "$ZSH_BIN" "$USER" || warn "Could not set zsh as the login shell."
fi

python3 -m pipx ensurepath >/dev/null 2>&1 || true

if command -v wal >/dev/null 2>&1; then
  ok "pywal16 already available."
elif python3 -m pipx install pywal16 >/dev/null 2>&1; then
  ok "Optional pywal16 installed in isolated pipx."
else
  warn "pywal16 unavailable; static themes remain available."
fi

for cmd in bspwm sxhkd polybar kitty rofi dunst picom feh xrandr plank; do
  command -v "$cmd" >/dev/null 2>&1 || warn "Missing command after install: $cmd"
done

ok "Installation complete."
ok "Backup: $BACKUP_DIR"
ok "Reboot and select 'bspwm'."
ok "After login run: doctor.sh"
