# ⚡ xlfr4n // Scripts

## 🇪🇸 Español

Los helpers de **Kali BSPWM 2026** forman la capa operativa del escritorio: sesión, target, monitores, temas, wallpapers, VMware, diagnóstico, identidad visual y controles del sistema. Los helpers `launcher-pulse` y `telemetry-pulse` se conservan por compatibilidad del repositorio, pero no se cargan en la interfaz actual.

Todos los scripts activos llevan la firma **xlfr4n**.

## 🇬🇧 English

The **Kali BSPWM 2026** helpers form the operational desktop layer: session startup, targets, monitors, themes, wallpapers, VMware, diagnostics, visual identity and system controls.

All active scripts carry the **xlfr4n** signature.

---

<p align="center"><strong>⚡ xlfr4n</strong> · Terminal first · Reproducible always</p>


## ⏱️ Session profiling / Perfil de sesión

### 🇪🇸 Español

`session-profile` lee `~/.cache/xlfr4n-session.log` sin modificar el sistema y muestra el orden temporal del arranque.

```bash
session-profile
```

### 🇬🇧 English

`session-profile` reads `~/.cache/xlfr4n-session.log` without modifying the system and shows the timing order of the startup phases.

```bash
session-profile
```


## 🎛️ UX helpers / Helpers de UX

### 🇪🇸 Español

- `xlfr4n-terminal` usa Ghostty como único backend gráfico y abre tmux automáticamente cuando está disponible.
- `lab` crea un workspace persistente de tmux para organizar recon/web/notas/loot sin ejecutar herramientas de seguridad automáticamente.
- `xlfr4n-banner` imprime el snapshot de terminal como herramienta manual de diagnóstico.
- `xlfr4n-pulse` ejecuta el barrido de señal visible de la identidad superior y adapta sus colores al tema activo.
- `target-pulse` muestra `TARGET` en blanco y ejecuta únicamente el pulso de entrada de la sesión; después queda estático.
- `launcher-pulse` queda conservado como helper histórico/referencia y no está conectado al Polybar actual.
- `xlfr4n-launch` centraliza el feedback Dunst de los lanzamientos iniciados desde atajos y menús propios.
- `xLFr4n-dock-launch` actúa como puente absoluto para los launchers gráficos `.desktop`, evitando depender del PATH de la shell.
- `xlfr4n-date` genera la fecha larga en español por defecto; `XLFR4N_DATE_LOCALE=system` permite seguir `LC_TIME`.
- `telemetry-pulse` queda conservado como helper histórico/referencia y no está conectado al Polybar actual.
- `workspace-hud` escucha los cambios de escritorio de BSPWM y muestra un feedback breve, apilado y animado mediante Dunst/Picom.
- `audio-control` mantiene las teclas multimedia con feedback visual y usa `pamixer` o `wpctl`.
- `network-status` sigue la interfaz de la ruta por defecto; ya no asume Ethernet.
- `battery-status` aparece automáticamente cuando Kali expone una batería y permanece silencioso en una VM/PC sin ella.

### 🇬🇧 English

- `xlfr4n-terminal` uses Ghostty as the only graphical backend and starts tmux automatically when available.
- `lab` creates a persistent tmux workspace for recon/web/notes/loot organization without automatically running security tooling.
- `xlfr4n-banner` prints the terminal system snapshot as a manual diagnostic tool.
- `xlfr4n-pulse` provides the visible signal sweep used by the top Polybar identity and follows the active theme.
- `target-pulse` renders `TARGET` in white and only performs the session-entry pulse; it remains static afterwards.
- `launcher-pulse` is retained as a historical/reference helper and is not connected to the current Polybar.
- `telemetry-pulse` is retained as a historical/reference helper and is not connected to the current Polybar.
- `xlfr4n-launch` centralizes Dunst launch feedback for apps started from the workspace's own shortcuts and menus.
- `xLFr4n-dock-launch` is the absolute bridge used by graphical `.desktop` launchers, avoiding shell PATH inheritance issues.
- `xlfr4n-date` renders the long date in Spanish by default; set `XLFR4N_DATE_LOCALE=system` to follow `LC_TIME`.
- `workspace-hud` listens for BSPWM desktop changes and provides a brief stacked visual transition cue through Dunst/Picom.
- `audio-control` keeps media keys with visual feedback and uses `pamixer` or `wpctl`.
- `network-status` follows the default-route interface instead of assuming Ethernet.
- `battery-status` appears automatically when Kali exposes a battery and stays silent on VM/desktop systems without one.

## ⌨️ Keys & brightness / Atajos y brillo

### 🇪🇸 Español

`keys-help` (`Super + F1`) genera una chuleta de atajos buscable a partir del `sxhkdrc` real. `brightness-control up|down` ajusta el brillo con `brightnessctl` o `xbacklight` y no hace nada en máquinas sin retroiluminación.

### 🇬🇧 English

`keys-help` (`Super + F1`) builds a searchable shortcut cheat sheet from the live `sxhkdrc`. `brightness-control up|down` adjusts brightness through `brightnessctl` or `xbacklight` and is a silent no-op on machines without a backlight.
