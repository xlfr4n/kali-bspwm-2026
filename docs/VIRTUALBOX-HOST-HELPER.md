# ⚡ xLFr4n // VirtualBox Host Lab Helper

## 🇪🇸 Español

Ejecutar en el host Windows, no dentro de Kali.

Auditoría read-only:

```powershell
.\tools\virtualbox\xlfr4n-lab-vbox.ps1 -Audit
```

Plan sin cambios:

```powershell
.\tools\virtualbox\xlfr4n-lab-vbox.ps1 -Plan -NetworkName XLFR4N-LAB -VMNames Kali,DC01,WS01,WEB01
```

Aplicación deliberada:

```powershell
.\tools\virtualbox\xlfr4n-lab-vbox.ps1 -Apply -NetworkName XLFR4N-LAB -VMNames Kali,DC01,WS01,WEB01
```

El modo Apply exige que todas las VMs estén apagadas y una confirmación manual `APPLY`. Solo modifica el adaptador seleccionado y usa Internal Network.

## 🇬🇧 English

Run this helper on the Windows VirtualBox host.

Audit and plan modes are read-only. Apply first preflights that every selected VM exists and is powered off, then requires the literal `APPLY` confirmation. After the mutation it verifies every selected adapter is actually attached to the requested Internal Network. Only the selected adapter is modified.
