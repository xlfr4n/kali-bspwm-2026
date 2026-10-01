# ⚡ xLFr4n // Snapshot Reset Runbook

## 🇪🇸 Español

Antes de un ejercicio, crea y documenta un snapshot baseline por VM.

Listar snapshots:

```powershell
.\tools\virtualbox\xlfr4n-lab-snapshot.ps1 -VMName WEB01 -List
```

Plan de restauración:

```powershell
.\tools\virtualbox\xlfr4n-lab-snapshot.ps1 -VMName WEB01 -SnapshotName WEB01-clean -Plan
```

Restauración explícita:

```powershell
.\tools\virtualbox\xlfr4n-lab-snapshot.ps1 -VMName WEB01 -SnapshotName WEB01-clean -Apply
```

El helper exige que la VM esté apagada y la confirmación literal `RESET`. La evidencia debe conservarse antes de restaurar y el reset debe anotarse en el engagement.

## 🇬🇧 English

Create and document a clean baseline snapshot for each lab VM.

List snapshots with `-List`, preview restore with `-Plan`, and restore with `-Apply` after powering the VM off. Restore requires the explicit `RESET` confirmation.

Preserve evidence before restoring and record the reset event in the engagement.
