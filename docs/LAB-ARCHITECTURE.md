# ⚡ xLFr4n // Red Team Lab Architecture

## 🇪🇸 Español

El laboratorio añade una capa de operaciones encima del escritorio existente.

~~~text
Desktop
  ↓
Engagement
  ↓
Targets + Scope
  ↓
Operations
  ↓
Evidence
  ↓
Findings
  ↓
Reporting
~~~

La configuración visual continúa en config/. El contexto operativo vive en ~/Lab/ y una referencia pequeña en ~/.config/xlfr4n/lab/current apunta al engagement activo.

Cada engagement contiene diez áreas numeradas para mantener una nomenclatura estable entre VMs.

La comprobación de scope trata el registro como una puerta explícita para las operaciones registradas por el controlador.

## 🇬🇧 English

The lab is an additive operations layer above the existing desktop.

Desktop configuration remains in config/. Engagement state lives in ~/Lab/ and the active context pointer is kept in the xLFr4n configuration area.

Numbered directories make the workflow consistent across engagements, VMs and future reporting integrations.

## 🔐 Engagement controls

### 🇪🇸 Español

La arquitectura separa tres controles antes de una operación registrada: engagement abierto, autorización confirmada y target incluido en scope. La topología del laboratorio se documenta por engagement y las fases AD/Web viven como objetivos separados.

### 🇬🇧 English

The operational layer uses three gates before a registered command can run: the engagement is open, authorization is confirmed and the selected target is in scope. Lab topology is stored per engagement, while AD and Web are treated as separate lab targets.
