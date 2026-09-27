# 🧪 Tests

> ⚡ **xLFr4n verification layer · ES + EN**

## 🇪🇸 Español

Los tests comprueban sintaxis Bash, guardas estáticas y superficies de configuración que pueden validarse sin iniciar una sesión gráfica real.

Ejecuta:

```bash
bash tests/static.sh
bash tests/shellcheck.sh
```

La validación CI debe adaptarse al entorno del runner; los componentes gráficos se comprueban con una pantalla virtual cuando sea necesario.

## 🇬🇧 English

These tests validate Bash syntax, static guards and configuration surfaces that can be checked without starting a real graphical session.

Run:

```bash
bash tests/static.sh
bash tests/shellcheck.sh
```

CI validation should account for the runner environment; graphical components are checked with a virtual display when required.

**⚡ xLFr4n · Test the boundary, not the illusion**
