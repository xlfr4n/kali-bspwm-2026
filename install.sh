#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="$HOME/.kali-bspwm-backups/$STAMP"
CONFIG_DIR="$HOME/.config"
BIN_DIR="$HOME/.local/bin"

red='\033[1;31m'; green='\033[1;32m'; cyan='\033[1;36m'; yellow='\033[1;33m'; reset='\033[0m'
log(){ printf '%b[*]%b %s\n' "$cyan" "$reset" "$*"; }
ok(){ printf '%b[+]%b %s\n' "$green" "$reset" "$*"; }
warn(){ printf '%b[!]%b %s\n' "$yellow" "$reset" "$*"; }
die(){ printf '%b[-]%b %s\n' "$red" "$reset" "$*" >&2; exit 1; }

[ "$(id -u)" -ne 0 ] || die "Run this installer as your normal user, not root."
[ -f /etc/os-release ] || die "Cannot identify the operating system."
. /etc/os-release
[ "$ID" = "kali" ] || die "This project targets Kali Linux. Detected: ${PRETTY_NAME:-unknown}"

sudo -v
KEEPER_PID=""
cleanup(){ [ -z "$KEEPER_PID" ] || kill "$KEEPER_PID" 2>/dev/null || true; }
trap cleanup EXIT
while true; do sudo -n true; sleep 45; done 2>/dev/null &
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
  x11-xserver-utils xserver-xorg lxappearance fonts-font-awesome fonts-jetbrains-mono
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
  [ -e "$p" ] && [ ! -L "$p" ] || return 0
  local rel
  rel="$(realpath --relative-to="$HOME" "$p")"
  mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
  cp -a "$p" "$BACKUP_DIR/$rel"
}

for p in "$CONFIG_DIR/bspwm" "$CONFIG_DIR/sxhkd" "$CONFIG_DIR/polybar"          "$CONFIG_DIR/rofi" "$CONFIG_DIR/picom" "$CONFIG_DIR/kitty"          "$CONFIG_DIR/dunst" "$HOME/.zshrc"; do
  backup_path "$p"
done

log "Deploying BSPWM configuration"
mkdir -p "$CONFIG_DIR" "$BIN_DIR"
cp -a "$ROOT_DIR/config/." "$CONFIG_DIR/"
cp -a "$ROOT_DIR/scripts/." "$BIN_DIR/"
chmod +x "$BIN_DIR"/* 2>/dev/null || true
ln -sfn "$BIN_DIR/settarget" "$BIN_DIR/st"
ln -sfn "$BIN_DIR/cleartarget" "$BIN_DIR/ct"

log "Registering BSPWM X11 session"
sudo install -Dm644 "$ROOT_DIR/config/bspwm.desktop" /usr/share/xsessions/bspwm.desktop

log "Configuring guest integration"
if [ "$HYPER" = "vmware" ]; then
  sudo systemctl enable --now open-vm-tools.service || warn "open-vm-tools.service could not be started."
  sudo systemctl enable --now open-vm-tools-desktop.service || warn "open-vm-tools-desktop.service could not be started."
elif [ "$HYPER" = "virtualbox" ]; then
  sudo systemctl enable --now vboxservice.service || warn "vboxservice.service could not be started."
fi

fc-cache -f >/dev/null 2>&1 || true

if systemctl is-enabled display-manager.service >/dev/null 2>&1 || systemctl is-active display-manager.service >/dev/null 2>&1; then
  ok "Existing display manager preserved."
else
  warn "No active display-manager.service detected."
fi

sudo apt-get install -y pipx python3-venv
export PATH="$BIN_DIR:$PATH"
export PIPX_HOME="$HOME/.local/pipx"
export PIPX_BIN_DIR="$BIN_DIR"
python3 -m pipx ensurepath >/dev/null 2>&1 || true

if command -v wal >/dev/null 2>&1; then
  ok "pywal16 already available."
elif python3 -m pipx install pywal16 >/dev/null 2>&1; then
  ok "Optional pywal16 installed in isolated pipx."
else
  warn "pywal16 unavailable; static themes remain available."
fi

ok "Installation complete."
ok "Backup: $BACKUP_DIR"
ok "Reboot and select 'bspwm'."
ok "After login run: doctor.sh"
