# Kali BSPWM 2026

A clean, VM-aware BSPWM environment for Kali Linux 2026.x.

Designed primarily for the official Kali 2026.2 VMware guest, while also detecting and supporting VirtualBox guests. The project uses Kali packages first, keeps the existing audio/display stack, and creates timestamped backups before replacing user configuration.

## Features

- BSPWM + SXHKD
- Polybar
- Kitty
- Rofi
- Picom
- Dunst
- Zsh + autosuggestions + syntax highlighting
- Fastfetch, fzf, ripgrep, fd, bat, eza
- btop, htop, glances
- Flameshot, playerctl, pamixer, pavucontrol
- Target manager with Polybar display
- VPN/interface status
- Power menu
- Screenshot menu
- Theme selector: Cyber Red, HTB Green, Nord, Purple
- Multi-monitor refresh helper
- VMware / VirtualBox guest detection
- Safe timestamped backups
- Doctor/diagnostic command
- Optional pywal16 via pipx

## Supported target

- Kali Linux 2026.2 and newer Kali Rolling
- x86_64
- X11
- VMware Workstation/Fusion
- VirtualBox guests
- Physical installs can work, but the project is tuned for VMs

## Installation

Clone and run as your normal user:

```bash
git clone https://github.com/xlfr4n/kali-bspwm-2026.git
cd kali-bspwm-2026
chmod +x install.sh
./install.sh
```

Reboot and choose **bspwm** from the display manager.

After login:

```bash
doctor.sh
settarget 10.10.10.10 Web01
monitor-refresh
theme-switch
power-menu
```

## Keyboard shortcuts

- Super+Enter: Kitty
- Super+D: Rofi
- Super+Shift+D: Rofi command runner
- Super+1..0: desktops
- Super+Shift+1..0: move window
- Super+Arrow: focus
- Super+Shift+Arrow: swap
- Super+Alt+Arrow: resize floating
- Super+Ctrl+Arrow: move floating
- Super+F: fullscreen
- Super+S: floating
- Super+T: tiled
- Super+Shift+T: pseudo-tiled
- Super+M: monocle
- Super+G: swap with biggest
- Super+Alt+R: restart BSPWM
- Super+Alt+Q: logout
- Super+Alt+T: theme selector
- Super+Ctrl+T: theme selector
- Super+Shift+P: power menu
- Super+Shift+S: screenshot menu
- Super+Shift+M: monitor refresh
- Super+Ctrl+R: doctor
- Super+Ctrl+X: target prompt
- Print: full screenshot
- Shift+Print: screenshot UI
- XF86 audio keys: volume/mute

## Target workflow

```bash
settarget 10.10.10.10 Web01
settarget --status
cleartarget
```

The target is shown in Polybar and stored in `~/.config/polybar/target`.

## Virtualization

The installer detects the guest with `systemd-detect-virt`.

VMware installs/uses:

- open-vm-tools
- open-vm-tools-desktop

VirtualBox installs/uses:

- virtualbox-guest-utils
- virtualbox-guest-x11

The installer does **not** mask PipeWire or replace it with PulseAudio.

## Compatibility philosophy

The project intentionally avoids:

- remote `curl | sh` installers
- third-party Debian repositories
- unnecessary source builds of core Kali packages
- forcing a new display manager over an existing one
- system-wide `pip --break-system-packages`

Optional Python tooling is isolated with pipx.

## Restore

Every overwritten configuration is backed up under:

```
~/.kali-bspwm-backups/YYYYMMDD-HHMMSS/
```

To remove the environment and optionally restore the latest backup:

```bash
./uninstall.sh
```

## License

MIT.
