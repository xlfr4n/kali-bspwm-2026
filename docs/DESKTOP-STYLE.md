# 🍎 xLFr4n Floating Workspace

## 🇪🇸 Español

La capa visual mantiene Kali + BSPWM ligero y añade ergonomía inspirada en interfaces de escritorio modernas sin introducir un escritorio completo.

### 🎨 Lenguaje visual

- Barra superior negra semitransparente, sin borde, usada como zona segura de legibilidad.
- Barra inferior negra semitransparente, sin borde, alineada al borde físico inferior; protege fecha, hora y workspaces.
- Escritorios 1→9 compactos abajo a la izquierda.
- Fecha y hora abajo a la derecha; la fecha larga es española por defecto y admite `XLFR4N_DATE_LOCALE=system` para seguir el locale de la sesión.
- Dock Tint2 centrado con iconos reales, con carril propio separado del rail de workspaces.
- Acento xLFr4n coherente entre Polybar, Ghostty, Rofi, Dunst y BSPWM.
- Picom con fades/sombras suaves y sin blur para conservar compatibilidad con VM.
- Ghostty opaco por defecto para evitar fugas del wallpaper a través de la superficie de la aplicación.
- Fastfetch de entrada con logo oficial de Kali + firma `⚡ xLFr4n` y datos TARGET/IP/fecha.
- Banner de terminal con marco de ancho fijo, reservado para diagnósticos manuales.

### ⚡ Animación

La identidad superior usa un barrido de señal visible y fijo (`[●···]` → `[···●]`) que mantiene `xLFr4n` siempre legible y adapta el color al tema activo. `APPS` permanece estático y blanco; `TARGET` hace únicamente un pulso de entrada al iniciar sesión y después queda estático. El resto de la animación se reserva para feedback útil: cursor, fades de ventana, transición de workspace y hover del dock. La estructura permanece limpia y no depende de animaciones pesadas.

## 🇬🇧 English

The visual layer keeps Kali + BSPWM lightweight while adding modern desktop ergonomics without introducing a full desktop environment.

### 🎨 Visual language

- Black semi-transparent, borderless top safe-zone rail.
- Black semi-transparent, borderless bottom safe-zone rail aligned to the physical edge.
- 1→9 workspaces sit at the lower-left edge, on the same vertical lane as the dock icons.
- Date and time sit at the lower-right edge, on the same vertical lane as the dock icons.
- Centered Tint2 real-icon launcher dock with its own lane, separated from the workspace rail.
- Synchronized xLFr4n accents across Polybar, Ghostty, Rofi, Dunst and BSPWM.
- Picom with soft fades/shadows and no blur for VM compatibility.
- Ghostty is opaque by default so the wallpaper does not bleed through the application surface.
- Fastfetch login view with the official Kali logo, `⚡ xLFr4n` signature and live TARGET/IP/date data.
- Fixed-width terminal banner, reserved for manual diagnostics.

The top identity uses a visible signal sweep (`[●···]` → `[···●]`) that keeps `xLFr4n` readable at all times and follows the active theme. `APPS` stays static and white; `TARGET` performs only a one-shot session-entry pulse and then remains static. Other animation is used only where it provides feedback: cursor effects, window fades, workspace HUD transitions and dock hover.

**⚡ xLFr4n · Kali · BSPWM · floating workspace**


## 🎞️ Feedback layer / Capa de feedback

### 🇪🇸 Español

El escritorio tiene una capa de feedback común para que las acciones importantes tengan una respuesta visible sin llenar la pantalla de widgets:

`workspace-hud` → cambio de escritorio → notificación compacta → fade de Picom.

`audio-control` → volumen/mute → porcentaje visible → fade breve.

Dunst mantiene el historial y apila estas notificaciones para evitar una cascada de ventanas.

### 🇬🇧 English

The desktop uses a shared feedback layer so important actions have a visible response without filling the screen with widgets. The lower date rail is Spanish by default and can follow the session locale with `XLFR4N_DATE_LOCALE=system`:

`workspace-hud` → desktop change → compact two-frame notification → Picom fade.

`audio-control` → volume/mute → visible percentage → short fade.

`xlfr4n-launch` → application request → “LAUNCH” → “READY/OPEN”. Workspace launch paths share the same notification language.

`wallpaper --default` → uses `/usr/share/wallpapers/KaliRedSticker/contents/images/3840x2160.jpg` as the session wallpaper.

Dunst keeps history and stacks these notifications to avoid a cascade of windows.
