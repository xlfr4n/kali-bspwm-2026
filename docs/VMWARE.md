# VMware guest notes

This project is tuned for a Kali Linux X11 guest running under VMware Workstation/Fusion.

## Guest integration

On VMware guests the installer uses:

- open-vm-tools
- open-vm-tools-desktop

The installer detects VMware with `systemd-detect-virt` and only enables the VMware services when the guest is actually detected.

## First boot checklist

```bash
doctor.sh
systemd-detect-virt
systemctl is-active open-vm-tools
systemctl is-active open-vm-tools-desktop
xrandr --query
```

Expected virtualization output is `vmware`.

## Display behaviour

The desktop uses X11 because BSPWM is an X11 window manager. The monitor helper discovers connected X11 outputs with `xrandr`, makes the first output primary, places additional outputs to its right, and keeps workspaces 1-5 on the first monitor and 6-0 on the second when two displays are present.

For a single-display VM no special monitor configuration is required.

## Aesthetic layer

The look is built around:

- dark Kitty terminal with restrained transparency
- JetBrains Mono
- red-accent BSPWM borders
- Polybar with workspace, target, VPN, VMware, resource and active-window data
- Kali 2026 wallpapers when available
- fastfetch on interactive Kitty shells
- a two-line Zsh prompt with target and Git context
- optional tmux lab workspace with fastfetch + btop

No compositor blur is required, which keeps the visual layer conservative for virtual GPUs.

## Windows 11 host

Windows 11 remains the host operating system; this project only changes the Kali guest user's desktop configuration.
