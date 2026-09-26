# 🐉 Kali BSPWM 2026

> 🖥️ **Modern BSPWM environment for Kali Linux, tuned for VMware.**  
> 🖥️ **Entorno BSPWM moderno para Kali Linux, optimizado para VMware.**

[![ShellCheck](https://img.shields.io/github/actions/workflow/status/xlfr4n/kali-bspwm-2026/shellcheck.yml?label=ShellCheck&logo=github)](https://github.com/xlfr4n/kali-bspwm-2026/actions)
![Kali](https://img.shields.io/badge/Kali-Linux-557C94?style=for-the-badge&logo=kalilinux&logoColor=white)
![BSPWM](https://img.shields.io/badge/BSPWM-0.9.x-111827?style=for-the-badge)
![VMware](https://img.shields.io/badge/VMware-Guest-607078?style=for-the-badge)

## 🇪🇸 Español

### 🎯 Objetivo

Un escritorio **Kali + BSPWM** con estética cyber/HTB y funcionalidades prácticas para una VM VMware bajo Windows 11.

El host es Windows; este proyecto solo modifica el guest Kali.

### 🎨 Estética

- 🖥️ BSPWM + SXHKD
- 🐱 Kitty + JetBrains Mono
- 📊 Polybar densa y limpia
- 🚀 Fastfetch
- 🎯 Target visible en Polybar y Zsh
- 🌐 VPN + red + hipervisor
- 🖼️ Wallpapers Kali
- 🎨 Themes: Cyber Red, HTB Green, Nord, Purple
- 🌫️ Picom sin blur obligatorio para conservar compatibilidad con GPU virtual

### 🧰 Funciones

- 🚀 Rofi launcher
- 🔔 Dunst
- 📸 Flameshot
- 🔊 audio + Pavucontrol
- 🗂️ Thunar / Arandr / Gpick
- 🧪 `lab` con tmux + fastfetch + btop
- 🔐 bloqueo de pantalla
- 🖥️ refresh multi-monitor
- 🎯 `settarget` / `cleartarget`
- 🩺 `doctor.sh`
- ♻️ backups con timestamp y uninstall reversible
- 🐍 pywal16 opcional vía pipx

### ⌨️ Atajos principales

| Tecla | Acción |
|---|---|
| Super+Enter | Kitty |
| Super+D | Launcher |
| Super+1..0 | Escritorios |
| Super+Arrow | Focus |
| Super+Shift+Arrow | Swap |
| Super+F | Fullscreen |
| Super+S | Floating |
| Super+M | Monocle |
| Super+Alt+T | Themes |
| Super+Shift+W | Wallpaper aleatorio |
| Super+Shift+L | Kali Lab |
| Super+Shift+K | Lock |
| Super+Shift+P | Power |
| Super+Shift+S | Screenshot |

### 🚀 Instalación

```bash
git clone https://github.com/xlfr4n/kali-bspwm-2026.git
cd kali-bspwm-2026
chmod +x install.sh
./install.sh
```

Después:

```bash
doctor.sh
systemd-detect-virt
systemctl is-active open-vm-tools
systemctl is-active open-vm-tools-desktop
xrandr --query
```

### 🖥️ VMware

Cuando detecta VMware instala y activa:

`open-vm-tools` + `open-vm-tools-desktop`

Cuando detecta VirtualBox utiliza los paquetes guest correspondientes.

### 🛡️ Filosofía

- ❌ No `curl | sh`
- ❌ No repositorios Debian de terceros
- ❌ No reemplazo forzado de PipeWire
- ❌ No `pip --break-system-packages`
- ✅ Paquetes Kali primero
- ✅ Backup antes de reemplazar configuración
- ✅ Rollback mediante uninstall

### 🧪 Estado

La **primera prueba real dentro de VMware** sigue pendiente. La instalación y el aspecto final deben validarse sobre tu guest real antes de marcar compatibilidad de runtime como cerrada.

---

## 🇬🇧 English

### 🎯 Goal

A modern **Kali + BSPWM** desktop with a cyber/HTB visual style and practical workflows for a VMware guest running on Windows 11.

The Windows host is untouched; the project only changes the Kali guest.

### 🎨 Visual layer

BSPWM, SXHKD, Kitty, JetBrains Mono, Polybar, fastfetch, target/VPN/hypervisor indicators, Kali wallpapers, four themes and VM-friendly Picom settings.

### 🧰 Features

Rofi, Dunst, Flameshot, audio controls, Thunar, Arandr, Gpick, tmux-based lab workspace, screen locking, monitor refresh, target helpers, diagnostics, timestamped backups, reversible uninstall and optional pywal16.

### 🚀 Installation

```bash
git clone https://github.com/xlfr4n/kali-bspwm-2026.git
cd kali-bspwm-2026
chmod +x install.sh
./install.sh
```

After reboot, select **bspwm** and run `doctor.sh`.

### 🖥️ VMware compatibility

VMware guests use `open-vm-tools` and `open-vm-tools-desktop`. VirtualBox guests use the corresponding guest packages when detected.

### 🛡️ Design principles

No remote shell installers, no third-party Debian repositories, no forced PipeWire replacement, no system-wide `pip --break-system-packages`, and all overwritten user configuration is backed up before deployment.

### 🧪 Validation status

The first runtime test inside the real VMware Kali guest is still pending. Static project validation is not a substitute for that live VM test.

## 📌 Project identity

🐉 **Kali BSPWM 2026**  
🖥️ **Windows 11 host → VMware → Kali guest**  
🎨 **Cyber / HTB / minimalist dark UI**  
🌍 **Documentation / Documentación:** ES + EN

---

## ⚡ xlfr4n // Signature

<p align="center">
  <a href="./BRAND.md">🧩 Project identity / Identidad del proyecto</a> · <a href="https://github.com/xlfr4n">⚡ xlfr4n</a>
  <br><sub>Build it. Understand it. Automate it. Document it. · Hazlo. Entiéndelo. Automatízalo. Documéntalo.</sub>
</p>
