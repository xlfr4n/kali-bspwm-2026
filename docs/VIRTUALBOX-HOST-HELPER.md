# ⚡ xLFr4n // VirtualBox Host Lab Helper

> 🇪🇸 Auditoría y preparación controlada del host VirtualBox · 🇬🇧 Controlled VirtualBox host audit and preparation

Este helper se ejecuta en el host Windows, no dentro de Kali. Por defecto solo inspecciona y genera un plan. No cambia adaptadores, VMs ni redes salvo que se use explícitamente un modo de aplicación.

## 🇪🇸 Uso

Requisitos:
- VirtualBox instalado.
- `VBoxManage.exe` accesible.
- VMs de laboratorio identificadas con nombres estables.

Auditoría:

```powershell
.\xlfr4n-lab-vbox.ps1 -Audit
```

Plan:

```powershell
.\xlfr4n-lab-vbox.ps1 -Plan -NetworkName XLFR4N-LAB
```

El modo `-Plan` no aplica cambios. Antes de `-Apply`, revisa la salida y confirma que los nombres de las VMs y el adaptador elegido corresponden al laboratorio.

### Política

```text
HOST
  ├─ internet/NAT → administración y actualizaciones
  └─ XLFR4N-LAB   → red de práctica aislada
                     ├─ Kali
                     ├─ DC01
                     ├─ WS01
                     └─ WEB01
```

El helper no configura Bridged de forma automática y no añade reglas de port-forwarding para objetivos de práctica.

## 🇬🇧 English

Run this helper on the Windows VirtualBox host, not inside Kali. Audit and plan modes are read-only. Changes require an explicit `-Apply` invocation after reviewing the plan.

```powershell
.\xlfr4n-lab-vbox.ps1 -Audit
.\xlfr4n-lab-vbox.ps1 -Plan -NetworkName XLFR4N-LAB
```

Use stable VM names and keep the practice segment separate from ordinary LAN connectivity. The helper does not automatically enable Bridged networking or add port forwarding for training targets.

**⚡ xLFr4n · inspect first, apply deliberately.**
