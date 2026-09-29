# 🧪 First VM Test / Primera prueba de VM

## 🇪🇸 Español

Esta guía sirve para validar la primera instalación del proyecto dentro de un **guest Kali**. La virtualización puede ser VirtualBox o VMware.

### 1️⃣ Preflight

```bash
cat /etc/os-release
uname -m
systemd-detect-virt
echo "XDG_SESSION_TYPE=$XDG_SESSION_TYPE"
echo "DISPLAY=$DISPLAY"
xrandr --query 2>/dev/null || true
free -h
```

Base esperada:

- Kali Linux
- x86_64
- sesión X11
- virtualización identificable cuando se usa una VM

### 2️⃣ Instalar

```bash
git clone https://github.com/xlfr4n/kali-bspwm-2026.git
cd kali-bspwm-2026
chmod +x install.sh uninstall.sh
./install.sh
```

### 3️⃣ Reiniciar y entrar

```bash
reboot
```

Selecciona **BSPWM** en el display manager.

### 4️⃣ Primera comprobación

```bash
doctor.sh
systemd-detect-virt
xrandr --query
pgrep -a bspwm
pgrep -a sxhkd
pgrep -a polybar
pgrep -a tint2
pgrep -a plank
pgrep -a picom
pgrep -a dunst
```

No todos los backends del dock deben estar ejecutándose a la vez: `dock` selecciona uno.

### 5️⃣ Smoke test

```text
Super+Enter
Super+D
Super+Space
Super+Shift+Space
Super+1 ... Super+9
Super+Arrow
Super+Shift+Arrow
Super+F
Super+Shift+W
Super+Alt+T
Super+Shift+M
Super+Ctrl+R
```

### 6️⃣ Target / VPN

```bash
settarget --status
```

Con una VPN `tun*` o `wg*` activa, Polybar puede mostrar su estado.

### 7️⃣ Si el login parece lento

El arranque del proyecto no espera a que terminen wallpaper, dock, monitor-refresh o Picom.

Recoge:

```bash
sed -n '1,220p' ~/.cache/xlfr4n-session.log
systemd-analyze --user blame 2>/dev/null | head -30 || true
journalctl --user -b --no-pager | tail -200
```

### 8️⃣ Evidencia

Si aparece un problema visual, no reinstales repetidamente. Guarda también:

```bash
cat /tmp/kali-bspwm-polybar.log 2>/dev/null || true
cat /tmp/kali-bspwm-picom.log 2>/dev/null || true
xrandr --query
```

## 🇬🇧 English

This guide validates the first installation inside a **Kali guest**. The hypervisor may be VirtualBox or VMware.

Run the preflight commands, install the project, reboot into BSPWM and use `doctor.sh` plus the process checks above.

The dock is intentionally single-backend at runtime: Tint2 is preferred, with Plank or native Polybar fallback.

For slow login, collect the session log and user-service diagnostics before reinstalling.

**⚡ xLFr4n · Verify the guest, not the illusion.**
