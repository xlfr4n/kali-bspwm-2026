# ⚡ xLFr4n // Red Team Lab Roadmap

> 🇪🇸 Estado de implementación y validación · 🇬🇧 Implementation and validation state

## 🇪🇸 Español

| Fase | Área | Automatización / código | Gate pendiente |
|---|---|---|---|
| L0 | CI / guardas | ✅ Verde en GitHub Actions | Ninguno |
| L1 | Engagement core | ✅ Smoke de scope → target → evidence → finding → report | Ejercicio real controlado |
| L2 | Desktop / VM | ✅ Checks estáticos + doctor/session-profile | Smoke visual final en la VM |
| L3 | VirtualBox aislado | ✅ Helper audit/plan/apply endurecido | Host real + red + snapshots |
| L4 | Active Directory | ✅ Provision/join/validate implementados | DC01 + WS01 reales |
| L5 | Web Lab | ✅ Compose + health + smoke + aislamiento | WEB01 real + smoke desde Kali |
| L6 | Evidence / Findings / Report | ✅ Hashing + finding summary + informe ES/EN | Engagement end-to-end real |
| L7 | Rollback / release | ✅ Baseline create/restore + logs | Restore real + reinstalación final |

### Regla de cierre

Una fase no se marca como **cerrada** hasta que su gate de infraestructura correspondiente haya producido evidencia reproducible. GitHub Actions certifica el software; no sustituye la comprobación del host VirtualBox ni de las VMs reales.

### Orden de aceptación

```text
main + CI verde
  ↓
L2 · doctor + smoke visual
  ↓
L3 · Internal Network + baseline snapshots
  ↓
L4 · DC01 + WS01 + DNS/domain validation
  ↓
L5 · WEB01 + health/smoke
  ↓
L6 · engagement → evidence → finding → report
  ↓
L7 · evidence manifest → snapshot restore → clean re-check
```

## 🇬🇧 English

| Phase | Area | Automation / code | Remaining gate |
|---|---|---|---|
| L0 | CI / guardrails | ✅ Green in GitHub Actions | None |
| L1 | Engagement core | ✅ Scope → target → evidence → finding → report smoke | Real controlled exercise |
| L2 | Desktop / VM | ✅ Static checks + doctor/session-profile | Final VM visual smoke |
| L3 | Isolated VirtualBox | ✅ Hardened audit/plan/apply helper | Real host + network + snapshots |
| L4 | Active Directory | ✅ Provision/join/validate implemented | Real DC01 + WS01 |
| L5 | Web Lab | ✅ Compose + health + smoke + isolation | Real WEB01 + Kali smoke |
| L6 | Evidence / Findings / Report | ✅ Hashing + finding summary + ES/EN report | Real end-to-end engagement |
| L7 | Rollback / release | ✅ Baseline create/restore + logging | Real restore + final reinstall |

A phase is only **closed** after its corresponding infrastructure gate produces reproducible evidence. GitHub Actions certifies the software; it does not replace validation of the real VirtualBox host or lab VMs.

**⚡ xLFr4n · isolate → provision → validate → exercise → evidence → reset.**
