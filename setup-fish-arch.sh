#!/bin/bash

set -e

echo "📦 Instalando dependencias básicas para Arch/Garuda..."
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm fish exa bat fd fzf git curl unzip zoxide

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
echo "🧹 Limpiando funciones anteriores personalizadas..."
rm -rf ~/.config/fish/conf.d ~/.config/fish/functions ~/.config/fish/completions

cp -r "$REPO_DIR/conf.d" ~/.config/fish/
cp -r "$REPO_DIR/functions" ~/.config/fish/
cp -r "$REPO_DIR/completions" ~/.config/fish/
cp "$REPO_DIR/config.fish" ~/.config/fish/
cp "$REPO_DIR/fish_variables" ~/.config/fish/

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
    echo "⏳ Vas a cambiar tu shell por defecto a Fish ($FISH_PATH)"
    echo "🔐 Si se requiere contraseña, ingresala cuando se solicite."
    for i in {10..1}; do
        echo -ne "⌛ Comenzando en $i segundos...\r"
        sleep 1
    done
    echo

    if command -v chsh &> /dev/null; then
        chsh -s "$FISH_PATH" || echo "⚠️ No se pudo cambiar el shell automáticamente. Podés hacerlo manualmente con: chsh -s $FISH_PATH"
    else
        echo "⚠️ El comando 'chsh' no está disponible. Cambiá el shell manualmente con: chsh -s $FISH_PATH"
    fi
else
    echo "✅ Fish ya es tu shell por defecto."
fi

echo "✅ Instalación completa."
echo "🖥️ Si usás terminal gráfica, seleccioná la fuente: Hack Nerd Font"
echo "🌈 ¡Listo! Disfrutá tu entorno Fish con estilo, klap 😎"
