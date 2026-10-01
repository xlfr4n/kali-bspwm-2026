# ⚡ xLFr4n // Red Team Tool Profiles

## 🇪🇸 Español

El escritorio base se mantiene ligero. Los perfiles se habilitan explícitamente mediante metapaquetes oficiales de Kali:

| Perfil | Metapaquete |
|---|---|
| core | kali-tools-top10 |
| recon | kali-tools-information-gathering |
| web | kali-tools-web |
| credentials | kali-tools-passwords |
| ad | kali-tools-windows-resources |
| exploitation | kali-tools-exploitation |
| post | kali-tools-post-exploitation |
| reporting | kali-tools-reporting |

Uso:
~~~bash
lab tools list
lab tools install core
lab tools status
~~~

El modo full instala todos los perfiles anteriores. Activar un perfil es aditivo y no elimina configuraciones existentes.

## 🇬🇧 English

The base desktop remains intentionally small. Capability profiles are enabled explicitly through Kali maintained metapackages.

The profile mapping keeps package selection transparent and avoids turning every desktop installation into Kali Everything.

Profiles are additive and do not remove existing user configuration.
