# ⚡ xLFr4n // VirtualBox Lab Tools

Run from the Windows host:

```powershell
.\xlfr4n-lab-vbox.ps1 -Audit
.\xlfr4n-lab-vbox.ps1 -Plan -NetworkName XLFR4N-LAB -VMNames Kali,DC01,WS01,WEB01
.\xlfr4n-lab-vbox.ps1 -Apply -NetworkName XLFR4N-LAB -VMNames Kali,DC01,WS01,WEB01
.\xlfr4n-lab-snapshot.ps1 -VMName WEB01 -SnapshotName WEB01-clean -Create -Plan
.\xlfr4n-lab-snapshot.ps1 -VMName WEB01 -SnapshotName WEB01-clean -Create -Apply
.\xlfr4n-lab-snapshot.ps1 -VMName WEB01 -List
```

`-Audit` and `-Plan` are read-only. `-Apply` requires powered-off VMs and explicit confirmation.


Snapshot creation requires a powered-off VM and the literal \`CREATE\` confirmation. Restore requires the literal \`RESET\` confirmation.