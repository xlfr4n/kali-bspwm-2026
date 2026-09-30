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

Actualización completa, incluidos paquetes:

```bash
cd ~/Downloads/kali-bspwm-2026
git pull --ff-only
chmod +x install.sh uninstall.sh
./install.sh
reboot
```

Actualización rápida del workspace, sin APT:

```bash
cd ~/Downloads/kali-bspwm-2026
git pull --ff-only
./install.sh --deploy
bspc wm -r
```

**`git pull` actualiza el checkout; `./install.sh` despliega los cambios. `--deploy` está pensado para iterar rápidamente sobre la configuración.**

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

### 7️⃣ Terminal stack

The installer keeps Kitty available as a fallback and makes tmux part of the core terminal workflow. Ghostty is attempted as an optional Kali package when the configured repository contains it.

    xlfr4n-terminal --backend
    tmux -V
    command -v ghostty || true
    command -v kitty || true

Preferred path:

    Ghostty → tmux → zsh / tooling / SSH

Fallback path during migration:

    Kitty → tmux → zsh / tooling / SSH

### 8️⃣ Primera comprobación

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

### 9️⃣ Prueba del workspace

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

### 🔟 Perfil del login

Después de entrar en BSPWM, una shell interactiva mostrará Fastfetch con el logo oficial de Kali, la firma `⚡ xLFr4n` y los datos TARGET/IP/fecha. El snapshot ASCII `xlfr4n-banner --static` queda disponible para diagnóstico manual.

```bash
session-profile
```

El comando es read-only y muestra cuándo terminaron las distintas fases del bootstrap.

### 1️⃣1️⃣ Si el login parece lento

El proyecto ya escalona wallpaper, dock, monitor-refresh y Picom para no competir en el mismo instante.

Registra:

```bash
sed -n '1,220p' ~/.cache/xlfr4n-session.log
systemd-analyze --user blame 2>/dev/null | head -30 || true
journalctl --user -b --no-pager | tail -200
```

No reinstales varias veces a ciegas.

### 1️⃣2️⃣ Rollback

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

Use a compatible Kali guest with an available X11 session. The startup wallpaper defaults to `/usr/share/backgrounds/kali/kali-hack-16x9.jpg`.

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

Full system/package update:

```bash
cd ~/Downloads/kali-bspwm-2026
git pull --ff-only
chmod +x install.sh uninstall.sh
./install.sh
reboot
```

Fast workspace-only update:

```bash
cd ~/Downloads/kali-bspwm-2026
git pull --ff-only
./install.sh --deploy
bspc wm -r
```

**`git pull` updates the checkout; `./install.sh` deploys the updated configuration. `--deploy` skips APT for fast configuration iteration.**

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

### 7️⃣ Terminal stack

The terminal layer prefers Ghostty with tmux and keeps Kitty as a rollback path while the VM is being validated.

    xlfr4n-terminal --backend
    tmux -V

### 8️⃣ First health check

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

### 9️⃣ Workspace smoke test

At minimum, test launcher, Spotlight, Mission Control, workspaces, focus/swap/resize, fullscreen, wallpaper, theme switch, monitor refresh and doctor.

### 🔟 Slow-login diagnostics

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
