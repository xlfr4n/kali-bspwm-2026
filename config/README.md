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
- Fastfetch con identidad visual `xLFr4n`;
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

Las barras no dibujan un panel sólido detrás del contenido. El dock es launcher-only y no pretende ser una taskbar tradicional.

Al abrir una shell interactiva, Fastfetch muestra el logo custom `xLFr4n` en lugar de depender del logo de ZLCube. El banner ASCII `xlfr4n-banner` se conserva como snapshot manual para diagnósticos.

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
- Fastfetch with the custom `xLFr4n` visual identity;
- icons and desktop launchers.

### 🧭 Current presentation

The visual language is intentionally clean: transparent top and bottom rails, compact 1→9 workspaces on the lower-left, date/time on the lower-right and a centered icon launcher dock.

Configuration is reproducible and should not contain personal secrets or host-only paths. Fastfetch uses a repository-owned custom logo, while `xlfr4n-banner` remains available for manual system snapshots. The lower date follows `LC_TIME`; status modules expose useful actions instead of being purely decorative.

**⚡ xLFr4n · Configuration as documentation**
