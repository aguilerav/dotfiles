#!/usr/bin/env bash
# =============================================================================
# install.sh — Setup automático de dotfiles (SOLO macOS y Linux)
#
# Cubre: macOS (Homebrew) y Ubuntu/Debian (apt).
# Termux, Windows y otros sistemas: usa INSTRUCTIONS.md (manual).
# =============================================================================
set -euo pipefail

# --- 1. GUARDAS INICIALES ----------------------------------------------------
echo "🚀 Iniciando Setup de Dotfiles..."

# Termux (Android) no aplica: `uname -s` también devuelve "Linux"
if [ -n "${TERMUX_VERSION:-}" ] || uname -o 2>/dev/null | grep -qi android; then
  echo "❌ Este script NO soporta Termux/Android."
  echo "   Sigue las instrucciones manuales en: INSTRUCTIONS.md"
  exit 1
fi

OS="$(uname -s)"
case "$OS" in
  Darwin) echo "✅ Sistema detectado: macOS" ;;
  Linux)  echo "✅ Sistema detectado: Linux (Ubuntu/Debian)" ;;
  *)
    echo "❌ Sistema no soportado por install.sh: $OS"
    echo "   Revisa INSTRUCTIONS.md para instalación manual."
    exit 1
    ;;
esac

# --- 2. SANITY DEL REPO (restricción ~/dotfiles) -----------------------------
REPO_DIR="$HOME/dotfiles"
if [ ! -f "$REPO_DIR/zsh/.zshrc" ]; then
  echo "❌ El repositorio debe estar en $REPO_DIR"
  echo "   Clónalo con: git clone <repo> $REPO_DIR  y vuelve a ejecutar."
  exit 1
fi
cd "$REPO_DIR"

# --- 3. DEPENDENCIAS POR SISTEMA ---------------------------------------------
if [ "$OS" = "Darwin" ]; then
  if ! command -v brew >/dev/null 2>&1; then
    echo "❌ Homebrew no está instalado. Instálalo primero:"
    echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
  fi

  echo "📦 Instalando paquetes con Homebrew..."
  brew install git stow neovim tmux ripgrep jq starship yazi herdr
  brew install --cask wezterm font-meslo-lg-nerd-font
else
  echo "📦 Instalando paquetes con apt..."
  sudo apt update
  sudo apt install -y zsh tmux neovim git stow curl ripgrep unzip fontconfig jq file

  # Repositorio APT oficial de WezTerm
  if ! dpkg -s wezterm >/dev/null 2>&1; then
    echo "🌐 Añadiendo repo oficial de WezTerm..."
    curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
    echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list >/dev/null
    sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg
  fi

  # Repositorio APT oficial de Yazi
  if ! dpkg -s yazi >/dev/null 2>&1; then
    echo "🌐 Añadiendo repo oficial de Yazi..."
    curl -fsSL https://yazi-rs.github.io/builds/yazi-keyring.gpg | sudo tee /usr/share/keyrings/yazi-keyring.gpg >/dev/null
    echo 'deb [signed-by=/usr/share/keyrings/yazi-keyring.gpg] https://yazi-rs.github.io/builds/ stable main' | sudo tee /etc/apt/sources.list.d/yazi.list >/dev/null
  fi

  sudo apt update
  sudo apt install -y wezterm yazi
fi

# --- 4. STOW + HERRAMIENTAS DE TERCEROS (curl) --------------------------------
if ! command -v stow >/dev/null 2>&1; then
  echo "❌ stow no está disponible. Revísalo e inténtalo de nuevo."
  exit 1
fi

# Starship (instalador oficial; en macOS ya vino con brew)
if ! command -v starship >/dev/null 2>&1; then
  echo "⭐ Instalando Starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

# opencode (ambas plataformas)
if [ ! -x "$HOME/.opencode/bin/opencode" ]; then
  echo "🤖 Instalando opencode..."
  curl -fsSL https://opencode.ai/install | bash
fi

# herdr (solo Linux; en macOS ya vino con brew)
if ! command -v herdr >/dev/null 2>&1 && [ "$OS" = "Linux" ]; then
  echo "🐑 Instalando herdr..."
  curl -fsSL https://herdr.dev/install.sh | sh
fi

# --- 5. FUENTE NERD FONT (MesloLGS) ------------------------------------------
NERD_FONTS_VERSION="v3.4.0"
if [ "$OS" = "Linux" ]; then
  FONT_DIR="$HOME/.local/share/fonts"
  if ! fc-list | grep -qi "MesloLGS Nerd Font"; then
    echo "🔤 Instalando MesloLGS Nerd Font..."
    mkdir -p "$FONT_DIR"
    cd "$FONT_DIR"
    curl -fLo "Meslo.zip" "https://github.com/ryanoasis/nerd-fonts/releases/download/${NERD_FONTS_VERSION}/Meslo.zip"
    unzip -o Meslo.zip
    rm Meslo.zip
    fc-cache -fv >/dev/null
    cd "$REPO_DIR"
  fi
fi

# --- 6. BACKUPS (solo destinos de folding existentes y NO symlinks) -----------
echo "🔗 Preparando directorios para Stow..."
[ -f ~/.zshrc ] && [ ! -L ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak
[ -f ~/.tmux.conf ] && [ ! -L ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.bak
[ -e ~/.config/nvim ] && [ ! -L ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak
[ -e ~/.config/starship.toml ] && [ ! -L ~/.config/starship.toml ] && mv ~/.config/starship.toml ~/.config/starship.toml.bak
[ -e ~/.config/wezterm ] && [ ! -L ~/.config/wezterm ] && mv ~/.config/wezterm ~/.config/wezterm.bak
[ -e ~/.config/yazi ] && [ ! -L ~/.config/yazi ] && mv ~/.config/yazi ~/.config/yazi.bak
# herdr y opencode NO se tocan: escriben estado runtime en su carpeta

# --- 7. STOW ----------------------------------------------------------------
# Paquetes con estado runtime se stowean SIN plegar para que sus archivos
# de sesión (socks, logs, plugins.json, node_modules) vivan en ~/.config
# y NO dentro del repo git.
stow zsh tmux nvim starship wezterm yazi
stow --no-folding herdr opencode

# --- 8. REGISTRO DEL PLUGIN DE HERDR (navegación Ctrl+hjkl) ------------------
if command -v herdr >/dev/null 2>&1 && \
   ! herdr plugin list 2>/dev/null | grep -q "vim-herdr-navigation"; then
  echo "🐑 Registrando plugin de navegación vim-herdr-navigation..."
  herdr plugin link "$HOME/.config/herdr/plugins/vim-herdr-navigation"
fi

# --- 9. CAMBIAR SHELL A ZSH --------------------------------------------------
if [ "$SHELL" != "$(command -v zsh)" ]; then
  echo "🐚 Cambiando shell por defecto a Zsh..."
  chsh -s "$(command -v zsh)"
  echo "⚠️  Cierra sesión y vuelve a entrar para ver el cambio de Shell."
fi

# --- 10. CIERRE ---------------------------------------------------------------
echo "🎉 ¡Setup completado! Reinicia tu terminal."
echo ""
echo "Siguientes pasos:"
echo "  - Atajos de teclado → CHEAT_SHEET.md"
echo "  - Instalación manual en Termux/Windows → INSTRUCTIONS.md"
