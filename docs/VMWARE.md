# ⚡ xlfr4n // VMware guest

> 🖥️ **Windows host. Kali guest. One reproducible desktop layer.**

## 🇪🇸 Español

Este proyecto está pensado para una Kali Linux X11 ejecutándose como guest de VMware.

### 🧩 Integración

Cuando `systemd-detect-virt` devuelve VMware, el instalador usa:

- `open-vm-tools`
- `open-vm-tools-desktop`

Además, el helper `vmware-tools` permite consultar el estado y reiniciar los servicios sin cambiar automáticamente la configuración de la máquina virtual.

### 🖥️ Pantallas

`monitor-refresh`:

1. descubre las salidas conectadas mediante `xrandr`;
2. conserva la salida marcada como primaria cuando existe;
3. coloca las adicionales a la derecha;
4. reparte los diez escritorios de BSPWM entre los monitores detectados.

Con una sola pantalla no se necesita ninguna configuración especial.

### 📁 Carpetas compartidas

La presencia de `/mnt/hgfs` se informa como diagnóstico. El montaje automático no forma parte del núcleo del proyecto: se mantiene deliberadamente separado de la instalación base.

### 🧪 Diagnóstico

```bash
systemd-detect-virt
vmware-tools status
systemctl is-active open-vm-tools
test -x /usr/bin/vmware-user
xrandr --query
```

## 🇬🇧 English

This project targets a Kali Linux X11 guest running under VMware.

### 🧩 Guest integration

When `systemd-detect-virt` reports VMware, the installer uses `open-vm-tools` plus the desktop integration supplied by `open-vm-tools-desktop`.

The `vmware-tools` helper can inspect status and restart the services without changing VM settings automatically.

### 🖥️ Displays

`monitor-refresh` discovers connected X11 outputs with `xrandr`, keeps the primary output when available, places additional outputs to the right and distributes the ten BSPWM desktops across detected monitors.

### 📁 Shared folders

`/mnt/hgfs` is reported for diagnostics. Automatic mounting is intentionally outside the core bootstrap.

### 🧪 Diagnostics

```bash
systemd-detect-virt
vmware-tools status
systemctl is-active open-vm-tools
systemctl is-active open-vm-tools-desktop
xrandr --query
```

## ⚡ xlfr4n

**Compatibility before cosmetics. Reversible changes before shortcuts.**

**Compatibilidad antes que cosmética. Cambios reversibles antes que atajos.**
