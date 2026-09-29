
# 🐉 Kali BSPWM 2026

> 🖥️ **Modern BSPWM environment for Kali Linux, tuned for VirtualBox and VMware.**  
> 🖥️ **Entorno BSPWM moderno para Kali Linux, preparado para VirtualBox y VMware.**

[![ShellCheck](https://img.shields.io/github/actions/workflow/status/xlfr4n/kali-bspwm-2026/shellcheck.yml?label=ShellCheck&logo=github)](https://github.com/xlfr4n/kali-bspwm-2026/actions)
![Kali](https://img.shields.io/badge/Kali-Linux-557C94?style=for-the-badge&logo=kalilinux&logoColor=white)
![BSPWM](https://img.shields.io/badge/BSPWM-0.9.x-111827?style=for-the-badge)
![X11](https://img.shields.io/badge/X11-session-111827?style=for-the-badge)
![xlfr4n](https://img.shields.io/badge/identity-xlfr4n-ff3344?style=for-the-badge)

---

## 🇪🇸 Español

### 🎯 Objetivo

**Kali BSPWM 2026** es la configuración de escritorio `Kali + BSPWM + SXHKD` de **⚡ xlfr4n**, diseñada para una VM Linux de laboratorio con una interfaz cyber oscura, atajos rápidos y herramientas prácticas.

El proyecto modifica el **guest Kali**. El host Windows/VirtualBox/VMware no se configura automáticamente.

### 🍎 xLFr4n Floating Workspace

### 🇪🇸 Español

La edición actual añade una capa de escritorio inspirada en la ergonomía de macOS sin abandonar **BSPWM + SXHKD**: **Polybar flotante**, **dock Tint2 con iconos reales**, **Spotlight** (`+Super + Space`), **Mission Control** (`+Super + Shift + Space`), acceso directo a **Brave** (`+Super + Ctrl + B`), iconos propios de xLFr4n y controles GTK hacia la izquierda cuando la aplicación los respeta.

El objetivo es que la VM no parezca una instalación genérica: debe sentirse como un **workspace personal de xLFr4n**, manteniendo la ligereza, los backups y la capacidad de diagnóstico.

### 🇬🇧 English

The current edition adds a macOS-inspired ergonomics layer without leaving **BSPWM + SXHKD**: a **floating Polybar**, **real-icon Tint2 dock (with Plank/Polybar fallback)**, **Spotlight** (`+Super + Space`), **Mission Control** (`+Super + Shift + Space`), **Brave** quick launch (`+Super + Ctrl + B`), custom xLFr4n icons and left-side GTK controls where supported.

The goal is to make the VM feel like a **personal xLFr4n workspace**, while keeping the environment lightweight, backed up and diagnosable.

### ⚡ New visual controls

The top bar is intentionally compact. Workspaces **1→9** and the clock live in a dedicated bottom-right glass bar. The bottom-center dock uses real application icons through Tint2 when available, with Plank/Polybar fallback. Network state is integrated into the top-right Polybar module instead of a separate `nm-applet` tray icon.

La barra superior queda deliberadamente limpia. Los escritorios **1→9** y la hora viven en una barra de cristal abajo a la derecha. El dock inferior central utiliza iconos reales mediante Tint2 cuando está disponible, con respaldo Plank/Polybar. El estado de red queda integrado arriba a la derecha en Polybar, sin un icono `nm-applet` separado.


| Shortcut | Action |
|---|---|
| `+Super + Space` | Spotlight / applications |
| `+Super + Shift + Space` | Mission Control |
| `+Super + Shift + A` | Toggle floating icon dock |
| `+Super + Shift + O` | Mission Control |
| `+Super + Ctrl + B` | Open Brave |
| `+Super + F` | Reliable fullscreen toggle; hides desktop chrome |

---

## 🧩 Stack

- BSPWM + SXHKD
- Polybar
- Kitty + JetBrains Mono
- Rofi
- Picom
- Dunst
- Feh + wallpapers
- NetworkManager + integrated network status
- xLFr4n animated terminal banner, FZF, ripgrep, fd, bat, eza, btop, htop, glances
- Flameshot
- Thunar, Arandr, Gpick
- Neovim + tmux
- Pavucontrol + pamixer
- i3lock / xss-lock
- VirtualBox Guest Utils o VMware Tools según virtualización detectada
- pywal16 opcional y aislado mediante pipx

### 🎨 Identidad xlfr4n

La interfaz utiliza una identidad común:

`⚡ xlfr4n // Kali`

Incluye:

- cyber-red
- HTB green
- Nord
- Purple
- indicadores de target, VPN y virtualización
- menú central `xlfr4n // Kali`
- backups timestamped
- rollback reversible
- diagnóstico de solo lectura

### 🚀 Instalación

~~~bash
git clone https://github.com/xlfr4n/kali-bspwm-2026.git
cd kali-bspwm-2026
chmod +x install.sh uninstall.sh
./install.sh
~~~

Después reinicia y selecciona **BSPWM** en el gestor de sesiones.

Diagnóstico:

~~~bash
doctor.sh
~~~

### 🔄 Actualizar Kali

Para actualizar todo el sistema:

~~~bash
sudo apt update && sudo apt full-upgrade -y
~~~

Comprobar si se necesita reinicio:

~~~bash
[ -f /var/run/reboot-required ] && echo "REBOOT REQUIRED"
~~~

No se recomienda ejecutar `apt autoremove` automáticamente como parte de la actualización.

### 🖥️ VirtualBox

En Kali actual, la integración se valida mediante:

~~~bash
systemd-detect-virt
systemctl is-active virtualbox-guest-utils.service
pgrep -a VBoxService
~~~

El instalador detecta `oracle` / `virtualbox` y utiliza:

- `virtualbox-guest-utils`
- `virtualbox-guest-x11`
- `virtualbox-guest-utils.service`

### ☁️ VMware

Cuando detecta VMware:

- `open-vm-tools`
- `open-vm-tools-desktop`
- `open-vm-tools.service`

El helper `vmware-tools` es solo de diagnóstico/recovery; no cambia la configuración de la VM automáticamente.

---

# ⌨️ Lista completa de shortcuts

> **Nota:** `Super` = tecla Windows/Meta.

### 🚀 Lanzamiento

| Shortcut | Acción |
|---|---|
| `Super + Enter` | Abrir Kitty |
| `Super + D` | Rofi → aplicaciones (drun) |
| `Super + Shift + D` | Rofi → comandos (run) |
| `Super + Shift + H` | Menú central `xlfr4n // Kali` |
| `Super + Shift + E` | Abrir Thunar |
| `Super + Shift + F` | Abrir Firefox |
| `Super + Shift + B` | Abrir Burp Suite |
| `Super + Shift + C` | Abrir VS Code |
| `Super + Shift + N` | Abrir Neovim en floating |

### 🪟 Gestión de ventanas

| Shortcut | Acción |
|---|---|
| `Super + Q` | Cerrar ventana normalmente |
| `Super + W` | Forzar kill de la ventana |
| `Super + F` | Fullscreen toggle; hides/reveals Polybar + dock |
| `Super + S` | Floating |
| `Super + T` | Tiled |
| `Super + Shift + T` | Pseudo-tiled |
| `Super + M` | Cambiar layout |
| `Super + G` | Intercambiar con la ventana más grande |
| `Super + Tab` | Volver al escritorio anterior |

### 🎯 Focus

| Shortcut | Acción |
|---|---|
| `Super + ←` | Focus izquierda |
| `Super + ↓` | Focus abajo |
| `Super + ↑` | Focus arriba |
| `Super + →` | Focus derecha |

### 🔀 Swap

| Shortcut | Acción |
|---|---|
| `Super + Shift + ←` | Swap izquierda |
| `Super + Shift + ↓` | Swap abajo |
| `Super + Shift + ↑` | Swap arriba |
| `Super + Shift + →` | Swap derecha |

### 📐 Resize / move

| Shortcut | Acción |
|---|---|
| `Super + Alt + ←` | Resize izquierda |
| `Super + Alt + ↓` | Resize abajo |
| `Super + Alt + ↑` | Resize arriba |
| `Super + Alt + →` | Resize derecha |
| `Super + Ctrl + ←` | Mover nodo izquierda |
| `Super + Ctrl + ↓` | Mover nodo abajo |
| `Super + Ctrl + ↑` | Mover nodo arriba |
| `Super + Ctrl + →` | Mover nodo derecha |

### 🔢 Escritorios

| Shortcut | Acción |
|---|---|
| `Super + 1` | Escritorio 1 |
| `Super + 2` | Escritorio 2 |
| `Super + 3` | Escritorio 3 |
| `Super + 4` | Escritorio 4 |
| `Super + 5` | Escritorio 5 |
| `Super + 6` | Escritorio 6 |
| `Super + 7` | Escritorio 7 |
| `Super + 8` | Escritorio 8 |
| `Super + 9` | Escritorio 9 |

Mover la ventana actual:

| Shortcut | Acción |
|---|---|
| `Super + Shift + 1..9` | Mover ventana a desktop 1..9 |

### 🧠 Control BSPWM

| Shortcut | Acción |
|---|---|
| `Super + Alt + R` | Recargar/reiniciar BSPWM |
| `Super + Alt + Q` | Salir de BSPWM |

> ⚠️ `Super + Alt + Q` termina la sesión de BSPWM. Pruébalo al final.

---

# ⚡ Funciones xlfr4n

### 🎨 Themes

| Shortcut / comando | Acción |
|---|---|
| `Super + Alt + T` | Selector de theme |
| `Super + Ctrl + T` | Selector de theme |
| `theme-switch --list` | Lista de themes |
| `theme-switch --current` | Theme actual |
| `theme-switch cyber-red` | Aplicar Cyber Red |
| `theme-switch htb-green` | Aplicar HTB Green |
| `theme-switch nord` | Aplicar Nord |
| `theme-switch purple` | Aplicar Purple |
| `theme-switch --random` | Theme aleatorio |

Los themes modifican Polybar, Kitty, Rofi, Dunst y los colores de borde de BSPWM.

### 🖼️ Wallpapers

| Shortcut / comando | Acción |
|---|---|
| `Super + Shift + W` | Wallpaper aleatorio |
| `Super + Ctrl + W` | Siguiente wallpaper |
| `wallpaper --current` | Wallpaper actual |
| `wallpaper --random` | Aleatorio |
| `wallpaper --next` | Siguiente |
| `wallpaper --set FILE` | Seleccionar archivo concreto |

### 🧪 Kali Lab

| Shortcut | Acción |
|---|---|
| `Super + Shift + L` | Abrir `Kali-Lab` |

El workspace de laboratorio utiliza Kitty + tmux + btop, con la identidad de terminal unificada de xLFr4n.

### 🎯 Target

| Shortcut / comando | Acción |
|---|---|
| `Super + Ctrl + X` | Abrir flujo de target |
| `settarget` | Establecer/mostrar target |
| `settarget --status` | Estado para Polybar |
| `cleartarget` | Limpiar target |
| Click izquierdo en `TARGET` | Copiar target al clipboard |
| Click derecho en `TARGET` | Editar/establecer target |
| Click central en `TARGET` | Limpiar target |

### 🖥️ Monitores

| Shortcut / comando | Acción |
|---|---|
| `Super + Shift + M` | Refresh de monitores |
| `monitor-refresh` | Detectar displays |
| `monitor-refresh --startup` | Inicialización de sesión |

La distribución de escritorios se adapta al número de monitores detectados.

### 🩺 Diagnóstico

| Shortcut / comando | Acción |
|---|---|
| `Super + Ctrl + R` | Abrir Kali Doctor |
| `doctor.sh` | Diagnóstico completo |
| `vmware-tools` | Diagnóstico VMware |
| `vmware-tools status` | Estado VMware |
| `vmware-tools restart` | Reiniciar VMware Tools |
| `vmware-tools shared-folders` | Diagnóstico de shared folders |

`doctor.sh` es **read-only**: diagnostica y no intenta reparar silenciosamente el sistema.

### 📸 Screenshots

| Shortcut | Acción |
|---|---|
| `Print` | Captura completa |
| `Shift + Print` | Captura por región |
| `Super + Shift + S` | Menú de screenshots |

Las capturas se guardan en:

~~~text
~/Pictures/Screenshots
~~~

### 🔐 Seguridad / sesión

| Shortcut | Acción |
|---|---|
| `Super + Shift + K` | Bloquear pantalla |
| `Super + Shift + P` | Menú de energía |

El menú de energía incluye Lock, Logout, Suspend, Reboot y Power off.

### 🔊 Audio

| Tecla | Acción |
|---|---|
| `XF86AudioRaiseVolume` | +5% |
| `XF86AudioLowerVolume` | -5% |
| `XF86AudioMute` | Mute/unmute |

También:

~~~bash
pamixer -i 5
pamixer -d 5
pamixer -t
~~~

---

# 🧪 Checklist completa de pruebas

### 1. Sesión

~~~bash
systemd-detect-virt
echo "$XDG_SESSION_TYPE"
echo "$DISPLAY"
pgrep -a bspwm
pgrep -a sxhkd
pgrep -a polybar
pgrep -a picom
pgrep -a dunst
~~~

### 2. Salud del entorno

~~~bash
doctor.sh
~~~

Debe terminar sin `FAIL`.

### 3. Lanzadores

~~~text
Super+Enter
Super+D
Super+Shift+D
Super+Shift+H
~~~

### 4. Ventanas

~~~text
Super+Q
Super+W
Super+F
Super+S
Super+T
Super+Shift+T
Super+M
Super+Tab
~~~

### 5. Focus / swap / resize

~~~text
Super+Arrow
Super+Shift+Arrow
Super+Alt+Arrow
Super+Ctrl+Arrow
~~~

### 6. Escritorios

~~~text
Super+1 ... Super+9
~~~

Mover una ventana:

~~~text
Super+Shift+1 ... Super+Shift+9
~~~

### 7. Themes

~~~bash
theme-switch --list
theme-switch cyber-red
theme-switch htb-green
theme-switch nord
theme-switch purple
~~~

Comprobar Polybar + Kitty + Rofi + Dunst + bordes BSPWM.

### 8. Wallpapers

~~~text
Super+Shift+W
Super+Ctrl+W
~~~

### 9. Lab / herramientas

~~~text
Super+Shift+L
Super+Shift+E
Super+Shift+F
Super+Shift+B
Super+Shift+C
Super+Shift+N
~~~

### 10. Target / monitor / doctor

~~~text
Super+Ctrl+X
Super+Shift+M
Super+Ctrl+R
~~~

### 11. Capturas / audio

~~~text
Print
Shift+Print
XF86AudioRaiseVolume
XF86AudioLowerVolume
XF86AudioMute
~~~

### 12. Seguridad / cierre

Probar al final:

~~~text
Super+Shift+K
Super+Shift+P
Super+Alt+R
Super+Alt+Q
~~~

---

# 🛠️ Troubleshooting

### Rofi

El launcher `rofi-xlfr4n` valida primero el theme personalizado. Si detecta un problema de sintaxis, utiliza automáticamente el theme por defecto y registra el problema en:

~~~text
~/.cache/xlfr4n-rofi.log
~~~

Pruebas manuales:

~~~bash
rofi -no-config -theme ~/.config/rofi/launcher.rasi -dump-theme
rofi-xlfr4n -show drun -show-icons
~~~

### Permisos

El instalador hace backup antes de desplegar y normaliza la propiedad de las carpetas de configuración propias para evitar configuraciones antiguas creadas por `root`.

Backups:

~~~text
~/.kali-bspwm-backups/
~~~

### Rollback

~~~bash
./uninstall.sh
~~~

El script ofrece restaurar el backup más reciente. Los paquetes instalados por el proyecto se dejan instalados deliberadamente.

---

# 🛡️ Design principles / Principios

### 🇪🇸

- No `curl | sh`
- No repositorios Debian de terceros
- Paquetes Kali primero
- Backup antes de reemplazar configuración
- Rollback reversible
- Diagnóstico read-only
- Dependencias Python aisladas con `pipx`
- Integración VM detectada automáticamente

### 🇬🇧

- No remote shell installers
- No third-party Debian repositories
- Kali packages first
- Backup before configuration replacement
- Reversible rollback
- Read-only diagnostics
- Isolated Python tooling through `pipx`
- Automatic VM detection

---


# 🎨 xlfr4n Personal Desktop Layer

El objetivo no es simplemente usar BSPWM: es que **Kali se sienta como un sistema propio de xlfr4n**.

### Identidad visible

- Barra superior iniciando con **⚡ xLFr4n // KALI**
- §MENU§ y §TARGET§ integrados en la barra; red, CPU, RAM y audio en un bloque compacto
- Sesión de login identificada como **⚡ xlfr4n // Kali BSPWM**
- Kitty con pestañas personalizadas y colores coordinados
- Zsh con prompt dinámico, target, virtualización, Git y theme
- Banner de terminal **PERSONAL SECURITY LAB**
- Rofi con búsqueda y selección de alto contraste
- Dunst y bordes BSPWM sincronizados con el theme
- Cuatro themes coordinados: Cyber Red, HTB Green, Nord y Purple
- Workspaces 1→9 + reloj en cápsula inferior derecha
- Dock inferior con iconos reales, tooltips y hover
- Feedback de lanzamiento mediante Dunst + detección de ventana lista
- Banner ASCII animado de xLFr4n al abrir Kitty
- Target clicable con copia directa al clipboard X11

### Filosofía

**No es un tema encima de Kali. Es una capa de escritorio completa.**

El proyecto centraliza identidad, navegación, atajos, terminal, launcher, notificaciones, ventanas, wallpapers, virtualización y diagnóstico, manteniendo todos los cambios reproducibles desde Git.

### After pull / Después de actualizar el repo

~~~bash
cd ~/Downloads/kali-bspwm-2026
git pull --ff-only
chmod +x install.sh uninstall.sh
./install.sh
~~~

Después de reiniciar y entrar en BSPWM:

~~~bash
doctor.sh
rofi-xlfr4n -show drun -show-icons
~~~

# ✅ Runtime validation

### Live VM check — 26 Sep 2026

Kali 2026.3 x86_64 running under VirtualBox was tested after installation.

Observed:

~~~text
DESKTOP_SESSION=bspwm
XDG_SESSION_TYPE=x11
Virtualization=oracle
Resolution=1920x1080
VBoxService=running
~~~

The first live diagnostic returned:

~~~text
Summary: 33 OK, 0 FAIL
~~~

The repository has since received additional hardening for:

- VirtualBox service detection
- root-owned legacy configuration directories
- Rofi theme validation/fallback
- explicit VirtualBox diagnostics
- BSPWM theme border synchronization

Those latest changes should be re-tested in the live guest before calling the runtime matrix fully closed.

---

# 📌 Project identity

🐉 **Kali BSPWM 2026**  
⚡ **xlfr4n**  
🖥️ **Kali guest → X11 → BSPWM**  
🎨 **Cyber / HTB / minimalist dark UI**  
🌍 **Documentation / Documentación: ES + EN**

---

## ⚡ xlfr4n // Signature

<p align="center">
  <a href="./BRAND.md">🧩 Project identity / Identidad del proyecto</a> ·
  <a href="https://github.com/xlfr4n">⚡ xlfr4n</a>
  <br>
  <sub>Build it. Understand it. Automate it. Document it. · Hazlo. Entiéndelo. Automatízalo. Documéntalo.</sub>
</p>

## 🧭 xLFr4n repository standard

**Display signature:** ⚡ xLFr4n · **GitHub handle:** `xlfr4n`

Documentation entry points:
- `BRAND.md` — visual identity and writing rules.
- `CHANGELOG.md` — release history.
- `CONTRIBUTING.md` — contribution and verification workflow.
- `SECURITY.md` — safe configuration and reporting.
- `CODE_OF_CONDUCT.md` — collaboration baseline.
- `LICENSE` — project license.

### Configuration boundary

The repository configures the **Kali guest environment**. Host configuration, secrets and unrelated machine state stay outside the repository unless explicitly represented as safe, reproducible configuration.

> **🐉 xLFr4n · Linux · automation · reproducible setup**

