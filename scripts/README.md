# ⚡ xlfr4n // Scripts

## 🇪🇸 Español

Los helpers de **Kali BSPWM 2026** forman la capa operativa del escritorio: sesión, target, monitores, temas, wallpapers, VMware, diagnóstico y controles del sistema.

Todos los scripts activos llevan la firma **xlfr4n**.

## 🇬🇧 English

The **Kali BSPWM 2026** helpers form the operational desktop layer: session startup, targets, monitors, themes, wallpapers, VMware, diagnostics and system controls.

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

- `workspace-hud` escucha los cambios de escritorio de BSPWM y muestra un feedback breve, apilado y animado mediante Dunst/Picom.
- `audio-control` mantiene las teclas multimedia con feedback visual y usa `pamixer` o `wpctl`.
- `network-status` sigue la interfaz de la ruta por defecto; ya no asume Ethernet.
- `battery-status` aparece automáticamente cuando Kali expone una batería y permanece silencioso en una VM/PC sin ella.

### 🇬🇧 English

- `workspace-hud` listens for BSPWM desktop changes and provides a brief stacked visual transition cue through Dunst/Picom.
- `audio-control` keeps media keys with visual feedback and uses `pamixer` or `wpctl`.
- `network-status` follows the default-route interface instead of assuming Ethernet.
- `battery-status` appears automatically when Kali exposes a battery and stays silent on VM/desktop systems without one.
