# 🎯 xLFr4n Floating Dock

> ⚡ **Real application launchers, real icons, zero taskbar noise.**

## 🇪🇸 Español

El dock principal utiliza **Tint2 en modo launcher-only** cuando está disponible en Kali. No muestra taskbar, batería ni bandeja: solo iconos flotantes de las aplicaciones del workspace.

Cada icono corresponde a una aplicación y abre el programa; cuando detecta una ventana existente, el helper `dock-launch` intenta enfocarla en lugar de duplicarla.

Las aplicaciones se cargan mediante archivos `.desktop` del usuario y el tema de iconos **Papirus-Dark** cuando está disponible.

Si Tint2 no está disponible en el snapshot de Kali, el helper `dock` mantiene una ruta de respaldo con Plank o Polybar.

## 🇬🇧 English

The main dock uses **Tint2 in launcher-only mode** when available in Kali. It deliberately hides the taskbar, battery and system tray and keeps only floating application icons.

Each icon maps to an application and launches it; when an existing window is detected, the `dock-launch` helper tries to focus it instead of creating another instance.

Launchers use the user's `.desktop` files and **Papirus-Dark** when available.

If Tint2 is unavailable in the current Kali snapshot, `dock` falls back to Plank or the native Polybar dock.

**⚡ xLFr4n · floating apps · dark glass · focused workflow**
