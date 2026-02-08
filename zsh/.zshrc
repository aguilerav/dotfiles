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
# Asegúrate de haber instalado starship: curl -sS https://starship.rs/install.sh | sh
export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"

# ==============================================
# 3. PLUGINS (Carga Manual)
# ==============================================
# Nota: Asegúrate de haber clonado estos plugins en ~/dotfiles/zsh/plugins/
# Si no existen, no darán error fatal, solo no cargarán.

source ~/dotfiles/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source ~/dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# ==============================================
# 4. ALIASES (Tus atajos)
# ==============================================
alias ll='ls -lah --color=auto'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias v="nvim"
alias dot="cd ~/dotfiles"
alias reload="source ~/.zshrc"

# --- Alias de GIT (Reemplazo de Oh My Zsh) ---
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
# 5. HERRAMIENTAS EXTERNAS (NVM, FZF, etc)
# ==============================================

# Path para Neovim (si usas la versión descargada en /opt)
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# NVM (Node Version Manager) - Copiado de tu config anterior
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Opcional: Configuración rápida de vi-mode
bindkey -v
