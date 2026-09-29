# ⚡ xLFr4n // Installation Guide

## 🇪🇸 Español

Esta guía es la referencia operativa para instalar, actualizar y validar **Kali BSPWM 2026**.

### 1️⃣ Preflight

```bash
cat /etc/os-release
uname -m
systemd-detect-virt
echo "XDG_SESSION_TYPE=$XDG_SESSION_TYPE"
echo "DISPLAY=$DISPLAY"
xrandr --query 2>/dev/null || true
```

Debe tratarse de un guest Kali compatible y una sesión X11 disponible para BSPWM.

### 2️⃣ Instalación nueva

```bash
cd ~/Downloads
git clone https://github.com/xlfr4n/kali-bspwm-2026.git
cd kali-bspwm-2026
chmod +x install.sh uninstall.sh
./install.sh
```

No ejecutes `install.sh` como root.

### 3️⃣ Después del instalador

Reinicia:

```bash
reboot
```

Selecciona **BSPWM** en el display manager.

### 4️⃣ Actualización del proyecto

```bash
cd ~/Downloads/kali-bspwm-2026
git pull --ff-only
chmod +x install.sh uninstall.sh
./install.sh
reboot
```

**`git pull` actualiza el checkout; `./install.sh` despliega los cambios.**

### 5️⃣ VirtualBox

```bash
systemd-detect-virt
systemctl is-active virtualbox-guest-utils.service 2>/dev/null || true
systemctl is-active vboxservice.service 2>/dev/null || true
pgrep -a VBoxService || true
xrandr --query
```

### 6️⃣ VMware

```bash
systemd-detect-virt
systemctl is-active open-vm-tools.service 2>/dev/null || true
command -v vmware-user || true
xrandr --query
```

### 7️⃣ Primera comprobación

```bash
doctor.sh
pgrep -a bspwm
pgrep -a sxhkd
pgrep -a polybar
pgrep -a tint2
pgrep -a plank
pgrep -a picom
pgrep -a dunst
```

### 8️⃣ Prueba del workspace

Prueba como mínimo:

```text
Super+Enter
Super+D
Super+Space
Super+Shift+Space
Super+1 ... Super+9
Super+Arrow
Super+Shift+Arrow
Super+Alt+Arrow
Super+Ctrl+Arrow
Super+F
Super+Shift+W
Super+Alt+T
Super+Shift+M
Super+Ctrl+R
```

### 9️⃣ Si el login parece lento

El proyecto ya escalona wallpaper, dock, monitor-refresh y Picom para no competir en el mismo instante.

Registra:

```bash
sed -n '1,220p' ~/.cache/xlfr4n-session.log
systemd-analyze --user blame 2>/dev/null | head -30 || true
journalctl --user -b --no-pager | tail -200
```

No reinstales varias veces a ciegas.

### 🔟 Rollback

```bash
./uninstall.sh
```

El último backup queda bajo:

```text
~/.kali-bspwm-backups/
```

## 🇬🇧 English

This is the operational reference for installing, updating and validating **Kali BSPWM 2026**.

### 1️⃣ Preflight

```bash
cat /etc/os-release
uname -m
systemd-detect-virt
echo "XDG_SESSION_TYPE=$XDG_SESSION_TYPE"
echo "DISPLAY=$DISPLAY"
xrandr --query 2>/dev/null || true
```

Use a compatible Kali guest with an available X11 session.

### 2️⃣ Fresh install

```bash
cd ~/Downloads
git clone https://github.com/xlfr4n/kali-bspwm-2026.git
cd kali-bspwm-2026
chmod +x install.sh uninstall.sh
./install.sh
```

Do not run the installer as root.

### 3️⃣ After installation

```bash
reboot
```

Select **BSPWM** in the display manager.

### 4️⃣ Update an existing checkout

```bash
cd ~/Downloads/kali-bspwm-2026
git pull --ff-only
chmod +x install.sh uninstall.sh
./install.sh
reboot
```

**`git pull` updates the checkout; `./install.sh` deploys the updated configuration.**

### 5️⃣ VirtualBox

```bash
systemd-detect-virt
systemctl is-active virtualbox-guest-utils.service 2>/dev/null || true
systemctl is-active vboxservice.service 2>/dev/null || true
pgrep -a VBoxService || true
xrandr --query
```

### 6️⃣ VMware

```bash
systemd-detect-virt
systemctl is-active open-vm-tools.service 2>/dev/null || true
command -v vmware-user || true
xrandr --query
```

### 7️⃣ First health check

```bash
doctor.sh
pgrep -a bspwm
pgrep -a sxhkd
pgrep -a polybar
pgrep -a tint2
pgrep -a plank
pgrep -a picom
pgrep -a dunst
```

### 8️⃣ Workspace smoke test

At minimum, test launcher, Spotlight, Mission Control, workspaces, focus/swap/resize, fullscreen, wallpaper, theme switch, monitor refresh and doctor.

### 9️⃣ Slow-login diagnostics

The session stages heavier jobs instead of running them as one blocking chain.

Collect:

```bash
sed -n '1,220p' ~/.cache/xlfr4n-session.log
systemd-analyze --user blame 2>/dev/null | head -30 || true
journalctl --user -b --no-pager | tail -200
```

Avoid repeated blind reinstalls.

### 🔟 Rollback

```bash
./uninstall.sh
```

Timestamped backups remain under:

```text
~/.kali-bspwm-backups/
```
