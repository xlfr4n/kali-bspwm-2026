# ⚡ xLFr4n // Project Roadmap

> 🇪🇸 Estado real del proyecto · 🇬🇧 Actual implementation and validation state

## 🇪🇸 Español

| Fase | Área | Estado | Validación restante |
|---|---|---|---|
| 1 | Desktop / UX / VM base | ✅ | prueba manual final ya realizada en la VM actual |
| 2 | Red Team Core | ✅ | ejercicios controlados |
| 3 | Engagement / Scope / Targets | ✅ | validación integrada en smoke |
| 4 | Evidence / Findings / Reporting | ✅ | ejercicio end-to-end real |
| 5 | QA / CI / reproducibilidad | 🟡 | cerrar la ejecución actual de CI y consolidar el bloque |
| 6 | Active Directory Lab | 🟡 | levantar DC01 + WS01, snapshots y pruebas reales |
| 7 | Web Lab | 🟡 | desplegar WEB01 y validar desde Kali en red aislada |
| 8 | Final QA / rollback / entrega | 🟡 | ejecutar L6-L7 y documentar resultados reales |

### Regla de estado

✅ significa que la infraestructura está implementada y cubierta por automatización o validación ya realizada.
🟡 significa que existe una implementación o receta utilizable, pero falta la validación práctica dependiente de VMs/snapshots.

### Camino

```text
CI
 ↓
L3 VirtualBox
 ↓
L4 AD
 ↓
L5 Web
 ↓
L6 engagement real
 ↓
L7 reset / rollback
 ↓
release candidate
```

## 🇬🇧 English

| Phase | Area | State | Remaining validation |
|---|---|---|---|
| 1 | Desktop / UX / VM base | ✅ | manual smoke already performed on the current VM |
| 2 | Red Team Core | ✅ | controlled exercises |
| 3 | Engagement / Scope / Targets | ✅ | covered by integrated smoke tests |
| 4 | Evidence / Findings / Reporting | ✅ | real end-to-end exercise |
| 5 | QA / CI / reproducibility | 🟡 | finish current CI validation and consolidate |
| 6 | Active Directory Lab | 🟡 | build DC01 + WS01, snapshots and real tests |
| 7 | Web Lab | 🟡 | deploy WEB01 and validate from Kali on isolated network |
| 8 | Final QA / rollback / delivery | 🟡 | execute L6-L7 and document real results |

✅ means the infrastructure is implemented and covered by automation or validation already performed.
🟡 means a usable implementation or recipe exists, but real VM/snapshot validation is still required.

**⚡ xLFr4n · implementation first, evidence second, validation before closure.**
