# ⚡ xLFr4n // Final Desktop Audit

> 🇪🇸 Auditoría integral del workspace · 🇬🇧 Full workspace audit

## 🇪🇸 Español

Esta lista define el estado interno del proyecto y separa explícitamente lo validado en código de lo que requiere la última prueba visual dentro de la VM.

| Área | Estado | Qué se cubre |
|---|---|---|
| 🖥️ BSPWM | ✅ | 9 escritorios, ventanas frameless, padding de sesión, reglas flotantes y fullscreen |
| ⌨️ SXHKD | ✅ | Atajos de ventanas, workspaces, apps, media, captura, lock y VM |
| 📊 Polybar | ✅ | Barra superior transparente, rail inferior separado y acciones interactivas |
| 🗓️ Fecha/hora | ✅ | Fecha larga en español por defecto, hora separada y mejor jerarquía visual |
| 🧭 Workspaces | ✅ | 1→9 abajo a la izquierda + HUD de transición |
| 🧊 Dock | ✅ | Tint2 → Plank → Polybar, launchers reales, hover y foco de ventanas |
| 🖥️ Ghostty + tmux | ✅ | Terminal única, scrollback amplio, copia/pega explícitos, persistencia y panes |
| 🌫️ Picom | ✅ | Fades, sombras y redondeado VM-friendly |
| 🔔 Dunst | ✅ | Feedback temporal, stacking, historial, workspace HUD y lanzamiento de aplicaciones |
| 🎨 Themes | ✅ | Polybar, Ghostty, Rofi, Dunst, BSPWM y fallback Plank sincronizados |
| 🖼️ Wallpapers | ✅ | Wallpaper de sesión fijo en `kali-hack-16x9.jpg` + random/next/current/set manuales y feedback |
| 🌐 Red/VPN | ✅ | Ruta por defecto, Wi-Fi/Ethernet/VPN y estados de color |
| 🔋 Batería | ✅ | Opcional, silenciosa sin batería y estados de color |
| 🎯 Target | ✅ | Set/status/copy/clear, control blanco y pulso de entrada de una sola vez por sesión |
| 🩺 Doctor | ✅ | Diagnóstico read-only de runtime, visual, VM y helpers |
| 🖥️ VM | ✅ | VirtualBox/VMware detectados desde el guest |
| 🚀 Startup | ✅ | Fases escalonadas + bloqueo single-instance + limpieza scoped al usuario |
| 🧪 CI | ✅ | Última ejecución verificada sobre `main`: static guards, Rofi, desktop-file validation y ShellCheck pasan |
| 📚 Docs | ✅ | README ES/EN, instalación, arquitectura, VM, estilo, Fastfetch y launch feedback |
| 🟥 Red Team Lab | ✅* | Engagement, scope, targets, evidence, findings, reporting, tool profiles y smoke test estructural; AD/Web multi-VM todavía requieren la validación L3-L7 del laboratorio real |

### 🔬 Estado del Red Team Lab

*El controlador y su CI están cubiertos; la topología AD/Web multi-VM y los ejercicios prácticos permanecen como las siguientes fases de laboratorio, no como funciones ya validadas en esta VM.

### 🔬 Última comprobación externa

CI valida sintaxis, guardas, Rofi, launchers `.desktop` y ShellCheck sobre `main`. La única comprobación que permanece ligada a la máquina real es la inspección visual/ergonómica después de `git pull` + `./install.sh --deploy`, especialmente la posición final del rail 1→9/fecha, el pulso superior, el dock y la entrega de notificaciones.

## 🇬🇧 English

The desktop layers and CI are aligned on `main`; the remaining real-world gate is the final visual smoke test on the target VM/monitor combination after deployment, including Fastfetch, lower rail geometry, white `APPS`/`TARGET`, one-shot TARGET entrance animation, frameless windows, dock click-through and launch notifications.

### ✅ Validation commands

```bash
bash tests/static.sh
bash tests/shellcheck.sh
doctor.sh
session-profile
```

**⚡ xLFr4n · no component removed; each pass adds, hardens or aligns existing behaviour.**
