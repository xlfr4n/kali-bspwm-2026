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

Crear baseline:
    
```powershell
.\tools\virtualbox\xlfr4n-lab-snapshot.ps1 -VMName WEB01 -SnapshotName WEB01-clean -Create -Plan
.\tools\virtualbox\xlfr4n-lab-snapshot.ps1 -VMName WEB01 -SnapshotName WEB01-clean -Create -Apply -LogPath .\engagement-reset.log
```

La creación exige que la VM esté apagada, comprueba que el nombre no exista y requiere la confirmación literal `CREATE`.

Restauración:
    
El helper comprueba que el snapshot exista, exige que la VM esté apagada y pide la confirmación literal `RESET`. Puede escribir un log del reset con `-LogPath` para adjuntarlo como evidencia. La evidencia debe conservarse antes de restaurar y el reset debe anotarse en el engagement.

## 🇬🇧 English

Create and document a clean baseline snapshot for each lab VM.

Create a baseline with `-Create -Plan` first, then `-Create -Apply`. Creation requires a powered-off VM, rejects duplicate snapshot names and requires the literal `CREATE` confirmation.

List snapshots with `-List`, preview restore with `-Plan`, and restore with `-Apply` after powering the VM off. Restore requires the explicit `RESET` confirmation.

The helper validates that the snapshot exists, requires the VM to be powered off and requires the literal `RESET` confirmation. Use `-LogPath` to preserve a timestamped reset event alongside the engagement evidence.
