# ⚡ xLFr4n // Architecture

> 🧩 **One desktop, separate layers, predictable behaviour.**

## 🇪🇸 Español

Kali BSPWM 2026 está separado por responsabilidades: el window manager gestiona ventanas, SXHKD atajos, Polybar información, Tint2 el dock y los helpers las tareas auxiliares.

### 🚀 Flujo de sesión

```text
Display Manager
      ↓
     BSPWM
      ↓
  autostart
      │
      ├─ PHASE 1 · sxhkd + dunst + Polybar + BSPWM borders
      │
      └─ PHASE 2 · staged background work
                  ├─ monitor-refresh
                  ├─ desktop-style
                  ├─ wallpaper
                  ├─ dock
                  └─ Picom
```

La Fase 2 no bloquea la creación de la sesión. Las tareas que pueden consumir CPU/I/O se escalonan para reducir el trabajo simultáneo durante el login.

### 🧱 Capas

| Capa | Responsabilidad |
|---|---|
| `install.sh` | Comprueba Kali, detecta virtualización, instala paquetes, crea backups y despliega. |
| `config/` | Configuración reproducible de BSPWM, SXHKD, Polybar, Ghostty + tmux, Kitty fallback, Rofi, Picom, Dunst, Tint2/Plank y Zsh. |
| `scripts/` | Menú, dock, target, wallpapers, monitores, themes, diagnóstico y VM helpers. |
| `docs/` | Procedimientos operativos y validación. |
| `tests/` | Bash syntax, static guards y ShellCheck/CI. |

### 🖥️ Workspace

- 9 escritorios BSPWM: `1 → 9`.
- Workspace activo: acento rojo/línea fina, sin caja.
- Barra superior: transparente y sin borde.
- Barra inferior: transparente y sin borde.
- Fecha + hora: abajo a la derecha.
- Dock: centrado y launcher-only.

### 🖥️ Terminal layer

Ghostty is the preferred graphical terminal and tmux owns persistence, pane layouts and synchronized input. The xlfr4n-terminal helper selects Ghostty automatically when available and falls back to Kitty.

The repository deliberately keeps config/kitty/ so the previous terminal profile remains recoverable during VM validation.

### 🎨 Themes

Los themes sincronizan Polybar, Kitty, Rofi, Dunst y los colores de borde de BSPWM. `pywal16` es opcional.

### 🔐 Principios

- Backup antes de reemplazar configuración.
- Cambios reversibles.
- Guest-first: el host queda fuera del instalador.
- X11 como base de BSPWM.
- Diagnóstico read-only.
- Sin dependencias Python obligatorias.
- Sin repositorios Debian de terceros para el núcleo.

## 🇬🇧 English

Kali BSPWM 2026 is split by responsibility. BSPWM manages windows, SXHKD handles shortcuts, Polybar displays state, Tint2 provides the launcher dock, and helper scripts handle session tasks.

Startup is intentionally staged so the usable desktop appears before heavier visual work.

### 🖥️ Workspace

- 9 BSPWM desktops: `1 → 9`.
- Focused desktop: accent/underline, no box.
- Top rail: transparent and borderless.
- Bottom rail: transparent and borderless.
- Date + time: bottom-right.
- Dock: centered launcher-only layer.

### 🔐 Design principles

Backups before overwrite, reversible changes, guest-only configuration, X11-native BSPWM behaviour, read-only diagnostics and a reliable static-theme core.

**⚡ xLFr4n · One system, clear layers.**


## 🎞️ UX feedback / Feedback visual

### 🇪🇸 Español

La capa interactiva se apoya en helpers ligeros y eventos, no en un segundo daemon de escritorio pesado:

`bspc desktop focus` → `workspace-hud` → Dunst → fade de Picom.

Las teclas multimedia llaman a `audio-control`, que utiliza `pamixer` o `wpctl` y comunica el estado mediante una notificación breve.

Polybar usa helpers pequeños para estado dinámico: `network-status` sigue la ruta por defecto y `battery-status` permanece silencioso cuando no hay batería.

### 🇬🇧 English

The interactive layer relies on lightweight helpers and events instead of a heavy desktop daemon:

`bspc desktop focus` → `workspace-hud` → Dunst → Picom fade.

Media keys call `audio-control`, which uses `pamixer` or `wpctl` and reports the state with a short notification.

Polybar uses small dynamic status helpers: `network-status` follows the default route and `battery-status` stays silent when no battery exists.
