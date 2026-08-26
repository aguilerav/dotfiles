# 📖 INSTRUCTIONS: Instalación por Sistema Operativo

Guía paso a paso para instalar y configurar este repositorio en cada plataforma.
Si solo buscas un resumen de qué contiene el repo, ve a [README.md](README.md).
Para los atajos de teclado, ve a [CHEAT_SHEET.md](CHEAT_SHEET.md).

---

## 📦 Matriz de paquetes por SO

| Paquete | macOS | Ubuntu/Debian | Termux (Android) | Windows (WSL2) |
| :--- | :---: | :---: | :---: | :---: |
| **zsh** (shell) | ✅ | ✅ | ✅ | ✅ |
| **tmux** (multiplexer, fallback) | ✅ | ✅ | ✅ | ✅ |
| **herdr** (multiplexer principal) | ✅ | ✅ | ❌ | ✅ |
| **wezterm** (terminal) | ✅ | ✅ | ❌ | ✅ (nativo) |
| **nvim** (editor) | ✅ | ✅ | ✅ | ✅ |
| **starship** (prompt) | ✅ | ✅ | ✅ | ✅ |
| **yazi** (explorador de archivos) | ✅ | ✅ | ✅ | ✅ |
| **opencode** (asistente de código) | ✅ | ✅ | ❌ | ✅ |

> **herdr** es el multiplexor principal. **tmux** se mantiene como *fallback*:
> dentro de Neovim, si no hay herdr activo la navegación cae a tmux y luego a splits planos.

---

## 🧠 Conceptos comunes

- **GNU Stow**: cada carpeta de nivel superior del repo es un *paquete* que
  replica la estructura de `$HOME`. Ejemplo: `nvim/.config/nvim/` →
  `~/.config/nvim/`.
- **El repo debe vivir en `~/dotfiles`**: el `.zshrc` sourcea plugins desde
  `~/dotfiles/zsh/plugins/...` y `install.sh` hace `cd ~/dotfiles`. Moverlo rompe zsh.
- **Folding vs `--no-folding`**: la mayoría de paquetes se stowean como un
  symlink de directorio (fold). **`herdr` y `opencode` se stowean con
  `--no-folding`** porque escriben estado en tiempo de ejecución dentro de su
  carpeta de config (sockets, logs, `plugins.json`, `node_modules`); sin esto,
  ese estado se escribiría dentro del repo git.
- **`~/.zshrc.local`**: config local por máquina que nunca se commitea.

---

## 🍎 macOS

### 1. Prerequisitos

- **Homebrew**: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- **Xcode Command Line Tools**: `xcode-select --install`

### 2. Instalar

```bash
git clone https://github.com/aguilerav/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

El script instala: `git stow neovim tmux ripgrep jq starship yazi herdr`
(formulae) y `wezterm font-meslo-lg-nerd-font` (casks), stowea los 8 paquetes,
registra el plugin de herdr y cambia la shell a zsh.

### 3. Verificar

```bash
zsh -n ~/.zshrc        # sin errores de sintaxis
which zsh tmux herdr wezterm nvim starship yazi opencode
ls -la ~/.config       # nvim/wezterm/yazi = symlink; herdr/opencode = directorio
```

> **Nota sobre `chsh`**: si algún día usas el zsh de Homebrew en vez del de
> sistema, deberás añadirlo a `/etc/shells` (`sudo sh -c 'command -v zsh >> /etc/shells'`).

---

## 🐧 Ubuntu / Debian

### 1. Prerequisitos

```bash
sudo apt update && sudo apt install -y git curl gpg
```

### 2. Instalar

```bash
git clone https://github.com/aguilerav/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

El script añade los repositorios APT oficiales de **WezTerm** (`apt.fury.io/wez`)
y **Yazi** (`yazi-rs.github.io/builds`), instala dependencias con `apt`,
instala herdr/starship/opencode con sus instaladores oficiales y stowea los
8 paquetes.

### 3. Verificar

```bash
zsh -n ~/.zshrc
which zsh tmux herdr wezterm nvim starship yazi opencode
fc-list | grep -i "MesloLGS"   # fuente instalada
```

---

## 🤖 Termux (LineageOS / Android)

> ⚠️ **NO uses `install.sh`**: este script detecta Termux y aborta a propósito.
> Sigue estos pasos manuales. `herdr`, `wezterm` y `opencode` no aplican en Termux.

### 1. Instalar dependencias

```bash
pkg update && pkg upgrade -y
pkg install -y git stow zsh tmux neovim ripgrep curl unzip starship yazi
```

> **yazi** funciona en Termux instalándolo con `pkg` y luego haciendo `stow yazi`.

### 2. Clonar y stowear

```bash
git clone https://github.com/aguilerav/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow zsh tmux nvim starship yazi
```

