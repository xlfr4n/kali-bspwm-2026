# ⚡ xLFr4n // Active Directory Lab

## 🇪🇸 Español

Arquitectura recomendada para una red aislada:

~~~text
                    xLFr4n Kali
                         |
                    LAB-AD network
                         |
        +----------------+----------------+
        |                                 |
   Domain Controller                 Windows Client
        |                                 |
        +------------- Member Server ------+
~~~

Mantén esta red como Internal Network o Host-only en el hipervisor. No uses Bridged para el laboratorio por defecto.

Componentes:

- controlador de dominio;
- cliente Windows;
- servidor miembro opcional;
- DNS autoritativo del dominio;
- sincronización horaria;
- snapshots limpios;
- una cuenta de administración de laboratorio;
- una cuenta de usuario de prueba.

Objetivos de práctica:

- descubrimiento y enumeración;
- relaciones y permisos de Active Directory;
- autenticación y delegación;
- rutas de privilegio;
- servicios Windows;
- administración remota autorizada;
- recopilación y reporting.

La red del laboratorio debe tener direccionamiento propio y no reutilizar rangos activos de la LAN doméstica cuando pueda evitarse.

## 🇬🇧 English

Use an isolated Internal Network or Host-only segment for the AD lab.

Keep the domain controller, Windows client and optional member server inside that segment. DNS and time synchronization should be deterministic, and snapshots should provide clean reset points.

The lab is designed for controlled learning and authorized assessments, never for production or third-party infrastructure.

## 🧰 Automation / Automatización

### 🇪🇸 Español

Los helpers del repositorio preparan el dominio y permiten validar el baseline sin guardar contraseñas en Git:

```powershell
.\tools\ad-lab\Provision-DC.ps1
.\tools\ad-lab\Join-Client.ps1 -DomainName xlfr4n.test
.\tools\ad-lab\Test-ADLab.ps1 -DomainName xlfr4n.test
```

Las contraseñas se solicitan de forma interactiva. El aprovisionador crea OUs y cuentas sintéticas del laboratorio. El join requiere credenciales proporcionadas por el operador. Ejecuta estos scripts únicamente en las VMs AD del laboratorio.

### 🇬🇧 English

Repository helpers provision the lab domain and validate its baseline without storing passwords in Git:

```powershell
.\tools\ad-lab\Provision-DC.ps1
.\tools\ad-lab\Join-Client.ps1 -DomainName xlfr4n.test
.\tools\ad-lab\Test-ADLab.ps1 -DomainName xlfr4n.test
```

Passwords are requested interactively. The provisioner creates synthetic lab OUs and accounts. The join helper requires operator-supplied credentials. Run these scripts only on the AD lab VMs.

## 🧭 Runbook / Procedimiento

### 🇪🇸 Español

```text
1. Crear snapshots baseline de Kali, DC01 y WS01.
2. Conectar las VMs al segmento XLFR4N-LAB.
3. Configurar IP estable y DNS de laboratorio.
4. Ejecutar Provision-DC.ps1 en DC01.
5. Reiniciar DC01 y validar con Test-ADLab.ps1.
6. Ejecutar Join-Client.ps1 en WS01.
7. Reiniciar WS01 y validar resolución / pertenencia al dominio.
8. Registrar DC01 y WS01 como targets del engagement.
9. Crear un snapshot post-baseline.
10. Comenzar ejercicios solo después de lab doctor --strict y topology validate --strict.
```

Targets de ejemplo dentro del engagement:

```bash
lab scope allow 10.77.0.0/24
lab target add 10.77.0.10 dc01
lab target add 10.77.0.20 ws01
lab target use dc01
lab doctor --strict
```

### 🇬🇧 English

```text
1. Create clean baseline snapshots for Kali, DC01 and WS01.
2. Connect the VMs to XLFR4N-LAB.
3. Configure stable lab IP addressing and DNS.
4. Run Provision-DC.ps1 on DC01.
5. Reboot DC01 and validate with Test-ADLab.ps1.
6. Run Join-Client.ps1 on WS01.
7. Reboot WS01 and validate DNS / domain membership.
8. Register DC01 and WS01 as engagement targets.
9. Create a post-baseline snapshot.
10. Start exercises only after lab doctor --strict and topology validate --strict pass.
```

Example target registration:

```bash
lab scope allow 10.77.0.0/24
lab target add 10.77.0.10 dc01
lab target add 10.77.0.20 ws01
lab target use dc01
lab doctor --strict
```