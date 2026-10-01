# ⚡ xLFr4n // Web Lab Stage

## 🇪🇸 Español

L5 usa un objetivo autocontenido con datos sintéticos:

```bash
cd tools/web-lab
./reset.sh
./test.sh http://127.0.0.1:8080
```

En una VM WEB01, registra la IP del objetivo en el engagement y ejecuta el mismo smoke desde Kali cuando la red aislada esté validada.

El contenedor exige `LAB_MODE=isolated-lab`, se ejecuta como usuario sin privilegios y no necesita datos externos.

## 🇬🇧 English

L5 uses a self-contained synthetic target:

```bash
cd tools/web-lab
./reset.sh
./test.sh http://127.0.0.1:8080
```

After the isolated network is validated, run the same smoke from Kali against WEB01. Reset by rebuilding the container.
