# OS detection: 1 on macOS, 0 on Linux/Omarchy
if [[ $OSTYPE == darwin* ]]; then
  IS_MAC=1
else
  IS_MAC=0
fi

# Omarchy environment (OMARCHY_PATH + PATH), needed even for non-interactive shells
[[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap

# If not running interactively, don't do anything else
[[ $- != *i* ]] && return

# Source only the Zsh-compatible Omarchy defaults
# (skipping bash-specific shell, init, completions, and inputrc)
if [[ -n $OMARCHY_PATH ]]; then
  source "$OMARCHY_PATH/default/bash/envs"
  source "$OMARCHY_PATH/default/bash/aliases"
  source "$OMARCHY_PATH/default/bash/functions"
fi

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

# Zsh plugins: Arch ships them under /usr/share/zsh/plugins, Homebrew under
# $(brew --prefix)/share — on Apple Silicon /opt/homebrew, on Intel /usr/local.
if [[ $IS_MAC == 1 ]]; then
  ZSH_PLUGIN_DIRS=(/opt/homebrew/share /usr/local/share)
else
  ZSH_PLUGIN_DIRS=(/usr/share/zsh/plugins)
fi

# Source the first existing plugin file across the candidate dirs.
_source_zsh_plugin() {
  local dir
  for dir in $ZSH_PLUGIN_DIRS; do
    if [[ -f $dir/$1/$2 ]]; then
      source "$dir/$1/$2"
      return 0
    fi
  done
  return 1
}

_source_zsh_plugin zsh-autosuggestions zsh-autosuggestions.zsh

# Must come before history-substring-search.
_source_zsh_plugin zsh-syntax-highlighting zsh-syntax-highlighting.zsh

# Arch names the package dir history-substring-search, Homebrew zsh-history-substring-search.
if _source_zsh_plugin history-substring-search zsh-history-substring-search.zsh ||
   _source_zsh_plugin zsh-history-substring-search zsh-history-substring-search.zsh; then
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
fi

# ── Aliases (merged from .bashrc and .zshrc) ─────────────────────────────────
# ls aliases: eza when installed, otherwise plain ls (BSD- and GNU-compatible)
if command -v eza >/dev/null 2>&1; then
  alias l='eza --all --classify=auto -h --group-directories-first --icons=auto'
  alias ll='eza -l --all --classify=auto -h --group-directories-first --icons=auto'
  alias la='eza --all'
  alias lla='eza -l --all'
  alias lsd='eza -d'
  alias l.='eza -d .*'
else
  alias l='ls -a'
  alias ll='ls -la'
  alias la='ls -a'
  alias lla='ls -la'
  alias lsd='ls -d'
  alias l.='ls -d .*'
fi

# Personal aliases
alias v="nvim"
alias vim=nvim
alias vsc="code ."
alias dotconf="cd ~/Work/dotfiles && nvim . && cd -"
alias nvimconf="cd ~/.config/nvim && nvim && cd -"
alias ask="cd ~/Work && opencode"
alias cmbuild=~/Work/dotfiles/my-scripts/codemagic-build.sh

# Machine-local secrets (CM_API_TOKEN, ...), lives outside the repo
[[ -r ~/Work/.secrets.zsh ]] && source ~/Work/.secrets.zsh

# Neovim variants
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-kick="NVIM_APPNAME=kickstart nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"

# Utilities
alias cat=bat
# Linux-only: systemctl and the hard-coded Godot path don't exist on macOS
if [[ $IS_MAC == 0 ]]; then
  alias bios="sudo systemctl reboot --firmware-setup"
  alias godot="/home/mono/.local/share/godot/app_userdata/Godots/versions/Godot_v4_3-dev2_mono_linux_x86_64/Godot_v4.3-dev2_mono_linux_x86_64/Godot_v4.3-dev2_mono_linux.x86_64"
  alias godotrun="dotnet build && godot"
fi

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
# zoxide: --cmd cd makes cd the zoxide jump (and cdi the fzf picker), so plain
# `cd path` still works while `cd partial-name` jumps to a known directory.
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh --cmd cd)"
  alias z=cd
  alias zi=cdi
fi

# starship (same prompt as Omarchy's bash setup)
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# swww override (Linux-only: `awww` doesn't exist on macOS)
if [[ $IS_MAC == 0 ]]; then
  swww() { awww "$@"; }
fi

# television (tv)
if command -v tv >/dev/null 2>&1; then
  eval "$(tv init zsh)"
fi
