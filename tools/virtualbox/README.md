# ⚡ xLFr4n // VirtualBox Lab Tools

Run from the Windows host:

```powershell
.\xlfr4n-lab-vbox.ps1 -Audit
.\xlfr4n-lab-vbox.ps1 -Plan -NetworkName XLFR4N-LAB -VMNames Kali,DC01,WS01,WEB01
.\xlfr4n-lab-vbox.ps1 -Apply -NetworkName XLFR4N-LAB -VMNames Kali,DC01,WS01,WEB01
```

`-Audit` and `-Plan` are read-only. `-Apply` requires powered-off VMs and explicit confirmation.
