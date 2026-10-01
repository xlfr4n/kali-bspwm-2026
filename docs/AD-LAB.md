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
