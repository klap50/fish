# 🐟 fish-config by @klap50

🎨 Este repositorio contiene mi configuración personalizada de [Fish shell](https://fishshell.com/), lista para instalar con un solo comando.

Incluye:

- Prompt bonito con [Starship](https://starship.rs/)
- Alias y funciones útiles (`exa`, `bat`, `zoxide`, etc.)
- Completions inteligentes
- Fonts con íconos (Nerd Fonts)
- Automatización completa vía `setup-fish.sh`

---

## 🚀 Instalación rápida

> ✨ Ejecutá este comando en tu terminal (Pop!_OS, Ubuntu, Debian...):

```bash
curl -sL https://raw.githubusercontent.com/klap50/fish/main/setup-fish.sh | bash


📦 Requisitos
Este script está diseñado para:

Sistemas basados en Debian (Pop!_OS, Ubuntu, Linux Mint, etc.)

Acceso a sudo

Git y curl instalados (generalmente ya vienen)

🧠 ¿Cómo funciona?
El script hace lo siguiente:

Instala todos los paquetes necesarios

Clona este repo en ~/.fish-klap

Copia la configuración a ~/.config/fish/

Configura Starship y Nerd Fonts

Cambia tu shell por defecto a Fish

🧼 Resetear / desinstalar
Si querés volver al shell por defecto:

 - chsh -s /bin/bash
 
Y podés borrar la configuración con:

  - rm -rf ~/.config/fish ~/.local/share/fonts/*Hack*


🤝 Créditos
Inspirado por años de ajustes, errores y mejoras.
Hecho con amor por klap50
