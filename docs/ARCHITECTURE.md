# ⚡ xlfr4n // Architecture

> 🧩 **One desktop, separate layers, predictable behaviour.**  
> 🧩 **Un escritorio, capas separadas y comportamiento predecible.**

## 🇪🇸 Español

Kali BSPWM 2026 está organizado por responsabilidades para que la estética no tenga que invadir la instalación ni la lógica de sesión.

| Capa | Responsabilidad |
|---|---|
| `install.sh` | Detecta Kali/VMware/VirtualBox, instala paquetes, crea backups y despliega el entorno. |
| `config/` | Configuración declarativa de BSPWM, SXHKD, Polybar, Kitty, Rofi, Dunst, Picom y Zsh. |
| `scripts/` | Herramientas de sesión y utilidades: menú, target, monitores, temas, VMware, diagnóstico, screenshots, etc. |
| `themes/` | Identidad visual y temas estáticos. |
| `docs/` | Guías operativas y criterios de validación. |

### 🔐 Principios

- 💾 **Backup first:** los cambios sobre la configuración del usuario se respaldan antes de desplegar.
- 🔄 **Reversible:** `uninstall.sh` elimina la capa del proyecto y conserva los backups.
- 🧱 **Separated concerns:** BSPWM no necesita encargarse de arrancar cada servicio directamente.
- 🖥️ **X11 first:** BSPWM es un window manager X11; el proyecto trabaja con esa sesión.
- ☁️ **VM-aware:** VMware/VirtualBox se detectan antes de activar integración específica.
- 🎨 **Static core:** el escritorio funciona con temas estáticos incluso si pywal16 no está disponible.
- 🩺 **Read-only doctor:** el diagnóstico informa; no intenta “arreglar” el sistema a escondidas.

### 🚀 Flujo de sesión

```text
Display Manager
      ↓
     bspwm
      ↓
   autostart
   ├─ sxhkd
   ├─ keyboard
   ├─ monitor-refresh
   ├─ wallpaper
   ├─ dunst
   ├─ nm-applet
   ├─ theme-switch
   └─ start-picom
```

### 🧭 Identidad

Todos los helpers activos de este proyecto llevan la firma `⚡ xlfr4n`, mientras que la documentación conserva español + inglés.

## 🇬🇧 English

Kali BSPWM 2026 is split by responsibility so the visual layer does not have to leak into installation logic or session orchestration.

| Layer | Responsibility |
|---|---|
| `install.sh` | Detects Kali/VMware/VirtualBox, installs packages, backs up user config and deploys the environment. |
| `config/` | Declarative BSPWM, SXHKD, Polybar, Kitty, Rofi, Dunst, Picom and Zsh configuration. |
| `scripts/` | Session utilities: menu, target, monitors, themes, VMware, diagnostics, screenshots and more. |
| `themes/` | Visual identity and static themes. |
| `docs/` | Operational guides and validation criteria. |

### 🔐 Design principles

Backups before overwrite, reversible removal, separated responsibilities, X11-native BSPWM behaviour, virtualization-aware setup, static themes as the reliable baseline and read-only diagnostics.

### 🧭 Session flow

```text
Display Manager → bspwm → autostart → desktop services
```

### ⚡ Project signature

Active helper scripts carry the `xlfr4n` signature while all user-facing documentation is maintained in ES + EN.
