# Omarchy environment (OMARCHY_PATH + PATH), needed even for non-interactive shells
[[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap

# If not running interactively, don't do anything else
[[ $- != *i* ]] && return

# Source only the Zsh-compatible Omarchy defaults
# (skipping bash-specific shell, init, completions, and inputrc)
source "$OMARCHY_PATH/default/bash/envs"
source "$OMARCHY_PATH/default/bash/aliases"
source "$OMARCHY_PATH/default/bash/functions"

# Zsh equivalents of the bash shopt settings from .bashrc
setopt AUTOCD
setopt CORRECT
setopt CORRECT_ALL

# ── Zsh Completion (Visual Menu Selection) ──────────────────────────────────
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case-insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
setopt COMPLETE_IN_WORD

# ── Environment ──────────────────────────────────────────────────────────────
export PATH=$HOME/.local/bin:$PATH
export LC_ALL="en_US.UTF-8"
export GPG_TTY=$(tty)
export CLAUDE_CODE_DISABLE_MOUSE=1
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR='nvim'
export TERMINAL='ghostty'

# ── History ──────────────────────────────────────────────────────────────────
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY        # timestamps
setopt SHARE_HISTORY           # sync across open shells
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE       # skip commands starting with a space
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# ── Plugin replacements (No Oh My Zsh) ───────────────────────────────────────
# sudo
alias sudo='sudo '

# colored-man-pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

# fzf
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi

# zsh-autosuggestions & history-substring-search (Arch Linux packages)
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
if [ -f /usr/share/zsh/plugins/history-substring-search/zsh-history-substring-search.zsh ]; then
  source /usr/share/zsh/plugins/history-substring-search/zsh-history-substring-search.zsh
fi
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ── Aliases (merged from .bashrc and .zshrc) ─────────────────────────────────
# ls aliases (eza)
alias l='eza --all --classify=auto -h --group-directories-first --icons=auto'
alias ll='ls -l --all'
alias la='ls -a'
alias lla='ls -la'
alias lsd='ls -d'
alias l.='ls -d .*'

# Personal aliases
alias v="nvim"
alias vim=nvim
alias vsc="code ."
alias dotconf="cd ~/Work/dotfiles && nvim . && cd -"
alias nvimconf="cd ~/.config/nvim && nvim && cd -"
alias ask="cd ~/Work && opencode"

# Neovim variants
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-kick="NVIM_APPNAME=kickstart nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"

# Utilities
alias cat=bat
alias bios="sudo systemctl reboot --firmware-setup"
alias godot="/home/mono/.local/share/godot/app_userdata/Godots/versions/Godot_v4_3-dev2_mono_linux_x86_64/Godot_v4.3-dev2_mono_linux_x86_64/Godot_v4.3-dev2_mono_linux.x86_64"
alias godotrun="dotnet build && godot"

# ── Functions ────────────────────────────────────────────────────────────────
# Pick a Neovim config with fzf and launch it.
nvims() {
  local items=("default" "kickstart" "LazyVim" "NvChad" "AstroNvim") config
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt="Neovim  " --height=~50% --layout=reverse --border --exit-0)
  [[ -z $config ]] && { echo "Nothing selected"; return 0; }
  [[ $config == default ]] && config=""
  NVIM_APPNAME="$config" nvim "$@"
}

# Jump to a git worktree
changeWorkTree() {
  local selected
  selected=$(git worktree list --porcelain \
    | awk '/^worktree/{p=$2} /^branch/{gsub("refs/heads/","",$2); print $2 " => " p}' \
    | fzf | cut -d' ' -f3)
  [[ -n $selected ]] && cd "$selected"
}
alias gw=changeWorkTree

mkfile() { mkdir -p -- "$1" && touch -- "$1"/"$2"; }

game() {
  z "$1" && nvim . --listen ./godothost
}

# ── External tool integrations ───────────────────────────────────────────────
# zoxide
eval "$(zoxide init zsh)"

# starship (same prompt as Omarchy's bash setup)
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# swww override
swww() { awww "$@"; }

# television (tv)
if command -v tv >/dev/null 2>&1; then
  eval "$(tv init zsh)"
fi