### 3. Cambiar la shell a zsh

```bash
chsh -s zsh
```

### 4. Instalar la fuente Nerd Font

Descarga un solo TTF (regular) de la familia **MesloLGS Nerd Font Mono** desde
el release de [nerd-fonts](https://github.com/ryanoasis/nerd-fonts/releases)
(archivo `Meslo.zip` → `MesloLGSNerdFontMono-Regular.ttf`) y colócalo como fuente de Termux:

```bash
mkdir -p ~/.termux
cp MesloLGSNerdFontMono-Regular.ttf ~/.termux/font.ttf
termux-reload-settings
```

### 5. Notas / límites

- **Clipboard de nvim**: el portapapeles del sistema requiere `pkg install termux-api`
  y la app **Termux:API**. Sin ella, `unnamedplus` es *best-effort*.
- **Lazygit popup de tmux**: `display-popup` puede no estar disponible; es opcional.

---

## 🪟 Windows (WSL2)

> Windows se soporta vía **WSL2** (distro Ubuntu). WezTerm se instala nativo
> en Windows y se conecta a WSL. Dentro de WSL se aplican los pasos de Ubuntu.

### 1. Activar WSL2 (PowerShell como administrador)

```powershell
wsl --install
```

Reinicia la máquina si se pide y crea tu usuario de Ubuntu cuando arranque.

### 2. Instalar WezTerm (nativo en Windows)

```powershell
winget install wez.wezterm
```

### 3. Instalar la fuente MesloLGS en Windows

Descarga `Meslo.zip` del release de [nerd-fonts](https://github.com/ryanoasis/nerd-fonts/releases),
descomprime e instala la variante **MesloLGS Nerd Font Mono** (clic derecho → Instalar).

### 4. Configurar WezTerm con la config del repo

Desde Windows, copia la config (ajusta la distro si no es `Ubuntu`):

```powershell
mkdir %USERPROFILE%\.config\wezterm
copy \\wsl$\Ubuntu\home\<TU_USUARIO>\dotfiles\wezterm\.config\wezterm\wezterm.lua %USERPROFILE%\.config\wezterm\wezterm.lua
```

Opcional: para que WezTerm abra WSL por defecto, añade al final de
`%USERPROFILE%\.config\wezterm\wezterm.lua`:

```lua
config.default_domain = 'WSL:Ubuntu'
```

### 5. Instalar los dotfiles DENTRO de WSL

Abre WezTerm y ejecuta (dentro de la distro Ubuntu de WSL):

```bash
git clone https://github.com/aguilerav/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

> WezTerm detecta la distro WSL automáticamente en su Launch Menu. La config
> clonada en WSL también la puedes usar si lanzas `wezterm` dentro de WSL.

---

## 🔧 Stow manual por paquete

| Paquete | Comando | Qué incluye |
| :--- | :--- | :--- |
| zsh | `stow zsh` | `.zshrc` + `plugins/` (autosuggestions, syntax-highlighting, autocomplete) |
| tmux | `stow tmux` | `.tmux.conf` (fallback) |
| nvim | `stow nvim` | `.config/nvim/` (Lua, lazy.nvim) |
| starship | `stow starship` | `.config/starship.toml` |
| wezterm | `stow wezterm` | `.config/wezterm/wezterm.lua` |
| yazi | `stow yazi` | `.config/yazi/` (keymap, theme, config) |
| herdr | `stow --no-folding herdr` | `.config/herdr/` (config, plugins, scripts) |
| opencode | `stow --no-folding opencode` | `.config/opencode/` (json + agents) |

Después de stowear herdr, registra el plugin de navegación:

```bash
herdr plugin link ~/.config/herdr/plugins/vim-herdr-navigation
```

---

## 🗑️ Desinstalar / Rollback

```bash
cd ~/dotfiles
stow -D zsh tmux nvim starship wezterm yazi      # desenlaza (sin --no-folding)
stow -D herdr opencode                            # para los dos runtime usar:
# stow -D --no-folding herdr opencode
```

Los `.bak` generados por `install.sh` restauran configs previas
(`~/.zshrc.bak`, `~/.config/nvim.bak`, etc.).

---

## 🩺 Troubleshooting

- **La navegación `Ctrl+h/j/k/l` no cruza paneles en herdr**: ejecuta
  `herdr plugin link ~/.config/herdr/plugins/vim-herdr-navigation` y reinicia herdr.
- **`chsh` falla en macOS**: confirma que el zsh elegido está en `/etc/shells`.
- **Termux**: recuerda que no hay `sudo`; usa `pkg` y los pasos de su sección.
- **WezTerm no ve la fuente**: reinstala la fuente y reinicia WezTerm
  (`Shift+Cmd+P` → Reload Configuration en macOS, `Ctrl+Shift+R` en otros).
