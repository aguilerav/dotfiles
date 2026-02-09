# 🚀 Dotfiles: The Indestructible Setup

Configuración profesional, minimalista y portable para desarrollo.
Incluye **Neovim** (Lua puro), **Tmux**, **Zsh** y **Starship**, gestionado con **GNU Stow**.

## 📦 Stack Tecnológico

| Herramienta | Función | Configuración |
| :--- | :--- | :--- |
| **Zsh** | Shell | Rápida y moderna |
| **Starship** | Prompt | Minimalista, escrito en Rust |
| **Tmux** | Multiplexer | Navegación estilo Vim, sin plugins pesados |
| **Neovim** | Editor | Lua puro, LSP nativo, Treesitter, Lazy.nvim |
| **Stow** | Gestor | Symlinks automáticos |

---

## ⚡ Instalación Rápida (Recomendada)

En una máquina nueva (Ubuntu/Debian/WSL), clona el repositorio y ejecuta el script de instalación. Este script se encargará de:
1. Instalar dependencias (`neovim`, `tmux`, `zsh`, `ripgrep`, etc).
2. Descargar e instalar **JetBrains Mono Nerd Font**.
3. Instalar **Starship**.
4. Enlazar todos los dotfiles usando **Stow**.

```bash
# 1. Clonar
git clone [https://github.com/TU_USUARIO/dotfiles.git](https://github.com/TU_USUARIO/dotfiles.git) ~/dotfiles

# 2. Ejecutar script
cd ~/dotfiles
./install.sh
