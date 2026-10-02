# ⚡ xLFr4n // Kali BSPWM 2026

> Kali Linux · X11 · BSPWM · SXHKD · Polybar · Tint2 · Rofi · Ghostty · tmux · Picom · Dunst
>
> A personal, reproducible and VM-friendly workspace by xLFr4n.

<p align="center">

[![CI](https://img.shields.io/github/actions/workflow/status/xlfr4n/kali-bspwm-2026/shellcheck.yml?label=CI&logo=github)](https://github.com/xlfr4n/xLFr4n-Kali-BSPWM/actions)
![Kali Linux](https://img.shields.io/badge/Kali-Linux-557C94?style=flat-square&logo=kalilinux&logoColor=white)
![BSPWM](https://img.shields.io/badge/BSPWM-X11-111827?style=flat-square)
![License](https://img.shields.io/github/license/xlfr4n/kali-bspwm-2026?style=flat-square)

</p>

---

## 🇪🇸 Español

### Qué es

Kali BSPWM 2026 es la capa de escritorio personal de xLFr4n para Kali Linux.

La idea no es instalar otro escritorio completo. La base sigue siendo ligera:

    Kali Linux
        ↓
       X11
        ↓
      BSPWM
        ↓
      SXHKD
        ↓
    xLFr4n UI

Encima de esa base se organizan Polybar, Tint2, Rofi, Ghostty + tmux, Ghostty como único terminal gráfico, Picom, Dunst, Fastfetch, Zsh y una colección de helpers de sesión.

El proyecto está pensado para un guest Kali. No modifica automáticamente la configuración del Windows host ni la configuración del hipervisor.

### Principios

    01  Kali primero
    02  información útil > decoración
    03  rojo como acento, no como marco
    04  animación solo cuando aporta feedback
    05  VM-friendly por defecto
    06  backups antes de modificar
    07  el repositorio es la fuente de verdad

### Composición visual

    ┌──────────────────────────────────────────────────────────────────────┐
    │ ⚡ xLFr4n     ⌘ APPS      TARGET                  VENTANA ACTUAL  │
    │                                                        RED · RAM...  │
    │                                                                      │
    │                         BSPWM / WORKSPACE                            │
    │                                                                      │
    │                    1  2  3  4  5  6  7  8  9                         │
    │                       fecha larga · hora                             │
    │                         iconos / dock                                │
    └──────────────────────────────────────────────────────────────────────┘

    Arriba izquierda
      • identidad xLFr4n
      • APPS en blanco y estático
      • TARGET en blanco con un único pulso al iniciar sesión

    Centro
      • título de la ventana activa

    Arriba derecha
      • VPN
      • red
      • CPU
      • RAM
      • SSD
      • volumen
      • batería cuando existe
      • virtualización
      • uptime

    Abajo
      • escritorios 1 → 9
      • fecha y hora
      • dock centrado

Las ventanas del escritorio no dibujan el típico marco rojo. BSPWM usa superficie frameless y Ghostty no añade un marco rojo propio.

Rofi, Tint2 y Plank siguen la misma regla: ningún contorno rojo decorativo.

### Animación

La animación principal es deliberadamente contenida:

    xLFr4n     → señal ligera continua
    TARGET     → pulso único durante el inicio de sesión
    APPS       → estático
    HUD        → feedback al cambiar de escritorio
    Terminal   → cursor
    Dock       → hover / launch feedback

No existe un segundo marcador KALI animado en la zona derecha de la IP.

---

## 🇬🇧 English

### What it is

Kali BSPWM 2026 is xLFr4n's personal desktop layer for Kali Linux.

It does not replace Kali with a full desktop environment. The core remains:

    Kali Linux
        ↓
       X11
        ↓
      BSPWM
        ↓
      SXHKD
        ↓
    xLFr4n UI

Polybar, Tint2, Rofi, Ghostty + tmux,  Picom, Dunst, Fastfetch, Zsh and the session helpers build the user-facing layer.

The project targets a Kali guest. Host Windows, VirtualBox and VMware settings are not changed automatically.

### Visual contract

    red    = identity / accent / intentional highlight
    white  = primary controls and readable metadata
    dark   = surfaces
    no red window frames

The desktop is intentionally quiet outside the areas that communicate state.

---

# 🚀 Installation

## Requisitos

    Kali Linux Rolling
    x86_64
    X11
    normal user + sudo
    BSPWM available as an X11 session

For a VM, the installer detects the hypervisor where possible.

## Instalación nueva

    cd ~/Downloads
    git clone https://github.com/xlfr4n/xLFr4n-Kali-BSPWM.git
    cd xLFr4n-Kali-BSPWM

    chmod +x install.sh uninstall.sh
    ./install.sh

Do not run the installer as root.

Then reboot:

    reboot

Select BSPWM in the display manager.

## Actualización rápida

Use this when only the repository configuration changed:

    cd ~/Downloads/xLFr4n-Kali-BSPWM
    git pull --ff-only
    ./install.sh --deploy
    bspc wm -r

The important distinction:

    git pull
        updates the repository checkout

    ./install.sh --deploy
        deploys the checkout into the user session

## Actualización completa

    cd ~/Downloads/xLFr4n-Kali-BSPWM
    git pull --ff-only
    ./install.sh
    reboot

The full mode updates APT metadata, installs the available package set, bootstraps Ghostty when Kali does not package it, and removes the retired Kitty terminal layer.

---

# 🧱 Architecture

    config/
      bspwm/        window-manager rules
      sxhkd/        keyboard bindings
      polybar/      top and bottom rails
      tint2/        primary floating dock
      plank/        dock fallback
      rofi/         launcher themes
      ghostty/      primary terminal profile
      tmux/         persistent terminal/session profile
            picom/        compositor
      dunst/        notifications
      fastfetch/    Kali + xLFr4n login snapshot
      applications/ .desktop launchers
      icons/        local xLFr4n icons
      zshrc         shell identity

    scripts/
      autostart
      session-profile
      session-reload
      workspace-hud
      workspace-rail
      dock
      dock-launch
      xlfr4n-launch
      target helpers
      theme helpers
      wallpaper helpers
      diagnostics
      VM helpers
      audio/network/battery helpers

    tests/
      static.sh
      shellcheck.sh

    docs/
      installation
      architecture
      visual style
      VM validation
      final audit

The separation is intentional: configuration stays declarative while scripts own session behavior.

---

# ⌨️ Shortcuts

| Shortcut | Acción |
|---|---|
| Super + Enter | Ghostty + tmux |
| Super + D | App launcher |
| Super + Space | Spotlight |
| Super + Shift + Space | Mission Control |
| Super + Shift + H | xLFr4n menu |
| Super + Shift + A | Toggle dock |
| Super + F | Fullscreen |
| Super + 1..9 | Focus desktop |
| Super + Shift + 1..9 | Move window to desktop |
| Super + Arrow | Focus direction |
| Super + Shift + Arrow | Swap window |
| Super + Alt + Arrow | Resize |
| Super + Ctrl + Arrow | Geometry move/resize |
| Super + Tab | Last desktop |
| Super + R | Rotate layout |
| Super + Equal | Balance layout |
| Super + Shift + W | Random wallpaper |
| Super + Ctrl + W | Next wallpaper |
| Super + Alt + T | Theme selector |
| Super + Shift + M | Monitor refresh |
| Super + Ctrl + R | Doctor |
| Super + Ctrl + X | Set target |
| Super + Shift + P | Power menu |
| Super + Shift + S | Screenshot |
| Super + Shift + K | Lock |
| Super + F1 | Keys help |

Multimedia and brightness keys are routed through the helper layer.

---

# 🧊 Dock

Tint2 is the primary backend.

Fallback chain:

    Tint2 → Plank → Polybar dock

Only one dock backend should run at once.

Launchers currently cover:

    Menu
    Brave
    Ghostty + tmux
    Files
    Neovim
    Code
    Burp Suite
    Lab
    Target
    System Monitor
    Settings
    Network
    Screenshot
    Firefox
    Wireshark

The dock uses xLFr4n launch helpers. Existing application windows are focused when their class can be detected; otherwise a new process is started. Tint2 is kept as the single active primary backend; stale Polybar dock processes are cleared before the session rails are started. Desktop launchers use the installed absolute bridge /usr/local/bin/xLFr4n-dock-launch so graphical sessions do not depend on a shell PATH.

Launch feedback:

    ⚡ xLFr4n // OPENING
             ↓
    ⚡ xLFr4n // READY

The feedback is stacked so repeated clicks do not create a notification wall.

---

# 🎯 Target

Target state is stored under:

    ~/.config/polybar/target

Commands:

    settarget --status
    settarget 10.10.10.10 Web01
    target-copy
    cleartarget

The top target control is white.

At login it performs a short one-shot pulse based on the session start timestamp. After that first window it becomes static.

Changing the target later does not restart an animation loop.

---

# 🎨 Themes

Available themes:

    cyber-red
    htb-green
    nord
    purple

Commands:

    theme-switch
    theme-switch --current
    theme-switch --list
    theme-switch --random
    theme-switch cyber-red

Themes change accents in the UI, but application frames stay neutral.

pywal16 is optional. The desktop core does not depend on it.

---

# 🖼️ Wallpapers

Commands:

    wallpaper --default
    wallpaper --random
    wallpaper --next
    wallpaper --current
    wallpaper --set /path/to/image.png

The default session wallpaper is:

    /usr/share/backgrounds/kali/kali-hack-16x9.jpg

The wallpaper helper keeps an index/cache so login does not repeatedly rescan the filesystem.

---

# 🖥️ Terminal stack

Ghostty is the only graphical terminal and tmux is the persistence/multiplexer layer. The terminal helper has no alternate graphical backend.

Check the selected backend:

    xlfr4n-terminal --backend

Force a backend for one launch:

    xlfr4n-terminal --backend

Operational path:

    Ghostty
        ↓
      tmux
        ↓
   zsh / tools / SSH

Ghostty is now the single graphical terminal. Its configuration provides explicit copy/paste, selection and scrollback controls, while tmux exposes the full pane history through Ctrl+A, A. The installer uses a distro package when available and otherwise builds the pinned release from Ghostty's official source tarball without adding a third-party Debian repository.

Ghostty clipboard/scrollback controls:

    Ctrl+Shift+C          copy selection
    Ctrl+Shift+V          paste clipboard
    Ctrl+Shift+A          select visible screen
    Ctrl+Shift+Home       scroll to top
    Ctrl+Shift+End        scroll to bottom

Full tmux pane history:

    Ctrl+A, A             copy the complete active pane history to X11 clipboard

Manual system snapshot:

    xlfr4n-banner --static

Interactive shells also open with Fastfetch using the Kali logo and xLFr4n signature.

---

# 🔔 Feedback

The feedback layer is transient by design.

Used for:

    desktop changes
    application launches
    audio changes
    theme changes
    wallpaper changes
    target actions

Persistent UI stays small.

The project deliberately avoids turning every state into a card, border or floating box.

---

# 🌐 Network

network-status follows the interface carrying the default route.

Supported presentation:

    Wi-Fi
    Ethernet
    tun / wg VPN
    offline

It does not assume a fixed interface name.

---

# 🔊 Audio

audio-control supports:

    audio-control up
    audio-control down
    audio-control mute

pamixer is preferred when available; wpctl is used as fallback.

Visual feedback is sent through Dunst.

---

# 🔋 Battery

battery-status is optional.

On a normal desktop or virtual machine without a battery:

    no battery → no fake percentage

On a laptop it reports the battery level and charging state.

---

# 🖥️ Virtual machines

The installer detects virtualization with systemd-detect-virt.

## VirtualBox

The project supports the VirtualBox guest tooling available in the current Kali package snapshot.

Useful checks:

    systemd-detect-virt
    systemctl is-active virtualbox-guest-utils.service
    systemctl is-active vboxservice.service
    pgrep -a VBoxService
    xrandr --query

## VMware

The project supports:

    open-vm-tools
    open-vm-tools-desktop

Useful checks:

    systemd-detect-virt
    systemctl is-active open-vm-tools.service
    command -v vmware-user
    xrandr --query

The host is outside the scope of the installer.

---

# ⚡ Startup

Startup uses two conceptual phases.

    PHASE 1
      BSPWM
      SXHKD
      keyboard
      runtime accent
            ↓
      usable session

    PHASE 2
      Dunst
      Polybar
      workspace HUD
      monitor refresh
      desktop style
      wallpaper
      dock
      workspace rail
      Picom

The visual layer is staged so wallpaper, monitor detection and compositor startup do not become one blocking chain.

Profile the latest bootstrap:

    session-profile

The profiler intentionally resets to the most recent phase=core start, so old boots cannot produce misleading negative durations.

---

# 🩺 Diagnostics

The main read-only health check is:

    doctor.sh

It checks:

    Kali / X11
    BSPWM / SXHKD
    Polybar
    Ghostty + tmux
    Rofi
    Picom
    Dunst
    Workspace HUD
    Workspace rail
    Dock backend
    Target state
    Theme state
    Wallpaper
    Network/audio helpers
    VM integration
    Desktop launchers
    Critical configuration

A healthy session should finish with:

    Summary: <number> OK, 0 FAIL

The number of OK checks may grow as more safeguards are added.

---

# 🧪 Tests

Run locally:

    bash tests/static.sh
    bash tests/shellcheck.sh

Static validation covers:

    Bash syntax
    required files
    launcher wiring
    shortcut wiring
    Polybar geometry
    frameless application rules
    Rofi themes
    target startup behavior
    dock integration
    VM detection
    install/uninstall coverage

CI additionally validates:

    Rofi through a virtual display
    .desktop launchers
    ShellCheck

CI validates the repository after every change; the badge above reflects the current state of main.

---

# 📦 Installation safety

install.sh creates a timestamped backup before deployment:

    ~/.kali-bspwm-backups/

The installer supports:

    ./install.sh
    ./install.sh --full
    ./install.sh --deploy

The implementation is deliberately reversible.

The uninstaller removes the user layer but intentionally leaves installed packages in place.

---

# 📚 Documentation

    docs/README.md
        documentation index

    docs/INSTALL.md
        install, update and troubleshooting

    docs/ARCHITECTURE.md
        system layers and startup

    docs/DESKTOP-STYLE.md
        visual language

    docs/FIRST-VM-TEST.md
        first guest validation

    docs/VMWARE.md
        VMware integration

    docs/FINAL-AUDIT.md
        audit and validation state

Additional configuration notes live under:

    config/README.md
    scripts/README.md
    themes/README.md
    tests/README.md

---

# 🧠 Visual rules

### Red is an accent

Red may appear in:

    xLFr4n identity
    focus indicators
    intentional selection
    important controls
    theme accents

Red does not appear as:

    BSPWM window frames
    Terminal application frames
    Rofi window borders
    Tint2 dock borders
    Plank outer outlines

### White is the quiet primary layer

The main controls are readable and neutral:

    ⌘ APPS
     TARGET
    system metadata

### Animation has a reason

    xLFr4n → identity
    TARGET  → one-shot login entrance
    HUD     → desktop transition
    Terminal → cursor movement
    Dock    → hover / launch feedback

APPS remains static.

---

# 🗂️ Repository map

    .github/
      CI and repository automation

    config/
      reproducible desktop configuration

    docs/
      user-facing technical documentation

    scripts/
      operational helpers

    tests/
      static validation and ShellCheck

    themes/
      theme documentation

    BRAND.md
      project signature

    CHANGELOG.md
      change history

    install.sh
      full install and deploy

    uninstall.sh
      reversible user-layer removal

---

# ⚡ Philosophy

> Own the terminal. Own the desktop. Keep the system reproducible.

This is a personal environment, not a universal Kali desktop.

The goal is a workspace that:

    looks intentional
    starts quickly
    stays readable
    survives VM constraints
    is easy to inspect
    is easy to recover
    remains version-controlled

The source of truth is the repository.

    git pull
       ↓
    install.sh --deploy
       ↓
    same xLFr4n workspace

---

<p align="center">

<strong>⚡ xLFr4n</strong><br>
Kali · BSPWM · X11 · cybersecurity · terminal first

</p>

---

## 🇬🇧 Final note

A green CI run validates the repository. Your VM validates the final pixels.

Use both.


## 🟥 Red Team Lab

### 🇪🇸 Español

La capa Red Team convierte el workspace en un flujo de engagement reproducible sin cambiar la identidad visual del escritorio.

Crear un engagement:
~~~bash
lab init NOMBRE
lab status
~~~

Registrar alcance:
~~~bash
lab scope allow 10.10.10.0/24
lab scope deny 10.10.10.1
lab scope list
lab scope check 10.10.10.20
~~~

Registrar y seleccionar activos:
~~~bash
lab target add 10.10.10.20 web01
lab target add 10.10.10.30 dc01
lab target list
lab target use web01
~~~

El flujo de operaciones puede registrar comandos y resultados cuando el operador decide ejecutarlos; la capa de engagement no inicia herramientas por sí sola.

Evidencia:
~~~bash
lab evidence add captura.png screenshot
lab evidence list
lab evidence manifest
~~~

Findings:
~~~bash
lab finding new "Example finding" medium
lab finding list
~~~

Reporting:
~~~bash
lab report
~~~

Estructura:
~~~text
~/Lab/<engagement>/
├── 00-scope/
├── 01-recon/
├── 02-enumeration/
├── 03-web/
├── 04-active-directory/
├── 05-credentials/
├── 06-exploitation/
├── 07-post-exploitation/
├── 08-evidence/
├── 09-findings/
└── 10-report/
~~~

Perfiles de herramientas:
~~~bash
lab tools list
lab tools install core
lab tools install recon
lab tools install web
lab tools install ad
lab tools install credentials
lab tools install exploitation
lab tools install post
lab tools install reporting
lab tools status
~~~

### 🇬🇧 English

The Red Team layer turns the workspace into a reproducible engagement workflow while keeping desktop configuration and engagement state separate.

Create an engagement, define explicit allow/deny scope, register targets, select the active target, preserve evidence, create findings and generate reports.

No offensive tooling is started automatically. Tool selection and active operations remain explicit operator actions.

The engagement structure is documented in docs/LAB-ARCHITECTURE.md, tool profiles in docs/TOOL-PROFILES.md, evidence handling in docs/EVIDENCE.md and delivery in docs/REPORTING.md.
