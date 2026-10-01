# ⚡ xLFr4n // VirtualBox Lab Topology

## 🇪🇸 Español

Topología base antes de AD/Web:

```text
Windows 11 host
   │
   ├── NAT / administración
   │
   └── XLFR4N-LAB (Internal Network)
          ├── Kali
          ├── DC01
          ├── WS01
          └── WEB01
```

Ejemplo de direccionamiento privado:

```text
10.77.0.0/24
DC01   10.77.0.10
WS01   10.77.0.20
WEB01  10.77.0.30
Kali   10.77.0.40
```

Usa estas direcciones solo si no se solapan con otras redes activas. El segmento de práctica debe permanecer aislado; no se configura Bridged por defecto.

### Snapshots

```text
Kali-ready
DC01-domain-ready
WS01-joined
WEB01-clean
```

Cada ejercicio parte de un baseline conocido y debe poder volver a él.

## 🇬🇧 English

Use a dedicated VirtualBox Internal Network for the training segment. Keep ordinary update/management connectivity separate from the practice network.

Example private addressing:

```text
10.77.0.0/24
DC01   10.77.0.10
WS01   10.77.0.20
WEB01  10.77.0.30
Kali   10.77.0.40
```

Create baseline snapshots for every VM before exercises and document the reset procedure.
