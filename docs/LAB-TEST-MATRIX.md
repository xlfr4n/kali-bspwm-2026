# ⚡ xLFr4n // Lab Test Matrix

> 🇪🇸 Matriz de validación por fase · 🇬🇧 Phase-based validation matrix

## 🇪🇸 Español

El proyecto separa las pruebas automáticas, las pruebas funcionales del guest y la validación de laboratorio. No se pide una prueba manual por cada commit; se agrupan por hitos.

| Nivel | Se valida | Método | Cuándo |
|---|---|---|---|
| L0 | Sintaxis, estructura y guardas | CI | Cada cambio |
| L1 | Engagement, scope, target, evidencia, findings y reporte | `tests/lab-smoke.sh` | Cada cambio del Lab |
| L2 | Desktop, Ghostty, tmux, Polybar, dock y doctor | VM real | Al cerrar la capa desktop |
| L3 | Red aislada, snapshots y conectividad entre VMs | VirtualBox | Antes de AD/Web |
| L4 | AD lab y procedimientos de reset | Múltiples VMs | Cuando la topología esté creada |
| L5 | Web lab, logs, datos de prueba y reset | Múltiples VMs/containers | Cuando el objetivo esté listo |
| L6 | Evidence → finding → report completo | Engagement de laboratorio | Después de ejercicios |
| L7 | Reinstalación/rollback y documentación | VM + snapshot limpio | Antes de considerar el proyecto cerrado |

### Orden recomendado

```text
CI verde
   ↓
doctor.sh = 0 FAIL
   ↓
lab doctor = 0 FAIL
   ↓
lab smoke = PASS
   ↓
Desktop VM smoke
   ↓
VirtualBox isolated network
   ↓
AD lab
   ↓
Web lab
   ↓
Evidence + Findings + Report
   ↓
Reset / rollback test
```

### Regla de avance

Una fase puede avanzar cuando su automatización está verde y su prueba manual solo cubre lo que la automatización no puede observar. Las pruebas destructivas o activas deben ejecutarse únicamente contra objetivos de laboratorio o con autorización explícita.

## 🇬🇧 English

The project separates automated validation, guest functional testing and lab validation. Manual testing is grouped by milestones instead of being repeated after every commit.

| Level | Validates | Method | When |
|---|---|---|---|
| L0 | Syntax, structure and guardrails | CI | Every change |
| L1 | Engagement, scope, targets, evidence, findings and report | `tests/lab-smoke.sh` | Every Lab change |
| L2 | Desktop, Ghostty, tmux, Polybar, dock and doctor | Real VM | When desktop layer is stable |
| L3 | Isolated network, snapshots and VM connectivity | VirtualBox | Before AD/Web |
| L4 | AD lab and reset procedures | Multiple VMs | When topology exists |
| L5 | Web lab, logs, test data and reset | Multiple VMs/containers | When target is ready |
| L6 | Evidence → finding → report end-to-end | Lab engagement | After exercises |
| L7 | Reinstall/rollback and documentation | VM + clean snapshot | Before closure |

### Progression rule

Advance a phase when its automation is green and the manual test only covers what automation cannot observe. Active or potentially disruptive testing belongs only on lab targets or explicitly authorized systems.

**⚡ xLFr4n · test by milestone, not by noise.**
