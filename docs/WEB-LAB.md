# ⚡ xLFr4n // Web Lab

## 🇪🇸 Español

El laboratorio web debe separar los objetivos por niveles:

~~~text
Tier 1 → HTTP service
Tier 2 → authenticated application
Tier 3 → API
Tier 4 → vulnerable training target
Tier 5 → resettable multi-service application
~~~

Cada objetivo debe tener:

- nombre estable;
- URL interna;
- logs disponibles;
- datos de prueba;
- procedimiento de reset;
- snapshot o backup;
- una página de estado;
- documentación de credenciales de laboratorio.

El navegador y las herramientas web de Kali deben apuntar a los nombres internos del laboratorio, no a servicios públicos por defecto.

El engagement puede almacenar capturas, respuestas sanitizadas, request/response de prueba y findings en sus directorios de evidencia.

## 🇬🇧 English

The web lab uses resettable internal targets with deterministic URLs, test data and logs.

Separate simple HTTP services, authenticated applications, APIs and intentionally vulnerable training applications into clear tiers.

Keep the targets internal to the lab network and make reset procedures part of the test plan. Preserve sanitized evidence in the engagement workspace.
