#!/bin/bash

set -e

echo "🛠️ Instalando dependencias básicas..."
sudo apt update
sudo apt install -y fish exa bat fd-find fzf git curl unzip zoxide fonts-powerline

echo "🌟 Instalando Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

echo "🔤 Instalando fuente Nerd (Hack)..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip -O Hack.zip
unzip -o Hack.zip
rm Hack.zip
fc-cache -fv

echo "🔄 Volviendo a tu carpeta de inicio..."
cd ~

# ✅ Clonar el repositorio si no está ya presente
REPO_DIR="$HOME/.fish-klap"
if [ ! -d "$REPO_DIR" ]; then
    echo "📦 Clonando repositorio de klap50/fish..."
    git clone https://github.com/klap50/fish.git "$REPO_DIR"
fi

echo "📁 Instalando configuración de Fish..."

# Asegurar estructura
mkdir -p ~/.config/fish

# Copiar archivos
cp -r "$REPO_DIR/conf.d" ~/.config/fish/ 2>/dev/null || true
cp -r "$REPO_DIR/functions" ~/.config/fish/ 2>/dev/null || true
cp -r "$REPO_DIR/completions" ~/.config/fish/ 2>/dev/null || true
cp "$REPO_DIR/config.fish" ~/.config/fish/config.fish
cp "$REPO_DIR/fish_variables" ~/.config/fish/fish_variables

# Agregar Starship si no está ya
if ! grep -q "starship init fish" ~/.config/fish/config.fish; then
    echo 'starship init fish | source' >> ~/.config/fish/config.fish
    echo "🧠 Starship agregado al final de config.fish"
fi

# Establecer Fish como shell por defecto
echo "🔁 Estableciendo Fish como tu shell por defecto..."
chsh -s /usr/bin/fish

echo "✅ Instalación completa."
echo "🖥️ Abrí una nueva terminal y seleccioná la fuente: Hack Nerd Font."
echo "🌈 ¡Disfrutá tu entorno Fish con estilo, klap! 😎"
