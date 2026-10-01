# ⚡ xLFr4n // Web Lab

## 🇪🇸 Español

Objetivo web local para ejercicios controlados. Todos los datos son sintéticos y el servicio está pensado para ejecutarse dentro de la red aislada del laboratorio. El contenedor exige `LAB_MODE=isolated-lab` para arrancar, reduciendo el riesgo de ejecución accidental.

```bash
cd tools/web-lab
docker compose up -d --build
docker compose ps
./reset.sh
```

Endpoint de salud:

```text
http://WEB01:8080/healthz
```

Superficies de entrenamiento:

| Ruta | Propósito |
|---|---|
| `/search?q=` | reflexión de entrada en HTML |
| `/api/users/{id}` | acceso a objetos sin autorización |
| `/api/admin/users` | recurso administrativo sin autenticación |
| `/api/config` | enumeración de configuración de laboratorio |

`reset.sh` reconstruye el contenedor y devuelve el servicio a su estado inicial. No contiene credenciales reales ni datos de terceros.

## 🇬🇧 English

This is a self-contained local training target using synthetic data. Run it only on the isolated lab network. The container requires `LAB_MODE=isolated-lab` before it will start.

```bash
cd tools/web-lab
docker compose up -d --build
docker compose ps
./reset.sh
```

Health endpoint: `http://WEB01:8080/healthz`.

The intentionally weak endpoints are documented so the environment remains a controlled training target rather than an accidental vulnerable service.

**⚡ xLFr4n · synthetic data, isolated network, repeatable reset.**
