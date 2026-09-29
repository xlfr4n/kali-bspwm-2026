# ⚡ xLFr4n // Final Desktop Audit

> 🇪🇸 Auditoría integral del workspace · 🇬🇧 Full workspace audit

## 🇪🇸 Español

Esta lista define el cierre funcional del proyecto sin sustituir la última prueba visual dentro de cada máquina.

| Área | Estado | Qué se cubre |
|---|---|---|
| 🖥️ BSPWM | ✅ | 9 escritorios, borders, padding, reglas flotantes y fullscreen |
| ⌨️ SXHKD | ✅ | Atajos de ventanas, workspaces, apps, media, captura, lock y VM |
| 📊 Polybar | ✅ | Barra superior transparente, rail inferior separado y acciones interactivas |
| 🗓️ Fecha/hora | ✅ | Fecha larga con `LC_TIME`, hora separada y mejor jerarquía visual |
| 🧭 Workspaces | ✅ | 1→9 abajo a la izquierda + HUD de transición |
| 🧊 Dock | ✅ | Tint2 → Plank → Polybar, launchers reales, hover y foco de ventanas |
| 🐱 Kitty | ✅ | Banner animado, tabs, cursor, transparencia, reload y controles rápidos |
| 🌫️ Picom | ✅ | Fades, sombras y redondeado VM-friendly |
| 🔔 Dunst | ✅ | Feedback temporal, stacking, historial y transiciones del HUD |
| 🎨 Themes | ✅ | Polybar, Kitty, Rofi, Dunst, BSPWM y fallback Plank sincronizados |
| 🖼️ Wallpapers | ✅ | Índice cacheado, preparación dark, random/next/current/set y feedback |
| 🌐 Red/VPN | ✅ | Ruta por defecto, Wi-Fi/Ethernet/VPN y estados de color |
| 🔋 Batería | ✅ | Opcional, silenciosa sin batería y estados de color |
| 🎯 Target | ✅ | Set/status/copy/clear con acceso visible desde Polybar |
| 🩺 Doctor | ✅ | Diagnóstico read-only de runtime, visual, VM y helpers |
| 🖥️ VM | ✅ | VirtualBox/VMware detectados desde el guest |
| 🚀 Startup | ✅ | Fases escalonadas + bloqueo single-instance + limpieza scoped al usuario |
| 🧪 CI | ✅ | Bash/static guards, Rofi y ShellCheck sobre los scripts del proyecto |
| 📚 Docs | ✅ | README ES/EN, instalación, arquitectura, VM, estilo y helpers |

### 🔬 Última comprobación externa

El CI sirve para validar sintaxis, guardas, Rofi y ShellCheck, pero la comprobación final del aspecto depende de la VM/monitor reales. La rama `main` debe probarse después de `git pull` + `./install.sh --deploy`.

## 🇬🇧 English

The project is functionally closed across the desktop layers. The remaining real-world step is the final visual smoke test on the target VM/monitor combination after deployment.

### ✅ Validation commands

```bash
bash tests/static.sh
bash tests/shellcheck.sh
doctor.sh
session-profile
```

**⚡ xLFr4n · no component removed; each pass adds, hardens or aligns existing behaviour.**
