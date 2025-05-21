#!/bin/bash

set -e

echo "📦 Instalando dependencias básicas..."
sudo apt update
sudo apt install -y fish exa bat fd-find fzf git curl unzip zoxide fonts-powerline

echo "🌟 Instalando Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

echo "🔤 Instalando fuente Nerd (Hack)..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip -O Hack.zip
unzip -o Hack.zip >/dev/null
rm Hack.zip
fc-cache -fv || echo "⚠️ Problema al refrescar caché de fuentes"

echo "🔄 Volviendo a tu carpeta de inicio..."
cd ~

# Clonar el repo si no está
REPO_DIR="$HOME/.fish-klap"
if [ ! -d "$REPO_DIR" ]; then
    echo "📥 Clonando config desde GitHub..."
    git clone https://github.com/klap50/fish.git "$REPO_DIR"
fi

echo "📁 Instalando configuración de Fish..."
mkdir -p ~/.config/fish
cp -r "$REPO_DIR/conf.d" "$REPO_DIR/functions" "$REPO_DIR/completions" ~/.config/fish/ 2>/dev/null || true
cp "$REPO_DIR/config.fish" "$REPO_DIR/fish_variables" ~/.config/fish/

echo "🎣 Configurando Starship en Fish..."
if ! grep -q "starship init fish" ~/.config/fish/config.fish; then
    echo 'starship init fish | source' >> ~/.config/fish/config.fish
    echo "🧠 Starship agregado al final de config.fish"
else
    echo "✅ Starship ya estaba presente en config.fish"
fi

echo "🔁 Verificando si Fish ya es tu shell por defecto..."
FISH_PATH=$(which fish)
if [ "$SHELL" != "$FISH_PATH" ]; then
    echo "🔁 Intentando establecer Fish como shell por defecto..."
    if command -v chsh &> /dev/null; then
        chsh -s "$FISH_PATH" || echo "⚠️ No se pudo cambiar el shell automáticamente. Hacelo manualmente con: chsh -s $FISH_PATH"
    else
        echo "⚠️ El comando 'chsh' no está disponible. Cambiá el shell manualmente con: chsh -s $FISH_PATH"
    fi
else
    echo "✅ Fish ya es tu shell por defecto."
fi

echo "✅ Instalación completa."
echo "🖥️ Si usás terminal gráfica, seleccioná la fuente: Hack Nerd Font"
echo "🌈 ¡Listo! Disfrutá tu entorno Fish con estilo, klap 😎"
