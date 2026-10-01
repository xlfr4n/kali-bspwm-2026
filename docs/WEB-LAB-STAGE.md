# ⚡ xLFr4n // Web Lab Stage

## 🇪🇸 Español

L5 usa un objetivo autocontenido con datos sintéticos:

```bash
cd tools/web-lab
./reset.sh
./test.sh http://127.0.0.1:8080
```

En una VM WEB01, registra la IP del objetivo en el engagement y ejecuta el mismo smoke desde Kali cuando la red aislada esté validada.

Por defecto el puerto se publica en `127.0.0.1:8080`, el contenedor no se reinicia automáticamente, no obtiene capacidades Linux y usa un filesystem de solo lectura. Para exponerlo deliberadamente dentro de `XLFR4N-LAB`, configura el bind explícito antes del reset:

```bash
WEB_LAB_BIND=0.0.0.0 ./reset.sh
```

El contenedor exige `LAB_MODE=isolated-lab`, se ejecuta como usuario sin privilegios y no necesita datos externos.

## 🇬🇧 English

L5 uses a self-contained synthetic target:

```bash
cd tools/web-lab
./reset.sh
./test.sh http://127.0.0.1:8080
```

After the isolated network is validated, run the same smoke from Kali against WEB01.

The default bind is `127.0.0.1:8080`, automatic restart is disabled, Linux capabilities are dropped and the filesystem is read-only. To publish the target deliberately on the isolated lab segment:

```bash
WEB_LAB_BIND=0.0.0.0 ./reset.sh
```

Reset by rebuilding the container.
