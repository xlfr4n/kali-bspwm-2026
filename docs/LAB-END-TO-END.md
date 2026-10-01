# ⚡ xLFr4n // Lab End-to-End Acceptance

> 🇪🇸 Guía de aceptación final · 🇬🇧 Final acceptance guide

## 🇪🇸 Español

Esta guía ejecuta una única pasada controlada sobre el laboratorio. No sustituye la autorización ni debe utilizarse contra sistemas externos.

### 0 · Preflight de repositorio

En Kali:

```bash
cd ~/kali-bspwm-2026
git pull --ff-only origin main
bash tests/static.sh
bash tests/shellcheck.sh
bash tests/lab-smoke.sh
```

Gate: los tres comandos deben terminar correctamente.

### 1 · L2 — Desktop / VM

```bash
doctor.sh
session-profile
```

Comprobación visual manual:

```text
BSPWM 1→9
fecha/hora
APPS / TARGET
dock
Fastfetch
notificaciones de lanzamiento
ventanas frameless
Ghostty + tmux
```

Registrar el resultado como nota del engagement.

### 2 · L3 — VirtualBox / red aislada

En el host Windows, no dentro de Kali:

```powershell
.\tools\virtualbox\xlfr4n-lab-vbox.ps1 -Audit -VMNames Kali,DC01,WS01,WEB01
.\tools\virtualbox\xlfr4n-lab-vbox.ps1 -Plan -NetworkName XLFR4N-LAB -VMNames Kali,DC01,WS01,WEB01
```

Revisar manualmente el plan. Todas las VMs deben estar apagadas antes de aplicar:

```powershell
.\tools\virtualbox\xlfr4n-lab-vbox.ps1 -Apply -NetworkName XLFR4N-LAB -VMNames Kali,DC01,WS01,WEB01
```

Gate: ejecutar `-Audit` de nuevo y conservar la salida.

### 3 · L3/L7 — Baselines

Crear un snapshot baseline por VM, siempre con la VM apagada:

```powershell
.\tools\virtualbox\xlfr4n-lab-snapshot.ps1 -VMName Kali -SnapshotName Kali-ready -Create -Plan
.\tools\virtualbox\xlfr4n-lab-snapshot.ps1 -VMName DC01 -SnapshotName DC01-domain-ready -Create -Plan
.\tools\virtualbox\xlfr4n-lab-snapshot.ps1 -VMName WS01 -SnapshotName WS01-joined -Create -Plan
.\tools\virtualbox\xlfr4n-lab-snapshot.ps1 -VMName WEB01 -SnapshotName WEB01-clean -Create -Plan
```

Tras revisar:

```powershell
.\tools\virtualbox\xlfr4n-lab-snapshot.ps1 -VMName Kali -SnapshotName Kali-ready -Create -Apply -LogPath .\lab-snapshot.log
```

Repetir para las otras VMs.

### 4 · L4 — Active Directory

En DC01:

```powershell
.\tools\ad-lab\Provision-DC.ps1 -DomainName xlfr4n.test
```

Reiniciar cuando corresponda y volver a ejecutar el aprovisionador para completar el baseline.

En WS01:

```powershell
.\tools\ad-lab\Join-Client.ps1 -DomainName xlfr4n.test
```

En DC01:

```powershell
.\tools\ad-lab\Test-ADLab.ps1 -DomainName xlfr4n.test
```

Gate: dominio, DNS, descubrimiento del DC y OUs base deben pasar.

### 5 · L5 — Web Lab

En WEB01, publicar deliberadamente el servicio en la red de laboratorio:

```bash
cd tools/web-lab
WEB_LAB_BIND=0.0.0.0 ./reset.sh
```

Desde WEB01:

```bash
./test.sh http://127.0.0.1:8080
```

Desde Kali, sustituir `WEB01_IP` por la IP real registrada en el engagement:

```bash
./tools/web-lab/test.sh http://WEB01_IP:8080
```

Gate: health, landing, config sintética, dataset sintético y superficie de búsqueda.

### 6 · L6 — Engagement end-to-end

En Kali:

```bash
lab init XLFR4N-LAB-ACCEPTANCE
lab scope allow 10.77.0.0/24
lab scope deny 10.77.0.1
lab target add WEB01_IP web01
lab target add 10.77.0.10 dc01
lab target add 10.77.0.20 ws01
lab target use web01
lab status
lab validate
```

Sustituir los valores solo por las direcciones reales de las VMs y mantener el scope limitado a `XLFR4N-LAB`.

Registrar una comprobación controlada:

```bash
lab exec --target web01 -- curl -fsS http://WEB01_IP:8080/healthz
```

Conservar la salida como command log. Añadir evidencia:

```bash
lab evidence add ./ruta/a/evidencia.txt web-health
lab evidence manifest
```

Crear y revisar el finding:

```bash
lab finding new "Web Lab acceptance observation" info
lab finding summary
lab validate
lab report
lab validate
```

Gate: el report debe contener scope, targets, finding summary, findings, evidence y timeline.

### 7 · L7 — Reset / rollback

Antes del restore:

```bash
lab evidence manifest
lab note "Evidence preserved before snapshot rollback."
```

En el host Windows, con la VM apagada:

```powershell
.\tools\virtualbox\xlfr4n-lab-snapshot.ps1 -VMName WEB01 -SnapshotName WEB01-clean -Plan
.\tools\virtualbox\xlfr4n-lab-snapshot.ps1 -VMName WEB01 -SnapshotName WEB01-clean -Apply -LogPath .\lab-reset.log
```

Repetir para cada VM que deba volver a baseline.

Finalmente repetir el smoke mínimo de Kali y registrar el resultado.

### Criterio de cierre

```text
L0 ✅ GitHub CI
L1 ✅ engagement smoke
L2 ☐ VM visual real
L3 ☐ VirtualBox real
L4 ☐ AD real
L5 ☐ WEB01 real
L6 ☐ engagement end-to-end real
L7 ☐ restore real + re-check
```

No se marca L2–L7 como cerrada hasta conservar evidencia de la prueba real correspondiente.

## 🇬🇧 English

This guide defines the final controlled acceptance pass. It does not replace authorization and must remain inside the dedicated lab.

### Acceptance sequence

```text
Repository CI
  ↓
Desktop / VM smoke
  ↓
VirtualBox isolation
  ↓
Baseline snapshots
  ↓
AD DS + WS01 join
  ↓
WEB01 synthetic target
  ↓
Engagement + evidence + finding + report
  ↓
Snapshot rollback + re-check
```

Use the same commands described in the Spanish section, preserving only lab-owned targets and replacing placeholder IPs with the actual isolated VM addresses.

**⚡ xLFr4n · isolate → provision → validate → exercise → evidence → reset.**
