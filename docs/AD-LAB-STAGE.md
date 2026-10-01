# ⚡ xLFr4n // AD Lab Stage

## 🇪🇸 Español

Orden operativo para L4:

```text
DC01 baseline
  ↓
AD DS + DNS
  ↓
lab domain
  ↓
WS01 join
  ↓
DNS/domain validation
  ↓
baseline snapshots
```

En DC01:

```powershell
.\tools\ad-lab\Provision-DC.ps1 -DomainName xlfr4n.test
.\tools\ad-lab\Test-ADLab.ps1 -DomainName xlfr4n.test
```

En WS01:

```powershell
.\tools\ad-lab\Join-Client.ps1 -DomainName xlfr4n.test
```

No se guardan contraseñas en el repositorio. El aprovisionamiento solicita secretos interactivos y los objetivos son exclusivamente del laboratorio.

## 🇬🇧 English

L4 sequence:

```text
DC01 baseline → AD DS/DNS → domain → WS01 join → validation → snapshots
```

Run the provisioning and validation scripts only on the dedicated lab VMs. Passwords are entered interactively and are never stored in the repository.
