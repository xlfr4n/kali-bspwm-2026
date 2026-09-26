# Kali BSPWM 2026

A clean, VM-aware BSPWM environment for Kali Linux 2026.x, inspired by the modern Kali/HTB BSPWM aesthetic: dark terminal, crisp accent colors, fastfetch, tiling workflows, target awareness and a dense but readable system bar.

The project is tuned for a Kali X11 guest under VMware while retaining VirtualBox detection/support.

## Visual + functional layer

- BSPWM + SXHKD with predictable Super-key controls
- Polybar with workspaces, target, VPN, hypervisor, CPU/RAM/disk/network/audio, active window and clock
- Kitty with JetBrains Mono, restrained transparency and VM-friendly X11 settings
- Fastfetch automatically on the first interactive shell in Kitty
- Two-line Zsh prompt with Git branch and active target
- Kali 2026 wallpapers with random/next/set controls
- Rofi launcher, Dunst notifications and Picom
- Thunar, Arandr and Gpick utility shortcuts
- tmux-based `lab` workspace with fastfetch + btop panes
- i3lock screen lock
- Target manager and HTB/case workspace helpers
- Cyber Red, HTB Green, Nord and Purple themes
- Multi-monitor refresh and VMware-aware networking
- Timestamped backups and reversible uninstall
- Optional pywal16 isolated through pipx

## Supported target

- Kali Linux 2026.2 and newer Kali Rolling
- x86_64
- X11
- VMware Workstation/Fusion
- VirtualBox
- Physical installs may work, but the project is tuned for VMs

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
wallpaper --random
theme-switch
lab
```

## Keyboard shortcuts

| Shortcut | Action |
|---|---|
| Super+Enter | Kitty |
| Super+D | App launcher |
| Super+Shift+D | Command runner |
| Super+1..0 | Desktop |
| Super+Shift+1..0 | Move window |
| Super+Arrow | Focus |
| Super+Shift+Arrow | Swap |
| Super+Alt+Arrow | Resize floating |
| Super+Ctrl+Arrow | Move floating |
| Super+F | Fullscreen |
| Super+S | Floating |
| Super+T | Tiled |
| Super+Shift+T | Pseudo-tiled |
| Super+M | Monocle |
| Super+G | Swap with biggest |
| Super+Alt+R | Restart BSPWM |
| Super+Alt+Q | Logout |
| Super+Alt+T / Super+Ctrl+T | Theme selector |
| Super+Shift+W | Random wallpaper |
| Super+Ctrl+W | Next wallpaper |
| Super+Shift+L | Kali lab terminal |
| Super+Shift+E | Thunar |
| Super+Shift+P | Power menu |
| Super+Shift+S | Screenshot menu |
| Super+Shift+M | Refresh monitors |
| Super+Ctrl+R | Doctor in Kitty |
| Super+Ctrl+X | Target prompt |
| Super+Shift+K | Lock screen |
| Super+Shift+F | Firefox |
| Super+Shift+B | Burp Suite |
| Super+Shift+C | VS Code |
| Super+Shift+N | Neovim |
| Print | Full screenshot |
| Shift+Print | Screenshot UI |
| XF86 audio keys | Volume/mute |

## Target workflow

```bash
settarget 10.10.10.10 Web01
settarget --status
cleartarget
```

The target is shown in Polybar and the Zsh prompt and stored in `~/.config/polybar/target`.

## VMware

VMware guests use `open-vm-tools` and `open-vm-tools-desktop`. See [docs/VMWARE.md](docs/VMWARE.md) for the guest checklist.

VirtualBox guests use the corresponding guest utilities when detected.

## Design constraints

The installer intentionally does not:

- use remote `curl | sh` installers
- add third-party Debian repositories
- mask PipeWire or replace the audio stack
- build unnecessary core packages from source
- force a new display manager over an existing one
- use system-wide `pip --break-system-packages`

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
