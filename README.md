# 🚀 Dotfiles: The Indestructible Setup

Configuración profesional, minimalista y portable para desarrollo, gestionada con **GNU Stow**.

Soporta **macOS**, **Ubuntu/Debian**, **Termux (Android/LineageOS)** y **Windows (WSL2)**.

- **Instalación paso a paso** → [INSTRUCTIONS.md](INSTRUCTIONS.md)
- **Atajos de teclado** → [CHEAT_SHEET.md](CHEAT_SHEET.md)
- **Instalación automática** (macOS + Linux) → `./install.sh`

---

## 📦 Stack Tecnológico

| Herramienta | Función | Plataformas |
| :--- | :--- | :--- |
| **Zsh** | Shell | macOS, Linux, Termux, WSL2 |
| **Starship** | Prompt (Rust) | Todas |
| **Herdr** | Multiplexer principal | macOS, Linux, WSL2 |
| **Tmux** | Multiplexer *fallback* | macOS, Linux, Termux, WSL2 |
| **WezTerm** | Terminal emulator | macOS, Linux, Windows (nativo) |
| **Neovim** | Editor (Lua, lazy.nvim, LSP) | Todas |
| **Yazi** | Explorador de archivos (TUI) | Todas |
| **OpenCode** | Asistente de código (TUI) | macOS, Linux, WSL2 |
| **Stow** | Gestión de symlinks | Todas |

> **Herdr** es el multiplexor principal: la navegación `Ctrl+h/j/k/l` cruza
> paneles herdr ↔ splits de Neovim de forma transparente. **Tmux** queda como
> *fallback* cuando herdr no está activo.

---

## 📂 Estructura del Repositorio

Cada carpeta de nivel superior es un paquete de Stow que replica `$HOME`:

```
dotfiles/
├── zsh/          →  ~/.zshrc  +  plugins/ (autosuggestions, highlight, autocomplete)
├── tmux/         →  ~/.tmux.conf                     (fallback)
├── herdr/        →  ~/.config/herdr/                 (multiplexer principal)
├── wezterm/      →  ~/.config/wezterm/wezterm.lua
├── nvim/         →  ~/.config/nvim/                  (Lua + lazy.nvim)
├── starship/     →  ~/.config/starship.toml
├── yazi/         →  ~/.config/yazi/
├── opencode/     →  ~/.config/opencode/
├── README.md     →  esta guía
├── INSTRUCTIONS.md →  instalación por SO
└── CHEAT_SHEET.md →  atajos de teclado
```

---

## ⚡ Instalación Rápida (macOS y Linux)

```bash
# 1. Clonar (el repo DEBE vivir en ~/dotfiles)
git clone https://github.com/aguilerav/dotfiles.git ~/dotfiles

# 2. Ejecutar script
cd ~/dotfiles
./install.sh
```

El script detecta el sistema (`brew` en macOS, `apt` en Ubuntu/Debian),
instala dependencias y fuentes, stowea los 8 paquetes, registra el plugin de
herdr y cambia la shell a zsh.

**Termux y Windows**: la instalación es manual → [INSTRUCTIONS.md](INSTRUCTIONS.md).

---

## 🔗 Cómo funciona GNU Stow

Stow crea symlinks desde `$HOME` hacia el repo. Cada paquete (carpeta) replica
la estructura de tu home:

```bash
cd ~/dotfiles
stow nvim          # ~/.config/nvim  →  dotfiles/nvim/.config/nvim
stow zsh           # ~/.zshrc        →  dotfiles/zsh/.zshrc
```

**Detalle importante**: `herdr` y `opencode` escriben estado en tiempo de
ejecución dentro de su carpeta de config (sockets, logs, `node_modules`).
Por eso se stowean con `--no-folding` para que ese estado viva en `~/.config`
y no dentro del repo git:

```bash
stow --no-folding herdr opencode
```

Los cambios son inmediatos en el sistema: editas el repo y el symlink lo
refleja al instante (`source ~/.zshrc`, reinicia la app).

---

## 🐚 Configuración local por máquina

`~/.zshrc.local` es sourceado por `.zshrc` para overrides locales
(secrets, alias de trabajo, PATHs). **Nunca se commitea** — es tuyo y de tu máquina.
