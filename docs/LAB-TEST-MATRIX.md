# ⚡ xLFr4n // Lab Test Matrix

## 🇪🇸 Español

| Nivel | Se valida | Método | Gate |
|---|---|---|---|
| L0 | Sintaxis, ShellCheck, estructura | GitHub Actions | automático |
| L1 | Scope, target, evidence, findings, report | smoke aislado | automático |
| L2 | BSPWM, Ghostty, tmux, Polybar, dock | VM actual | manual |
| L3 | Internal Network, IPs, snapshots | VirtualBox host + guest | manual |
| L4 | Dominio AD, DNS, join, baseline | DC01/WS01 | manual + scripts |
| L5 | Web target, health, logs, reset | WEB01 | manual + smoke |
| L6 | Operación → evidencia → finding → informe | engagement | end-to-end |
| L7 | Reset, rollback y nueva instalación | snapshots | final |

### Orden

```text
CI verde
  ↓
doctor VM
  ↓
L3 network + snapshots
  ↓
L4 AD
  ↓
L5 Web
  ↓
L6 engagement
  ↓
L7 reset / rollback
```

Una fase no se considera cerrada solo porque exista el script; debe existir su resultado de validación.

## 🇬🇧 English

The matrix separates automated checks from the manual validation that depends on the real hypervisor and lab VMs.

**⚡ xLFr4n · one gate at a time.**
