# ⚙️ Configuration

> ⚡ **xLFr4n configuration layer · ES + EN**

## 🇪🇸 Español

Esta carpeta contiene configuración declarativa para BSPWM, SXHKD, Polybar, Kitty, Picom, Rofi, Dunst y otros componentes del entorno.

Los archivos de configuración forman parte del sistema instalable y deben mantenerse reproducibles. No se deben introducir secretos personales ni rutas de máquina que solo funcionen en un único host.

## 🇬🇧 English

This directory contains declarative configuration for BSPWM, SXHKD, Polybar, Kitty, Picom, Rofi, Dunst and other desktop components.

Configuration is part of the reproducible installation system. Do not introduce personal secrets or machine-specific paths that only work on one host.

**⚡ xLFr4n · Configuration as documentation**


## 🪟 Desktop presentation / Presentación del escritorio

The desktop layer now combines a floating rounded Polybar, a real-icon Tint2 launcher dock with Plank/Polybar fallback, Spotlight-like application search, Mission Control, Brave-first launch and Papirus-Dark icon selection when available. All of it remains under the existing BSPWM/SXHKD architecture.


### 🧭 Workspace layout

The desktop intentionally uses **nine workspaces (1→9)**. The clock and workspace selector live in a compact bar at the bottom-right so the top status bar stays readable.

El escritorio utiliza deliberadamente **nueve escritorios (1→9)**. La hora y el selector de escritorios viven en una barra compacta abajo a la derecha para mantener limpia la barra superior.

### 🎯 Floating application dock

Tint2 is the preferred dock backend because its launcher entries use real `.desktop` files and icon themes. Plank and the native Polybar dock remain compatible fallbacks.

Tint2 es el backend preferido porque sus lanzadores utilizan archivos `.desktop` e iconos reales. Plank y el dock nativo de Polybar siguen como respaldos compatibles.
