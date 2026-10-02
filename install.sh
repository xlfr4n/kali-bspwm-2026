#!/usr/bin/env bash
# ⚡ xlfr4n // Kali BSPWM 2026
# Conservative installer: Kali packages first, backups first, reversible by design.

set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="$HOME/.kali-bspwm-backups/$STAMP"
CONFIG_DIR="$HOME/.config"
BIN_DIR="$HOME/.local/bin"
export PATH="$BIN_DIR:$PATH"

log(){ printf '[*] %s\n' "$*"; }
ok(){ printf '[+] %s\n' "$*"; }
warn(){ printf '[!] %s\n' "$*" >&2; }
die(){ printf '[-] %s\n' "$*" >&2; exit 1; }

MODE="${1:-full}"
case "$MODE" in
  full|--full) MODE="full" ;;
  --deploy) MODE="deploy" ;;
  --help|-h)
    printf 'Usage: ./install.sh [--full|--deploy]\n\n'
    printf '  --full    install/update packages, then deploy (default)\n'
    printf '  --deploy  deploy current config/scripts without running APT\n'
    exit 0
    ;;
  *) die "Unknown option: $MODE (use --help)" ;;
esac

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

if [ "$MODE" = "full" ]; then
  log "Updating Kali package metadata"
  sudo apt-get update
fi

HYPER="$(systemd-detect-virt 2>/dev/null || true)"
case "$HYPER" in
  vmware) HYPER="vmware" ;;
  oracle|virtualbox) HYPER="virtualbox" ;;
  none|'') HYPER="physical" ;;
  *) HYPER="other:$HYPER" ;;
esac
log "Virtualization detected: $HYPER"

# Core packages: the desktop cannot work without them, so a missing one aborts.
CORE_PACKAGES=(
  bspwm sxhkd polybar picom rofi dunst feh xclip xdotool wmctrl
  zsh git curl wget network-manager tmux
  x11-xserver-utils xserver-xorg
)

# Extra packages: nice to have. Kali Rolling renames/drops packages over time, so a
# missing one is skipped with a warning instead of failing the whole apt transaction.
EXTRA_PACKAGES=(
  zsh-autosuggestions zsh-syntax-highlighting
  network-manager-gnome
  fastfetch fzf ripgrep fd-find bat eza btop htop glances
  flameshot playerctl pamixer pavucontrol jq rsync unzip
  thunar arandr gpick neovim i3lock xss-lock brightnessctl lxpolkit
  lxappearance
  fonts-font-awesome fonts-jetbrains-mono
  xdg-utils
  libnotify-bin pipx python3-venv
  kali-tweaks kali-wallpapers-2026 kali-wallpapers-2023
  wireshark firefox-esr
)

PACKAGES=("${CORE_PACKAGES[@]}")
SKIPPED_PACKAGES=()
if [ "$MODE" = "full" ]; then
  for pkg in "${EXTRA_PACKAGES[@]}"; do
    if apt-cache show "$pkg" >/dev/null 2>&1; then
      PACKAGES+=("$pkg")
    else
      SKIPPED_PACKAGES+=("$pkg")
    fi
  done
  if [ "${#SKIPPED_PACKAGES[@]}" -gt 0 ]; then
    warn "Not available in this Kali snapshot (skipped): ${SKIPPED_PACKAGES[*]}"
  fi
fi

if [ "$HYPER" = "vmware" ]; then
  PACKAGES+=(open-vm-tools open-vm-tools-desktop)
elif [ "$HYPER" = "virtualbox" ]; then
  PACKAGES+=(virtualbox-guest-utils virtualbox-guest-x11)
fi

if [ "$MODE" = "full" ]; then
  log "Installing packages"
  sudo apt-get install -y "${PACKAGES[@]}"
fi

# Wireshark capture support: when Kali creates the dedicated group, add the current
# user so dumpcap can capture without launching the whole GUI as root. A new login
# (or reboot) is required before the supplementary group is active.
if [ "$MODE" = "full" ] && command -v wireshark >/dev/null 2>&1 && getent group wireshark >/dev/null 2>&1; then
  sudo usermod -aG wireshark "$USER" || warn "Could not add $USER to the wireshark group."
fi

if [ "$MODE" = "full" ] && ! command -v ghostty >/dev/null 2>&1; then
  log "Ghostty is not available from APT; using the official source bootstrap"
  bash "$ROOT_DIR/scripts/install-ghostty"
elif [ "$MODE" = "deploy" ] && ! command -v ghostty >/dev/null 2>&1; then
  die "Ghostty is required for --deploy. Run ./install.sh once to bootstrap it."
