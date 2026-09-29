# ⚡ xLFr4n // Kali BSPWM 2026

> 🖥️ **A reproducible Kali Linux X11 + BSPWM workspace by xLFr4n.**  
> 🖥️ **Un workspace Kali Linux X11 + BSPWM reproducible, personal y mantenible por xLFr4n.**

[![ShellCheck](https://img.shields.io/github/actions/workflow/status/xlfr4n/kali-bspwm-2026/shellcheck.yml?label=ShellCheck&logo=github)](https://github.com/xlfr4n/kali-bspwm-2026/actions)
![Kali Linux](https://img.shields.io/badge/Kali-Linux-557C94?style=for-the-badge&logo=kalilinux&logoColor=white)
![BSPWM](https://img.shields.io/badge/BSPWM-X11-111827?style=for-the-badge)
![VirtualBox](https://img.shields.io/badge/VirtualBox-supported-183A61?style=for-the-badge)
![VMware](https://img.shields.io/badge/VMware-supported-607078?style=for-the-badge)
![xLFr4n](https://img.shields.io/badge/identity-xLFr4n-ff3344?style=for-the-badge)

<p align="center">
  <sub>⚡ Build it. Understand it. Automate it. Document it. · Hazlo. Entiéndelo. Automatízalo. Documéntalo.</sub>
</p>

---

# 🇪🇸 Español

## 🎯 Qué es

**Kali BSPWM 2026** es mi capa de escritorio personal para Kali Linux:

**Kali Linux → X11 → BSPWM → SXHKD → Polybar + Tint2 + Rofi + Kitty + Picom + Dunst**

La idea no es instalar un escritorio completo encima de Kali. La idea es mantener un sistema ligero y convertirlo en un workspace personal de **⚡ xLFr4n**, con:

- 🪟 gestión de ventanas con BSPWM;
- ⌨️ atajos rápidos con SXHKD;
- 📊 estado del sistema con Polybar;
- 🚀 launcher tipo Spotlight con Rofi;
- 🧊 dock inferior launcher-only con iconos reales mediante Tint2;
- 🐱 Kitty como terminal principal;
- 🌫️ Picom para sombras/fades suaves;
- 🔔 Dunst para notificaciones;
- 🎨 themes coordinados;
- 🖼️ wallpapers con caché;
- 🎯 target helper;
- 🩺 doctor read-only;
- 🎞️ workspace HUD con feedback de transición;
- 🔊 feedback visual de volumen/mute;
- 🌐 indicador de red adaptativo según la ruta por defecto;
- 🔋 batería opcional que aparece solo cuando existe;
- 🖥️ detección de VirtualBox/VMware;
- 💾 backups antes del despliegue.

> **Límite importante:** el proyecto configura el **guest Kali**. No modifica automáticamente la configuración del host Windows, VirtualBox o VMware.

---

## 🖥️ Entorno de referencia

El proyecto se ha trabajado y validado tomando como referencia un guest con:

| Componente | Referencia |
|---|---|
| Host | Windows 11 |
| Virtualización | VirtualBox |
| Guest | Kali Linux Rolling |
| Versión de Kali del guest | 2026.3 |
| Arquitectura | x86_64 |
| Sesión | X11 |
| Window manager | BSPWM |
| Pantalla de referencia | 1920×1080 cuando está disponible |
| Identidad | ⚡ xLFr4n |

La detección real se hace dentro del guest con:

```bash
cat /etc/os-release
uname -m
systemd-detect-virt
echo "$XDG_SESSION_TYPE"
echo "$DISPLAY"
xrandr --query
```

En el guest de referencia, `systemd-detect-virt` identifica VirtualBox como `oracle`.

**Nada del README debe interpretarse como una configuración automática del host.**

---

## 🧱 Arquitectura

```text
                         ┌───────────────────────┐
                         │ Display Manager / X11 │
                         └───────────┬───────────┘
                                     │
                                     ▼
                              ┌─────────────┐
                              │    BSPWM    │
                              └──────┬──────┘
                                     │
                                     ▼
                              ┌─────────────┐
                              │  autostart  │
                              └──────┬──────┘
                       ┌─────────────┴─────────────┐
                       │                           │
                 PHASE 1                       PHASE 2
                 usable UI                     visual polish
                       │                           │
            sxhkd + Dunst + Polybar      monitor + wallpaper
            + BSPWM borders              + desktop-style + dock
            + workspace HUD               + Picom fades
                                                     + Picom
```

La segunda fase se ejecuta en segundo plano y se escalona para evitar que wallpaper, dock, monitor-refresh y compositor compitan todos a la vez durante el login.

Consulta más detalle en [docs/ARCHITECTURE.md](./docs/ARCHITECTURE.md).

---

# 🚀 Instalación completa

## 1️⃣ Requisitos

Antes de empezar:

- Kali Linux funcionando con **X11**.
- Usuario normal con `sudo`.
- Conectividad para `apt`.
- Una sesión gráfica X11 disponible para BSPWM.
- En una VM, instala primero las **Guest Additions / guest tools** soportadas por el hipervisor o deja que el instalador las detecte e instale cuando estén disponibles en Kali.

No ejecutes el instalador como `root`.

---

## 2️⃣ Clonar el repositorio

### Instalación nueva

```bash
cd ~/Downloads
git clone https://github.com/xlfr4n/kali-bspwm-2026.git
cd kali-bspwm-2026
```

### Si ya tienes el repositorio

```bash
cd ~/Downloads/kali-bspwm-2026
git pull --ff-only
```

### ⚠️ Importante: `git pull` NO instala los cambios

El repositorio contiene los archivos fuente. El escritorio utiliza copias desplegadas bajo `~/.config` y `~/.local/bin`.

Por eso, después de actualizar Git:

```bash
chmod +x install.sh uninstall.sh
./install.sh
```

Este paso vuelve a desplegar las configuraciones y los scripts.

---

## 3️⃣ Instalar todo

```bash
chmod +x install.sh uninstall.sh
./install.sh
```

El instalador:

1. comprueba que estás en Kali;
2. comprueba que no eres `root`;
3. obtiene acceso `sudo`;
4. actualiza metadata de APT;
5. detecta la virtualización;
6. instala dependencias base;
7. intenta instalar componentes visuales opcionales disponibles;
8. crea un backup con timestamp;
9. despliega `config/`;
10. despliega `scripts/`;
11. instala iconos y lanzadores `.desktop`;
12. registra la sesión X11 de BSPWM;
13. configura la integración de VirtualBox o VMware cuando corresponde;
14. prepara fuentes;
15. aplica el estilo GTK;
16. prepara el dock;
17. deja un resumen final.

Backups:

```text
~/.kali-bspwm-backups/YYYYMMDD-HHMMSS/
```

---

# 🖥️ Máquina virtual

## 🟦 VirtualBox

El instalador detecta:

```bash
systemd-detect-virt
```

Cuando devuelve `oracle` / `virtualbox`, intenta instalar:

- `virtualbox-guest-utils`
- `virtualbox-guest-x11`

Comprobación:

```bash
systemd-detect-virt
systemctl is-active virtualbox-guest-utils.service 2>/dev/null || true
systemctl is-active vboxservice.service 2>/dev/null || true
pgrep -a VBoxService || true
xrandr --query
```

No asumas el nombre del servicio: dependiendo de la versión de Kali/paquetes, puede cambiar. El proyecto prueba las variantes soportadas.

---

## 🟧 VMware

Cuando se detecta VMware, el instalador intenta instalar:

- `open-vm-tools`
- `open-vm-tools-desktop`

Comprobación:

```bash
systemd-detect-virt
systemctl is-active open-vm-tools.service 2>/dev/null || true
command -v vmware-user || true
xrandr --query
```

También existe:

```bash
vmware-tools status
```

El helper es principalmente de diagnóstico/recovery y no cambia automáticamente las opciones del hipervisor.

Más información: [docs/VMWARE.md](./docs/VMWARE.md).

---

# 🎨 Workspace final

## Barra superior

La barra superior es **transparente y sin borde**.

Muestra de forma compacta:

- ⚡ identidad xLFr4n;
- launcher;
- target;
- ventana activa;
- VPN/red;
- CPU;
- RAM;
- disco;
- audio;
- virtualización;
- uptime.

No hay fondo negro sólido: la intención es que el contenido flote directamente sobre el wallpaper.

## Parte inferior

La zona inferior también es transparente:

```text
1 2 3 4 5 6 7 8 9                         🗓 29/09/2026    17:xx

                           [ iconos del dock ]
```

Los escritorios están deliberadamente **pequeños y compactos**. El escritorio activo se distingue mediante un acento/línea fina, no mediante una caja. Al cambiar de escritorio, `workspace-hud` añade una señal breve y animada para confirmar el foco sin llenar la pantalla.

Fecha y hora se mantienen separadas para que sean más legibles y no formen otro recuadro.

## Dock

Tint2 es el backend principal cuando está disponible:

- solo lanzadores;
- sin taskbar;
- sin bandeja;
- sin batería;
- iconos reales;
- tooltips;
- hover;
- lanzamiento con detección de ventanas existentes.

Fallback:

```text
Tint2 → Plank → Polybar native dock
```

---

# 📊 Qué significan los porcentajes

En Polybar:

| Indicador | Significado |
|---|---|
| ` 35%` | CPU usada aproximadamente |
| ` 48%` | RAM utilizada |
| ` 31%` | espacio ocupado en `/` |
| ` 67%` | volumen actual |

No son porcentajes de “rendimiento general”: cada uno representa una métrica distinta.

---

# ⌨️ Atajos principales

> **Super = tecla Windows / Meta**

| Atajo | Acción |
|---|---|
| `Super + Enter` | Kitty |
| `Super + D` | Rofi → aplicaciones |
| `Super + Shift + D` | Rofi → comandos |
| `Super + Space` | Spotlight |
| `Super + Shift + Space` | Mission Control |
| `Super + Shift + H` | Menú xLFr4n |
| `Super + Shift + A` | Mostrar/ocultar dock |
| `Super + F` | Fullscreen |
| `Super + S` | Floating |
| `Super + T` | Tiled |
| `Super + Tab` | Escritorio anterior |
| `Super + 1..9` | Cambiar de escritorio |
| `Super + Shift + 1..9` | Mover ventana a escritorio |
| `Super + Shift + W` | Wallpaper aleatorio |
| `Super + Ctrl + W` | Siguiente wallpaper |
| `Super + Alt + T` | Selector de theme |
| `Super + Shift + L` | Kali Lab |
| `Super + Ctrl + X` | Target |
| `Super + Shift + M` | Refrescar monitores |
| `Super + Ctrl + R` | Doctor |
| `Super + Shift + S` | Screenshots |
| `Super + Shift + K` | Bloquear |
| `Super + Shift + P` | Energía |

Lista completa: [docs/README.md](./docs/README.md) y [config/README.md](./config/README.md).

---

## 🎞️ UX feedback layer

The workspace now treats feedback as part of the desktop language: desktop changes use `workspace-hud`, media keys use `audio-control`, and transient Dunst notifications fade with Picom. These helpers are deliberately optional, short-lived and low overhead so the visual layer stays clean in a VM.

### 🇪🇸

La capa de feedback no añade paneles permanentes. Solo responde cuando ocurre algo: cambio de escritorio, volumen/mute, lanzamiento de aplicaciones, cambio de tema o copia del target.

# 🎨 Themes

Disponibles:

```bash
theme-switch --list
theme-switch cyber-red
theme-switch htb-green
theme-switch nord
theme-switch purple
theme-switch --random
theme-switch --current
```

El theme sincroniza:

```text
Polybar
  ↕
Kitty
  ↕
Rofi
  ↕
Dunst
  ↕
BSPWM border accents
```

`pywal16` es opcional; el escritorio no depende de él.

---

# 🖼️ Wallpapers

```bash
wallpaper --random
wallpaper --next
wallpaper --current
wallpaper --set /ruta/al/wallpaper.png
```

El index de wallpapers se cachea para que un login posterior no tenga que volver a recorrer todas las carpetas cada vez.

---

# 🎯 Target workflow

```bash
settarget 10.10.10.10 Web01
settarget --status
target-copy
cleartarget
```

El target puede aparecer en Polybar y copiarse al clipboard X11.

---

# 🩺 Diagnóstico

El doctor es deliberadamente **read-only**.

```bash
doctor.sh
```

También:

```bash
systemd-detect-virt
systemctl --failed
xrandr --query
pgrep -a bspwm
pgrep -a sxhkd
pgrep -a polybar
pgrep -a picom
pgrep -a dunst
```

Archivos de diagnóstico especialmente útiles:

```text
~/.cache/xlfr4n-session.log
~/.cache/xlfr4n-dock.log
~/.cache/xlfr4n-rofi.log
/tmp/kali-bspwm-polybar.log
/tmp/kali-bspwm-picom.log
```

---

# ⚡ Arranque y rendimiento

El login está diseñado para que las tareas pesadas no sean un único bloque:

```text
1. BSPWM
2. SXHKD / Dunst / Polybar
3. monitor-refresh
4. desktop-style
5. wallpaper
6. dock
7. Picom
```

Las tareas visuales arrancan escalonadas y en segundo plano.

Esto no promete un tiempo fijo de login: el tiempo real depende también del display manager, X11, disco, CPU, RAM y la configuración de la VM.

Para investigar lentitud:

```bash
sed -n '1,220p' ~/.cache/xlfr4n-session.log
systemd-analyze --user blame 2>/dev/null | head -30 || true
journalctl --user -b --no-pager | tail -200
```

Si el escritorio ya aparece pero algo visual llega después, eso puede ser intencional por el arranque escalonado.

---

# 🔄 Actualizar correctamente

## Desde Git

```bash
cd ~/Downloads/kali-bspwm-2026
git pull --ff-only
chmod +x install.sh uninstall.sh
./install.sh
reboot
```

## Actualizar Kali

```bash
sudo apt update
sudo apt full-upgrade -y
```

Después del upgrade, comprueba:

```bash
doctor.sh
systemd-detect-virt
```

No se ejecuta `apt autoremove` automáticamente como parte de este proyecto.

---

# 🧪 Validación antes de darlo por terminado

## Tests del repositorio

```bash
bash tests/static.sh
bash tests/shellcheck.sh
```

## Validación de Rofi

```bash
rofi -no-config -theme ~/.config/rofi/launcher.rasi -dump-theme >/dev/null
```

## Validación del entorno

```bash
cat /etc/os-release
uname -m
systemd-detect-virt
echo "XDG_SESSION_TYPE=$XDG_SESSION_TYPE"
echo "DISPLAY=$DISPLAY"
xrandr --query
doctor.sh
```

---

# 🧯 Si algo se ve mal después de un pull

Recuerda la diferencia:

```text
git pull
   ↓
actualiza ~/Downloads/kali-bspwm-2026
   ↓
./install.sh
   ↓
despliega ~/.config + ~/.local/bin
   ↓
reboot / nueva sesión BSPWM
```

Un `git pull` por sí solo **no reemplaza** la configuración que ya está instalada en tu HOME.

Para una prueba limpia:

```bash
cd ~/Downloads/kali-bspwm-2026
git pull --ff-only
./install.sh
reboot
```

Si persiste un problema visual, captura primero:

```bash
doctor.sh
xrandr --query
pgrep -a polybar
pgrep -a tint2
pgrep -a plank
pgrep -a picom
```

Y guarda una captura del escritorio completo antes de modificar cosas manualmente.

---

# 💾 Backup y rollback

El instalador crea backups antes de desplegar.

Ubicación:

```text
~/.kali-bspwm-backups/
```

Para retirar la capa del proyecto:

```bash
./uninstall.sh
```

Los paquetes instalados se dejan deliberadamente en el sistema y los backups permanecen.

---

# 📁 Estructura del proyecto

```text
kali-bspwm-2026/
├── .github/                 # CI, templates y automation metadata
├── config/                  # configuración desplegable
│   ├── bspwm/
│   ├── dunst/
│   ├── kitty/
│   ├── picom/
│   ├── plank/
│   ├── polybar/
│   ├── rofi/
│   ├── sxhkd/
│   ├── tint2/
│   └── zshrc
├── docs/                   # documentación operativa
├── scripts/                # helpers y utilidades
├── tests/                  # guardrails y ShellCheck
├── themes/                 # identidad de themes
├── BRAND.md
├── CHANGELOG.md
├── CONTRIBUTING.md
├── SECURITY.md
├── install.sh
└── uninstall.sh
```

---

# 🛡️ Principios

### 🇪🇸

- 📦 Kali primero.
- 💾 Backup antes de reemplazar configuración.
- 🔄 Cambios reversibles.
- 🧪 Tests estáticos y ShellCheck.
- 🩺 Diagnóstico read-only.
- 🔐 Nada de secretos en Git.
- 🐍 Python opcional y aislado con `pipx`.
- 🖥️ VirtualBox/VMware detectados desde el guest.
- 🎨 La estética no debe romper la compatibilidad de la VM.
- 🧩 Un componente debe tener una responsabilidad clara.
- 🚫 No `curl | sh`.
- 🚫 No repositorios Debian de terceros para el núcleo del proyecto.

### 🇬🇧

- 📦 Kali packages first.
- 💾 Backup before configuration replacement.
- 🔄 Reversible changes.
- 🧪 Static tests and ShellCheck.
- 🩺 Read-only diagnostics.
- 🔐 No secrets in Git.
- 🐍 Optional Python tooling isolated through `pipx`.
- 🖥️ VirtualBox/VMware detection from inside the guest.
- 🎨 Visual polish must not compromise VM compatibility.
- 🧩 One component, one clear responsibility.
- 🚫 No `curl | sh`.
- 🚫 No third-party Debian repositories for the core setup.

---

# 📚 Documentation

| Documento | Contenido |
|---|---|
| [docs/INSTALL.md](./docs/INSTALL.md) | instalación paso a paso |
| [docs/ARCHITECTURE.md](./docs/ARCHITECTURE.md) | arquitectura y arranque |
| [docs/FIRST-VM-TEST.md](./docs/FIRST-VM-TEST.md) | primera validación de VM |
| [docs/VMWARE.md](./docs/VMWARE.md) | integración VMware |
| [docs/DESKTOP-STYLE.md](./docs/DESKTOP-STYLE.md) | capa visual |
| [config/README.md](./config/README.md) | mapa de configuración |
| [scripts/README.md](./scripts/README.md) | mapa de helpers |
| [themes/README.md](./themes/README.md) | themes |
| [tests/README.md](./tests/README.md) | validación |
| [BRAND.md](./BRAND.md) | identidad xLFr4n |

---

# 🇬🇧 English

## 🎯 What is it?

**Kali BSPWM 2026** is my personal Kali Linux desktop layer:

**Kali Linux → X11 → BSPWM → SXHKD → Polybar + Tint2 + Rofi + Kitty + Picom + Dunst**

It deliberately avoids adding a full desktop environment. Instead, it builds a lightweight and reproducible **⚡ xLFr4n** workspace with window management, keyboard control, status information, launcher, intelligent dock focus, terminal, notifications, workspace transition feedback, audio feedback, adaptive network/battery status, themes, wallpapers, target tracking, diagnostics and VM integration.

> **Boundary:** the project configures the **Kali guest**. It does not automatically change the Windows, VirtualBox or VMware host configuration.

---

## 🖥️ Reference environment

The current project reference is:

| Component | Reference |
|---|---|
| Host | Windows 11 |
| Hypervisor | VirtualBox |
| Guest | Kali Linux Rolling |
| Kali guest version | 2026.3 |
| Architecture | x86_64 |
| Session | X11 |
| Window manager | BSPWM |
| Reference display | 1920×1080 when available |
| Identity | ⚡ xLFr4n |

Detect the real guest environment with:

```bash
cat /etc/os-release
uname -m
systemd-detect-virt
echo "$XDG_SESSION_TYPE"
echo "$DISPLAY"
xrandr --query
```

The reference guest reports VirtualBox as `oracle`.

---

## 🚀 Installation

```bash
cd ~/Downloads
git clone https://github.com/xlfr4n/kali-bspwm-2026.git
cd kali-bspwm-2026
chmod +x install.sh uninstall.sh
./install.sh
reboot
```

Then select **BSPWM** in the display manager.

### Updating an existing checkout

For a full system/package refresh:

```bash
cd ~/Downloads/kali-bspwm-2026
git pull --ff-only
chmod +x install.sh uninstall.sh
./install.sh
reboot
```

For a fast workspace-only update after a Git change:

```bash
cd ~/Downloads/kali-bspwm-2026
git pull --ff-only
./install.sh --deploy
bspc wm -r
```

> **Important:** `git pull` updates the repository checkout. `./install.sh` deploys the updated files to `~/.config` and `~/.local/bin`. `--deploy` skips APT and is intended for iterative workspace updates.

---

## 🖥️ VirtualBox / VMware

Virtualization is detected inside the guest with `systemd-detect-virt`.

VirtualBox uses Kali's guest packages when available:

```bash
systemd-detect-virt
systemctl is-active virtualbox-guest-utils.service 2>/dev/null || true
systemctl is-active vboxservice.service 2>/dev/null || true
```

VMware uses:

```text
open-vm-tools
open-vm-tools-desktop
```

Check:

```bash
systemd-detect-virt
systemctl is-active open-vm-tools.service 2>/dev/null || true
command -v vmware-user || true
```

---

## 🎨 Workspace

Both the upper and lower UI rails are intentionally **transparent and borderless**.

- Compact workspaces 1→9 on the lower-left.
- Date and time on the lower-right.
- Icon dock centered below.
- System status in the upper rail.
- Accent colors come from the active xLFr4n theme.

The main dock uses Tint2 launcher-only mode and falls back to Plank or native Polybar when needed.

---

## 🧪 Login profiling

After logging into BSPWM:

```bash
session-profile
```

This is read-only and summarizes the xLFr4n bootstrap timestamps. It is useful for distinguishing the BSPWM hand-off from later wallpaper, dock, monitor and compositor work.

## ⚡ Startup performance

The session starts the minimum usable desktop first and stages heavier visual work afterward:

```text
BSPWM / SXHKD / Dunst / Polybar
        ↓
monitor refresh
        ↓
desktop style
        ↓
wallpaper
        ↓
dock
        ↓
Picom
```

There is no fixed promise for login time because the display manager, X11 startup, VM storage, CPU/RAM allocation and host load are external variables.

Useful diagnostics:

```bash
sed -n '1,220p' ~/.cache/xlfr4n-session.log
systemd-analyze --user blame 2>/dev/null | head -30 || true
journalctl --user -b --no-pager | tail -200
```

---

## 🧪 Validation

```bash
bash tests/static.sh
bash tests/shellcheck.sh
doctor.sh
rofi -no-config -theme ~/.config/rofi/launcher.rasi -dump-theme >/dev/null
```

CI validates Bash syntax/static guards, Rofi theme parsing and ShellCheck.

---

## 📚 Documentation

See:

- [docs/INSTALL.md](./docs/INSTALL.md)
- [docs/ARCHITECTURE.md](./docs/ARCHITECTURE.md)
- [docs/FIRST-VM-TEST.md](./docs/FIRST-VM-TEST.md)
- [docs/VMWARE.md](./docs/VMWARE.md)
- [docs/DESKTOP-STYLE.md](./docs/DESKTOP-STYLE.md)
- [config/README.md](./config/README.md)
- [scripts/README.md](./scripts/README.md)
- [tests/README.md](./tests/README.md)
- [BRAND.md](./BRAND.md)

---

# ⚡ xLFr4n

<p align="center">
  <strong>⚡ xLFr4n // Kali BSPWM 2026</strong><br>
  <sub>Linux · automation · reproducibility · dark workspace · VM aware</sub>
</p>
