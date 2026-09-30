# 🍎 xLFr4n Floating Workspace

## 🇪🇸 Español

La capa visual mantiene Kali + BSPWM ligero y añade ergonomía inspirada en interfaces de escritorio modernas sin introducir un escritorio completo.

### 🎨 Lenguaje visual

- Barra superior transparente y sin borde.
- Barra inferior transparente y sin borde.
- Escritorios 1→9 compactos abajo a la izquierda.
- Fecha y hora abajo a la derecha; la fecha larga es española por defecto y admite `XLFR4N_DATE_LOCALE=system` para seguir el locale de la sesión.
- Dock centrado con iconos reales.
- Acento xLFr4n coherente entre Polybar, Kitty, Rofi, Dunst y BSPWM.
- Picom con fades/sombras suaves y sin blur para conservar compatibilidad con VM.
- Fastfetch de entrada con logo oficial de Kali + firma `⚡ xLFr4n` y datos TARGET/IP/fecha.
- Banner de terminal con marco de ancho fijo, reservado para diagnósticos manuales.

### ⚡ Animación

La identidad superior usa un barrido de señal visible y fijo (`[●···]` → `[···●]`) que mantiene `xLFr4n` siempre legible y adapta el color al tema activo. El resto de la animación se reserva para lugares donde aporta feedback: cursor, fades de ventana, transición de workspace mediante el HUD, feedback de audio y hover del dock. El banner de Kitty usa fases cortas y un progreso visual para sentirse vivo sin mantener procesos en segundo plano. La estructura del escritorio permanece limpia y no depende de animaciones pesadas.

## 🇬🇧 English

The visual layer keeps Kali + BSPWM lightweight while adding modern desktop ergonomics without introducing a full desktop environment.

### 🎨 Visual language

- Transparent, borderless top rail.
- Transparent, borderless bottom rail.
- Compact 1→9 workspaces on the lower-left.
- Date and time on the lower-right.
- Centered real-icon launcher dock.
- Synchronized xLFr4n accents across Polybar, Kitty, Rofi, Dunst and BSPWM.
- Picom with soft fades/shadows and no blur for VM compatibility.
- Fastfetch login view with the official Kali logo, `⚡ xLFr4n` signature and live TARGET/IP/date data.
- Fixed-width terminal banner, reserved for manual diagnostics.

The top identity uses a small typewriter/dissolve micro-animation: `xLFr4n` appears and disappears character by character with a discreet cursor. Other animation is used where it provides feedback rather than visual noise: cursor effects, window fades, workspace HUD transitions, audio feedback and dock hover.

**⚡ xLFr4n · Kali · BSPWM · floating workspace**


## 🎞️ Feedback layer / Capa de feedback

### 🇪🇸 Español

El escritorio tiene una capa de feedback común para que las acciones importantes tengan una respuesta visible sin llenar la pantalla de widgets:

`workspace-hud` → cambio de escritorio → notificación compacta → fade de Picom.

`audio-control` → volumen/mute → porcentaje visible → fade breve.

Dunst mantiene el historial y apila estas notificaciones para evitar una cascada de ventanas.

### 🇬🇧 English

The desktop uses a shared feedback layer so important actions have a visible response without filling the screen with widgets. The lower date rail follows the system `LC_TIME` locale when available:

`workspace-hud` → desktop change → compact two-frame notification → Picom fade.

`audio-control` → volume/mute → visible percentage → short fade.

`xlfr4n-launch` → application request → “LAUNCH” → “READY/OPEN”. Workspace launch paths share the same notification language.

`wallpaper --default` → uses `/usr/share/backgrounds/kali/kali-hack-16x9.jpg` as the session wallpaper.

Dunst keeps history and stacks these notifications to avoid a cascade of windows.
