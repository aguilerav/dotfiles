#!/bin/bash
set -e # Terminar si hay un error

echo "🚀 Iniciando Setup de Dotfiles..."

# 1. Instalar Dependencias (Debian/Ubuntu)
echo "📦 Instalando paquetes necesarios..."
sudo apt update
sudo apt install -y zsh tmux neovim git stow curl ripgrep unzip fontconfig build-essential

# 2. Instalar Starship (Prompt)
if ! command -v starship &> /dev/null; then
    echo "⭐ Instalando Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
else
    echo "✅ Starship ya está instalado"
fi

# 3. Instalar Nerd Font (JetBrains Mono)
FONT_DIR="$HOME/.local/share/fonts"
if [ ! -d "$FONT_DIR" ]; then
    echo "ABC Instalando Nerd Fonts (JetBrains Mono)..."
    mkdir -p "$FONT_DIR"
    cd "$FONT_DIR"
    curl -fLo "JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
    unzip -o JetBrainsMono.zip
    rm JetBrainsMono.zip
    fc-cache -fv
    cd -
    echo "✅ Fuentes instaladas. Configura tu terminal para usar 'JetBrainsMono Nerd Font'"
else
    echo "✅ Parece que ya tienes fuentes instaladas en $FONT_DIR"
fi

# 4. Preparar directorios para Stow
# (Hacemos backup si existen archivos por defecto para evitar conflictos)
echo "🔗 Enlazando configuraciones con Stow..."
cd ~/dotfiles

# Backup rápido de configs viejas si existen y no son symlinks
[ -f ~/.zshrc ] && [ ! -L ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak
[ -f ~/.tmux.conf ] && [ ! -L ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.bak
[ -d ~/.config/nvim ] && [ ! -L ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak
[ -f ~/.config/starship.toml ] && [ ! -L ~/.config/starship.toml ] && mv ~/.config/starship.toml ~/.config/starship.toml.bak

# Ejecutar Stow
# Asegúrate de que las carpetas coincidan con los nombres aquí
stow zsh
stow tmux
stow nvim
stow starship

# 5. Cambiar Shell a Zsh
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "🐚 Cambiando shell por defecto a Zsh..."
    chsh -s $(which zsh)
    echo "⚠️  Cierra sesión y vuelve a entrar para ver el cambio de Shell."
fi

echo "🎉 ¡Setup completado! Reinicia tu terminal."
