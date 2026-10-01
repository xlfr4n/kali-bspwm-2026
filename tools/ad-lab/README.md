# ⚡ xLFr4n // AD Lab Tools

## 🇪🇸 Español

Los scripts de esta carpeta solo deben ejecutarse en las VMs AD del laboratorio.

`Provision-DC.ps1` prepara AD DS/DNS, el dominio sintético `xlfr4n.test`, OUs y cuentas de práctica.

`Join-Client.ps1` incorpora el cliente al dominio usando credenciales introducidas de forma interactiva.

`Test-ADLab.ps1` valida dominio, DNS, descubrimiento del DC y OUs base.

No se almacenan contraseñas ni secretos en Git.

## 🇬🇧 English

These scripts are intended only for the dedicated AD lab VMs.

Provisioning uses the synthetic `xlfr4n.test` domain. Credentials are entered interactively and are not stored in Git.
