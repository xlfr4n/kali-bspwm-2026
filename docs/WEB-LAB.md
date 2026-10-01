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

## 🧪 Local target / Objetivo local

### 🇪🇸 Español

El repositorio incluye un objetivo web autocontenido en `tools/web-lab/` para disponer de un servicio controlado y reiniciable antes de usar objetivos externos o más complejos:

```bash
cd tools/web-lab
chmod +x reset.sh
./reset.sh
docker compose ps
```

La aplicación usa datos sintéticos y se debe publicar solo en la red del laboratorio. El estado se resetea reconstruyendo el contenedor.

### 🇬🇧 English

The repository includes a self-contained resettable web target in `tools/web-lab/`:

```bash
cd tools/web-lab
chmod +x reset.sh
./reset.sh
docker compose ps
```

The application uses synthetic data and should be exposed only on the lab network. Reset is performed by rebuilding the container.

## 🧭 Runbook / Procedimiento

### 🇪🇸 Español

```text
1. Crear el snapshot WEB01-clean.
2. Conectar WEB01 exclusivamente a XLFR4N-LAB.
3. Instalar Docker Engine / Compose en WEB01.
4. Clonar o copiar tools/web-lab/ al objetivo de laboratorio.
5. Ejecutar ./reset.sh.
6. Ejecutar ./test.sh desde WEB01 o desde Kali contra la IP de WEB01.
7. Registrar WEB01 en el engagement y validar el scope.
8. Usar lab evidence add para guardar capturas o resultados sanitizados.
9. Ejecutar ejercicios dentro de la ventana autorizada del laboratorio.
10. Restaurar el snapshot WEB01-clean después del ejercicio.
```

Registro del objetivo:

```bash
lab scope allow 10.77.0.0/24
lab target add 10.77.0.30 web01
lab target use web01
lab topology validate --strict
lab doctor --strict
```

Smoke del servicio:

```bash
cd tools/web-lab
docker compose ps
bash test.sh http://10.77.0.30:8080
```

### 🇬🇧 English

```text
1. Create the WEB01-clean baseline snapshot.
2. Attach WEB01 only to XLFR4N-LAB.
3. Install Docker Engine / Compose on WEB01.
4. Copy tools/web-lab/ to the lab target.
5. Run ./reset.sh.
6. Run ./test.sh locally or from Kali against WEB01.
7. Register WEB01 and validate scope.
8. Preserve sanitized screenshots/results with lab evidence add.
9. Perform exercises during the authorized lab window.
10. Restore WEB01-clean after the exercise.
```

Target registration:

```bash
lab scope allow 10.77.0.0/24
lab target add 10.77.0.30 web01
lab target use web01
lab topology validate --strict
lab doctor --strict
```

Service smoke:

```bash
cd tools/web-lab
docker compose ps
bash test.sh http://10.77.0.30:8080
```