# ⚡ xLFr4n // VirtualBox Lab Topology

> 🇪🇸 Diseño de red y snapshots para el laboratorio aislado · 🇬🇧 Isolated lab network and snapshot design

## 🇪🇸 Español

Este documento define la base L3 antes de levantar los laboratorios AD y Web. El objetivo es que los objetivos de práctica sean resettable y estén separados de la LAN normal.

### Topología

```text
                    Windows 11 Host
                          │
                    VirtualBox NAT
                          │
                    (actualización)
                          │
                  ┌───────┴───────┐
                  │  Kali xLFr4n   │
                  │   Red Team    │
                  └───────┬───────┘
                          │
                  Internal Network
                    XLFR4N-LAB
                          │
          ┌───────────────┼────────────────┐
          │               │                │
        DC01            WS01             WEB01
       AD/DNS       Windows client      Web target
```

### Reglas

- La red de práctica debe ser `Internal Network` o un segmento `Host-only` dedicado.
- No usar Bridged como configuración por defecto para los objetivos de laboratorio.
- Separar la red de administración/actualizaciones de la red de práctica.
- Documentar el rango IP elegido antes de registrar targets.
- Reservar direcciones estables para DC01, WS01 y WEB01.
- Mantener snapshots limpios antes de ejercicios que puedan cambiar el estado de una VM.

### Rango de ejemplo

```text
Network: 10.77.0.0/24
Gateway: según el diseño del laboratorio
DC01:    10.77.0.10
WS01:    10.77.0.20
WEB01:   10.77.0.30
Kali:    10.77.0.40
```

Las direcciones son ejemplos privados; el operador debe comprobar que no exista solapamiento con otras redes activas del entorno.

### Snapshot policy

```text
BASELINE
  ├─ Kali-ready
  ├─ DC01-domain-ready
  ├─ WS01-joined
  └─ WEB01-clean

EXERCISE
  └─ cambios del ejercicio

RESET
  └─ volver al snapshot correspondiente
```

Antes de cada ejercicio registra el snapshot utilizado en `notes/timeline.log`. No uses snapshots como sustituto de copias de evidencia.

### Gate L3

Antes de pasar a AD/Web deben estar comprobados:

- las VMs están conectadas al segmento aislado correcto;
- Kali puede resolver y alcanzar únicamente los servicios previstos del laboratorio;
- las VMs objetivo no necesitan exposición directa a la LAN doméstica;
- existe un snapshot baseline por VM;
- el procedimiento de reset está documentado;
- los nombres/IP de laboratorio pueden registrarse en `lab target` sin ambigüedad.

## 🇬🇧 English

This document defines the network and snapshot baseline before the AD and Web labs are built. The objective is to keep training targets isolated and resettable.

### Rules

- Use a dedicated VirtualBox Internal Network or Host-only segment.
- Do not default to Bridged networking for training targets.
- Keep update/management connectivity separate from the practice segment.
- Record the lab IP range before registering targets.
- Keep stable addresses for the core lab systems.
- Create clean baseline snapshots before state-changing exercises.

### Example addressing

```text
10.77.0.0/24
DC01  10.77.0.10
WS01  10.77.0.20
WEB01 10.77.0.30
Kali  10.77.0.40
```

These are private example addresses. Check for overlap with active networks in the environment before using them.

### L3 gate

Do not advance into AD/Web until isolation, deterministic addressing, baseline snapshots, reset procedures and target registration are validated.

**⚡ xLFr4n · isolate first, exercise second, preserve evidence always.**