fi

if ! command -v ghostty >/dev/null 2>&1; then
  die "Ghostty is required by the xLFr4n terminal layer."
fi

if [ "$MODE" = "full" ]; then
  legacy_kitty_packages=()
  for pkg in kitty kitty-doc kitty-shell-integration kitty-terminfo; do
    if dpkg-query -W -f='${db:Status-Status}' "$pkg" 2>/dev/null | grep -qx 'installed'; then
      legacy_kitty_packages+=("$pkg")
    fi
  done
  if [ "${#legacy_kitty_packages[@]}" -gt 0 ]; then
    log "Removing legacy Kitty packages"
    sudo apt-get purge -y "${legacy_kitty_packages[@]}"
  fi
fi

if [ "$MODE" = "full" ]; then
  # Optional visual packages. Kali Rolling can remove individual desktop
  # packages over time, so their absence must never abort the base installer.
  OPTIONAL_PACKAGES=(tint2 plank papirus-icon-theme imagemagick)
  for optional in "${OPTIONAL_PACKAGES[@]}"; do
    if apt-cache show "$optional" >/dev/null 2>&1; then
      log "Installing optional package: $optional"
      sudo apt-get install -y "$optional" || warn "Optional package unavailable: $optional"
    else
      warn "Optional package not available in this Kali snapshot: $optional"
    fi
  done
fi

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
  "$CONFIG_DIR/ghostty" \
  "$CONFIG_DIR/tmux" \
  "$CONFIG_DIR/dunst" \
  "$CONFIG_DIR/plank" \
  "$CONFIG_DIR/tint2" \
  "$CONFIG_DIR/fastfetch" \
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

# Retire the old Kitty user configuration from the active session.
# It is backed up above so the change remains recoverable.
if [ -e "$CONFIG_DIR/kitty" ] || [ -L "$CONFIG_DIR/kitty" ]; then
  log "Removing retired Kitty user configuration"
  rm -rf "$CONFIG_DIR/kitty"
fi

log "Deploying BSPWM configuration"
mkdir -p "$CONFIG_DIR" "$BIN_DIR"

for dir in bspwm sxhkd polybar rofi picom ghostty tmux dunst plank tint2 fastfetch; do
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
sudo install -Dm755 "$ROOT_DIR/scripts/xLFr4n-dock-launch" /usr/local/bin/xLFr4n-dock-launch

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

if command -v brave-browser >/dev/null 2>&1 &&
   command -v xdg-settings >/dev/null 2>&1 &&
   [ -f "$HOME/.local/share/applications/xLFr4n-brave.desktop" ]; then
  xdg-settings set default-web-browser xLFr4n-brave.desktop >/dev/null 2>&1 || true
  command -v xdg-mime >/dev/null 2>&1 && {
    xdg-mime default xLFr4n-brave.desktop x-scheme-handler/http >/dev/null 2>&1 || true
    xdg-mime default xLFr4n-brave.desktop x-scheme-handler/https >/dev/null 2>&1 || true
    xdg-mime default xLFr4n-brave.desktop text/html >/dev/null 2>&1 || true
  }
fi

if [ "$MODE" = "full" ]; then
  if command -v desktop-style >/dev/null 2>&1; then
    desktop-style --apply --silent || warn "Desktop visual style could not be fully applied."
  fi

  if command -v dock >/dev/null 2>&1; then
    dock --start || warn "Floating dock could not be started during installation."
  fi
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

if [ "$MODE" = "full" ]; then
  if command -v wal >/dev/null 2>&1; then
    ok "pywal16 already available."
  elif python3 -m pipx install pywal16 >/dev/null 2>&1; then
    ok "Optional pywal16 installed in isolated pipx."
  else
    warn "pywal16 unavailable; static themes remain available."
  fi
fi

for cmd in bspwm sxhkd polybar ghostty rofi dunst picom feh xrandr dock tmux xlfr4n-terminal; do
  command -v "$cmd" >/dev/null 2>&1 || warn "Missing command after install: $cmd"
done

if command -v xlfr4n-terminal >/dev/null 2>&1; then
  ok "Terminal backend: $(xlfr4n-terminal --backend 2>/dev/null || printf 'unavailable')"
fi

ok "Deployment complete (mode=$MODE). Ghostty is the only supported graphical terminal."
ok "Backup: $BACKUP_DIR"
ok "Reboot and select 'bspwm' when ready."
ok "After login run: doctor.sh"
ok "Fast updates: ./install.sh --deploy"
