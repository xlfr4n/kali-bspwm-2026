# ⚙️ Configuration

> ⚡ **xLFr4n configuration layer · ES + EN**

## 🇪🇸 Español

Esta carpeta contiene la configuración reproducible del workspace:

- BSPWM + SXHKD;
- Polybar;
- Kitty;
- Rofi;
- Picom;
- Dunst;
- Tint2;
- Plank fallback;
- Zsh;
- Fastfetch con logo oficial de Kali y firma `⚡ xLFr4n`;
- iconos y lanzadores.

### 🧭 Presentación actual

La interfaz utiliza una composición deliberadamente limpia:

```text
TOP
  Polybar transparente · estado del sistema · target · red · CPU/RAM/disco/audio

BOTTOM
  1 2 3 4 5 6 7 8 9                         📅 fecha larga ·  hora
                         iconos del dock
```

Las barras no dibujan un panel sólido detrás del contenido. El dock es launcher-only y no pretende ser una taskbar tradicional. Las ventanas son frameless: no se usa un borde rojo de BSPWM, Kitty, Rofi, Tint2 o Plank.

Al abrir una shell interactiva, Fastfetch muestra el logo oficial de Kali con la firma `⚡ xLFr4n` debajo, junto a TARGET, IP y fecha. El banner ASCII `xlfr4n-banner` se conserva como snapshot manual para diagnósticos.

## 🇬🇧 English

This directory contains the reproducible workspace configuration:

- BSPWM + SXHKD;
- Polybar;
- Kitty;
- Rofi;
- Picom;
- Dunst;
- Tint2;
- Plank fallback;
- Zsh;
- Fastfetch with the official Kali logo and `⚡ xLFr4n` signature;
- icons and desktop launchers.

### 🧭 Current presentation

The visual language is intentionally clean: transparent top and bottom rails, compact 1→9 workspaces lowered into the dock lane, Spanish date/time on the lower-right, and a centered icon launcher dock.

Configuration is reproducible and should not contain personal secrets or host-only paths. Fastfetch keeps the official Kali logo as its visual base and adds the `⚡ xLFr4n` signature below it. Kitty is opaque by default so the wallpaper does not bleed through application surfaces; the existing Kitty opacity shortcuts remain available for intentional manual transparency. TARGET, local IP and date/time are shown as live session data; `xlfr4n-banner` remains available for manual system snapshots. The displayed date/time is Spanish by default; set `XLFR4N_DATE_LOCALE=system` to follow the session `LC_TIME` locale.

**⚡ xLFr4n · Configuration as documentation**
