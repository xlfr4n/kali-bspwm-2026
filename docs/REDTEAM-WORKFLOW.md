# ⚡ xLFr4n // Red-Team Workspace

## 🇪🇸 Español

Organización del terminal para trabajo autorizado de **red team / pentesting** en laboratorios, CTFs o sistemas donde exista permiso explícito.

```text
Kali Linux
   ↓
X11 + BSPWM
   ↓
Ghostty
   ↓
tmux
   ├─ main
   ├─ recon
   ├─ web
   ├─ notes
   └─ loot
```

Ghostty proporciona la superficie gráfica. tmux mantiene sesiones y panes persistentes.

El backend se comprueba con:

```bash
xlfr4n-terminal --backend
```

Ghostty es el único terminal gráfico; tmux aporta persistencia, panes y el flujo de consola del laboratorio.

El laboratorio se abre con:

```bash
lab
```

o con **Super + Shift + L**.

La sesión organiza:

```text
main   → shell principal / coordinación
recon  → reconocimiento
web    → contexto web
notes  → notas
loot   → resultados y artefactos
```

No se ejecutan automáticamente Nmap, Metasploit, C2, Burp ni otras herramientas ofensivas. El proyecto prepara únicamente el espacio de trabajo.

### 🔐 SSH y persistencia

Ghostty mantiene activas sus funciones de integración relacionadas con SSH/terminfo.

```bash
tmux ls
tmux attach -t kali-lab
```

Separarse sin cerrar:

```text
Ctrl+A → D
```

### 🧪 Validación

```bash
xlfr4n-terminal --backend
tmux -V
doctor.sh
session-profile
```

## 🇬🇧 English

This document defines the terminal layout for authorized red-team / pentesting work.

Ghostty is the graphical terminal while tmux owns persistence and pane/session organization. The `lab` helper creates `main`, `recon`, `web`, `notes`, and `loot` areas.

No offensive tooling is executed automatically; the workspace only prepares an organized terminal environment.

Validation:

```bash
xlfr4n-terminal --backend
tmux -V
doctor.sh
session-profile
```

 
## 🧭 Operational workflow

### 🇪🇸 Español

La preparación del engagement sigue un orden fijo:

~~~text
AUTORIZACIÓN
    ↓
SCOPE
    ↓
TARGETS
    ↓
CONTEXT
    ↓
OPERACIÓN
    ↓
EVIDENCIA
    ↓
FINDINGS
    ↓
REPORT
~~~

Antes de una operación activa, registra el alcance con lab scope. Usa nombres estables para los targets y conserva la evidencia original.

La UI de Polybar muestra el engagement activo; la fuente de verdad permanece en engagement.json dentro del workspace.

### 🇬🇧 English

Use the same fixed lifecycle for every engagement:

authorization → scope → targets → context → operation → evidence → findings → report.

Keep the source of truth inside the engagement workspace and use the desktop only as a presentation/control surface.

See the supporting architecture, evidence and reporting documents for the detailed lifecycle.
