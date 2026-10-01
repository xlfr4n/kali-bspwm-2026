# ⚡ xLFr4n // Red Team Lab Roadmap

> 🇪🇸 Estado de implementación y validación · 🇬🇧 Implementation and validation state

## 🇪🇸 Español

| Fase | Área | Estado actual | Validación pendiente |
|---|---|---|---|
| L0 | CI / guardas | ✅ | cierre de esta rama |
| L1 | Engagement core | ✅ | ejercicios controlados |
| L2 | Desktop/VM | ✅ | nueva prueba completa solo al cerrar el bloque |
| L3 | VirtualBox aislado | 🟡 | auditoría real del host, red y snapshots |
| L4 | Active Directory | 🟡 | DC01 + WS01 reales y reset |
| L5 | Web Lab | 🟡 | WEB01 real + smoke desde Kali |
| L6 | Evidence/Findings/Report | 🟡 | ejercicio end-to-end real |
| L7 | Rollback / release | 🟡 | reinstalación, snapshot y documentación final |

### Regla

Una implementación no se marca como validada hasta existir una prueba reproducible. Las VMs y snapshots reales quedan separadas de la automatización de GitHub.

## 🇬🇧 English

| Phase | Area | Current state | Remaining validation |
|---|---|---|---|
| L0 | CI / guardrails | ✅ | close this branch |
| L1 | Engagement core | ✅ | controlled exercises |
| L2 | Desktop/VM | ✅ | full retest only after this block closes |
| L3 | Isolated VirtualBox | 🟡 | real host, network and snapshot audit |
| L4 | Active Directory | 🟡 | real DC01 + WS01 and reset |
| L5 | Web Lab | 🟡 | real WEB01 + smoke from Kali |
| L6 | Evidence/Findings/Report | 🟡 | real end-to-end exercise |
| L7 | Rollback / release | 🟡 | reinstall, snapshot and final documentation |

An implementation becomes validated only when it has a reproducible test. Real VMs and snapshots remain separate from GitHub automation.

**⚡ xLFr4n · build → test → evidence → reset.**
