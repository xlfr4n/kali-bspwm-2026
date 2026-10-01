# ⚡ xLFr4n // Red Team Lab Stages

## 🇪🇸 Español

Este documento une las piezas del laboratorio sin modificar automáticamente el host ni las VMs.

### L3 — Red aislada

1. Audita VirtualBox con `-Audit`.
2. Genera el plan con `-Plan`.
3. Apaga las VMs.
4. Aplica `-Apply` solo tras revisar el plan y confirmar `APPLY`.
5. Arranca primero Kali y valida la interfaz.

### L4 — Active Directory

1. Crea snapshot `DC01-domain-ready` antes de ejercicios.
2. Ejecuta `Provision-DC.ps1` en DC01.
3. Reinicia y vuelve a ejecutar para completar OUs/cuentas.
4. Une WS01 con `Join-Client.ps1`.
5. Ejecuta `Test-ADLab.ps1`.

### L5 — Web

1. Crea snapshot `WEB01-clean`.
2. Conecta WEB01 únicamente a `XLFR4N-LAB`.
3. Ejecuta `tools/web-lab/reset.sh`.
4. Comprueba `healthz` y `test.sh` desde WEB01/Kali.

### L6 — Engagement

Usa el `lab` actual para registrar scope y targets. Las piezas de L3-L5 no sustituyen el control de autorización del engagement; ambos deben quedar documentados.

### L7 — Reset

Cada ejercicio debe poder volver a un snapshot baseline. La evidencia se conserva antes del reset y el resultado del reset queda anotado en el engagement.

## 🇬🇧 English

This guide connects the lab pieces without automatically changing the host or training VMs.

### L3 — Isolation
Audit, plan, power off, review, explicitly apply, then boot Kali and validate the interface.

### L4 — Active Directory
Provision DC01, reboot, complete the baseline, join WS01, validate DNS/domain discovery, then create clean snapshots.

### L5 — Web
Create WEB01-clean, keep WEB01 on XLFR4N-LAB, run the reset helper and validate health from Kali.

### L6/L7
Use the existing engagement controller for scope/targets and preserve evidence before resetting to a baseline snapshot.

**⚡ xLFr4n · isolate → provision → validate → exercise → evidence → reset.**
