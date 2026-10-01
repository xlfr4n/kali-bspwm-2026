# ⚡ xLFr4n // Reporting Pipeline

## 🇪🇸 Español

Ejecutar:
~~~bash
lab report
~~~

El pipeline genera Markdown, HTML y un fichero de hashes cuando sha256sum está disponible.

El reporte reúne el contexto del engagement, scope, targets, findings, evidencia y timeline registrado.

La automatización prepara la estructura; la revisión humana sigue siendo obligatoria antes de entregar el informe.

## 🇬🇧 English

Run lab report to generate a portable Markdown and HTML report from the local engagement state.

The report combines scope, targets, findings, evidence references and the recorded timeline.

Human review remains required before delivery.

## 🧾 Finding lifecycle / Ciclo de findings

### 🇪🇸 Español

Los findings incluyen severidad y estado (`open`, `confirmed`, `accepted`, `remediated`, `closed`). `lab finding summary` consolida las severidades y `lab finding set` mantiene el ciclo de vida sin editar manualmente la estructura del documento.

El reporte incluye el resumen de severidades, el estado de cada finding, evidencia referenciada y la línea de tiempo del engagement.

### 🇬🇧 English

Findings carry both severity and lifecycle status (`open`, `confirmed`, `accepted`, `remediated`, `closed`). `lab finding summary` aggregates severities and `lab finding set` updates lifecycle metadata consistently.

Reports include severity totals, finding state, evidence references and the engagement timeline.
