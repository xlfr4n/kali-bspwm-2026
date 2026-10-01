# ⚡ xLFr4n // Evidence Workflow

## 🇪🇸 Español

La evidencia se conserva fuera del estado visual.

~~~bash
lab evidence add ./artifact.bin label
lab evidence list
lab evidence manifest
~~~

Los originales se copian a 08-evidence/raw/, se indexan con timestamp y SHA-256 y pueden formar un manifest reproducible.

Los registros de operaciones quedan separados en 08-evidence/commands/.

Reglas: conservar originales, no subir secretos, no sustituir evidencia primaria por derivados y mantener el contexto del target.

## 🇬🇧 English

Evidence is kept separate from desktop state, indexed with timestamps and SHA-256 hashes.

Source artifacts are preserved in 08-evidence/raw/ and command records in 08-evidence/commands/.

Do not upload secrets or replace primary evidence with derived material.
