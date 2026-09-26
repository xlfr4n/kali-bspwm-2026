# 🧪 Primera prueba VMware / First VMware test

## 🇪🇸 Español

Esta guía valida la primera instalación sobre una máquina Kali real ejecutándose como guest de VMware.

### 1️⃣ Preflight

Antes de modificar el escritorio:

```bash
cat /etc/os-release
uname -m
systemd-detect-virt
echo "XDG_SESSION_TYPE=$XDG_SESSION_TYPE"
echo "DISPLAY=$DISPLAY"
xrandr --query 2>/dev/null || true
free -h
```

Para este proyecto esperamos principalmente:

- 🐧 Kali Linux
- 💻 x86_64
- 🖥️ VMware detectado por `systemd-detect-virt`
- 🪟 sesión X11 cuando se lance BSPWM

### 2️⃣ Instalar

```bash
git clone https://github.com/xlfr4n/kali-bspwm-2026.git
cd kali-bspwm-2026
chmod +x install.sh
./install.sh
```

El instalador:

- 💾 crea un backup con timestamp
- 📦 instala paquetes desde Kali
- 🖥️ registra la sesión BSPWM X11
- 🧩 instala la integración VMware cuando detecta VMware
- 🎨 despliega la configuración
- 🐍 instala pywal16 solo como componente opcional y aislado

### 3️⃣ Reiniciar y entrar en BSPWM

Desde el display manager selecciona:

`bspwm`

La primera sesión debería iniciar:

- 📊 Polybar
- 🐱 Kitty
- 🚀 Rofi
- 🔔 Dunst
- 🌫️ Picom
- 🖼️ wallpaper
- 🎯 target helper
- 🌐 NetworkManager applet

### 4️⃣ Diagnóstico

Abre Kitty y ejecuta:

```bash
doctor.sh
systemd-detect-virt
systemctl is-active open-vm-tools
systemctl is-active open-vm-tools-desktop
xrandr --query
```

### 5️⃣ Pruebas visuales

Comprueba:

```text
Super+Enter       → Kitty
Super+D           → launcher
Super+Arrow       → focus
Super+Shift+Arrow → swap
Super+F           → fullscreen
Super+M           → monocle
Super+Shift+W     → wallpaper
Super+Alt+T       → themes
Super+Shift+L     → lab
Super+Shift+K     → lock
```

### 6️⃣ Prueba de target + VPN

```bash
settarget 10.10.10.10 Web01
settarget --status
```

Con una interfaz VPN activa, Polybar debería mostrarla automáticamente si utiliza `tun*` o `wg*`.

### 7️⃣ Multi-monitor

Conecta/configura el segundo monitor virtual o físico en VMware y ejecuta:

```bash
monitor-refresh
xrandr --query
```

La configuración actual coloca el segundo monitor a la derecha y reparte los escritorios entre las dos pantallas.

### 8️⃣ Qué registrar si algo falla

No reinstales varias veces a ciegas. Guarda primero:

```bash
doctor.sh
systemd-detect-virt
systemctl --failed
journalctl --user -b --no-pager | tail -200
cat /tmp/kali-bspwm-polybar.log 2>/dev/null || true
xrandr --query
```

Esto permite aislar el fallo antes de cambiar configuración.

---

## 🇬🇧 English

This procedure validates the first installation on a real Kali guest running under VMware.

### 1️⃣ Preflight

Run before changing the desktop:

```bash
cat /etc/os-release
uname -m
systemd-detect-virt
echo "XDG_SESSION_TYPE=$XDG_SESSION_TYPE"
echo "DISPLAY=$DISPLAY"
xrandr --query 2>/dev/null || true
free -h
```

Expected baseline:

- 🐧 Kali Linux
- 💻 x86_64
- 🖥️ VMware detected by `systemd-detect-virt`
- 🪟 X11 available when BSPWM is launched

### 2️⃣ Install

```bash
git clone https://github.com/xlfr4n/kali-bspwm-2026.git
cd kali-bspwm-2026
chmod +x install.sh
./install.sh
```

The installer creates a timestamped backup, installs Kali packages, registers the BSPWM X11 session, enables VMware guest integration when detected and deploys the desktop configuration.

### 3️⃣ Reboot into BSPWM

Choose `bspwm` from the display manager.

### 4️⃣ Diagnostics

```bash
doctor.sh
systemd-detect-virt
systemctl is-active open-vm-tools
systemctl is-active open-vm-tools-desktop
xrandr --query
```

### 5️⃣ Visual checks

Test Kitty, Rofi, focus/swap, fullscreen, monocle, wallpapers, themes, the lab workspace and screen lock.

### 6️⃣ Target + VPN

```bash
settarget 10.10.10.10 Web01
settarget --status
```

Polybar should detect `tun*` and `wg*` VPN interfaces automatically.

### 7️⃣ Multiple monitors

```bash
monitor-refresh
xrandr --query
```

### 8️⃣ Failure capture

Before reinstalling or changing random settings:

```bash
doctor.sh
systemd-detect-virt
systemctl --failed
journalctl --user -b --no-pager | tail -200
cat /tmp/kali-bspwm-polybar.log 2>/dev/null || true
xrandr --query
```

These outputs are the evidence used to troubleshoot the first live VM test.

## 📌 Validation status

🧪 **First live VMware test: pending / pendiente**

Static repository checks and CI are useful, but the guest itself is the final compatibility test.
