# ⚡ xLFr4n // Web Lab

## 🇪🇸 Español

Objetivo web autocontenido para entrenamiento autorizado. Usa únicamente datos sintéticos y exige `LAB_MODE=isolated-lab` para arrancar.

```bash
cd tools/web-lab
chmod +x reset.sh test.sh
./reset.sh
./test.sh http://127.0.0.1:8080
```

Superficies intencionadamente débiles del laboratorio:

| Ruta | Superficie |
|---|---|
| `/search?q=` | reflexión de entrada |
| `/api/users/{id}` | control de acceso ausente |
| `/api/admin/users` | recurso administrativo sin autenticación |
| `/api/config` | enumeración de configuración |

El objetivo debe estar detrás de la red aislada de laboratorio cuando se publique desde una VM.

## 🇬🇧 English

Self-contained authorized training target with synthetic data. It requires `LAB_MODE=isolated-lab` and is intended for the isolated lab network.

```bash
cd tools/web-lab
chmod +x reset.sh test.sh
./reset.sh
./test.sh http://127.0.0.1:8080
```

Reset by rebuilding the container. No third-party data or credentials are used.
