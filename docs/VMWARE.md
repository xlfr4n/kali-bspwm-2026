# VMware compatibility

The project is tuned for Kali Linux running as a guest.

Kali documents `open-vm-tools` and `open-vm-tools-desktop` as the standard VMware guest tooling. The installer detects VMware with `systemd-detect-virt` and enables those services when available.

For shared folders, Kali also provides additional VMware helpers through `kali-tweaks`.

## VM display

The monitor helper uses XRandR and never forces a custom resolution or refresh rate. This is intentional for VMware auto-resize and multi-monitor operation.

## VirtualBox-origin guests

A Kali VirtualBox image can be moved/converted into another hypervisor, but the guest tools need to match the hypervisor. Running this installer after the move lets the project detect the new virtualization environment and install the corresponding guest packages.
