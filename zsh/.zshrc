# ==============================================
# 0. DETECCIÓN DE SISTEMA Y VARIABLES
# ==============================================
# Guardamos el nombre del OS (Darwin = Mac, Linux = Linux)
OS="$(uname -s)"

# Cargar Homebrew solo si existe (típico en Mac Apple Silicon)
if [ -f "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ==============================================
# 1. CONFIGURACIÓN BÁSICA
# ==============================================
# Historial
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# Colores
autoload -U colors && colors

# Autocompletado básico
autoload -Uz compinit
compinit

# ==============================================
# 2. PROMPT (STARSHIP)
# ==============================================
export STARSHIP_CONFIG=~/.config/starship.toml
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

# ==============================================
# 3. PLUGINS (Carga Manual)
# ==============================================
source ~/dotfiles/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source ~/dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# ==============================================
# 4. ALIASES (Tus atajos multiplataforma)
# ==============================================
# Diferenciar comandos 'ls' dependiendo del OS
if [ "$OS" = "Darwin" ]; then
    # macOS (BSD)
    alias ls='ls -G'
    alias ll='ls -lahG'
else
    # Linux (GNU)
    alias ls='ls --color=auto'
    alias ll='ls -lah --color=auto'
fi

alias grep='grep --color=auto'
alias v="nvim"
alias dot="cd ~/dotfiles"
alias reload="source ~/.zshrc"

# --- Alias de GIT ---
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -m'
alias gs='git status'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'

# ==============================================
# 5. HERRAMIENTAS EXTERNAS Y PATHS
# ==============================================

# Path para Neovim (Carga solo si la carpeta existe en tu Linux)
if [ -d "/opt/nvim-linux-x86_64/bin" ]; then
    export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
fi

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Opcional: Configuración rápida de vi-mode
bindkey -v

# ==============================================
# 6. STARTUP (Banner de bienvenida)
# ==============================================
# Muestra Fastfetch solo si está instalado
if command -v fastfetch >/dev/null 2>&1; then
    fastfetch
fi

export PATH="$HOME/.local/bin:$PATH"

if [ -f "$HOME/.zshrc.local" ]; then
    source "$HOME/.zshrc.local"
fi

# ==========================================
# AUTOMATIZACIÓN DE ENTORNO TMUX (WORKSPACE)
# ==========================================
workspace() {
    # Tomar el nombre de la carpeta actual para nombrar la sesión de tmux
    local session_name=$(basename "$PWD" | tr '.' '_')

    # Si ya existe una sesión con ese nombre, solo conéctate a ella
    if tmux has-session -t "$session_name" 2>/dev/null; then
        tmux attach-session -t "$session_name"
        return
    fi

    # 1. Crear nueva sesión apuntando a Neovim
    tmux new-session -d -s "$session_name" -n "Dev" "nvim ."

    # 2. Dividir la pantalla usando -l XX% (Compatible y robusto en Linux/Mac)
    tmux split-window -h -l 20% "opencode"

    # 3. Volver al panel izquierdo (donde está Neovim) para dividirlo abajo
    tmux select-pane -t 0
    tmux split-window -v -l 20%

    # 4. Dejar el foco inicial en el panel de Neovim (panel 0)
    tmux select-pane -t 0

    # Conectarse a la sesión recién creada
    tmux attach-session -t "$session_name"
}

# Crear un alias corto si te da pereza escribir 'workspace'
alias ws="workspace"

export PATH="$HOME/.opencode/bin:$PATH"
