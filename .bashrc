# Omarchy environment (OMARCHY_PATH + PATH), needed even for non-interactive shells
[[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap

# If not running interactively, don't do anything else (leave this above the rc source)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source "$OMARCHY_PATH/default/bash/rc"

# zsh-style shell niceties (bash equivalents)
shopt -s autocd      # type a directory name to cd into it (zsh AUTO_CD)
shopt -s cdspell     # fix small typos in cd paths (zsh CORRECT)
shopt -s dirspell    # fix typos during directory completion
shopt -s cdable_vars # cd into a dir named by a variable, e.g. cd myvar

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'

# ls aliases in the style of zsh / oh-my-zsh (overwriting the defaults above)
alias l='eza --classify=auto -h --group-directories-first --icons=auto'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lsd='ls -d'
alias l.='ls -d .*'
# note: oh-my-zsh's `lt='ls -ltrh'` (time-sorted) is skipped — Omarchy uses
# `lt` for its eza tree alias above.

# ── Personal functions (ported from the old .zshrc) ─────────────────────────

# Pick a Neovim config with fzf and launch it.
nvims() {
  local items=("default" "kickstart" "LazyVim" "NvChad" "AstroNvim") config
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt="Neovim  " --height=~50% --layout=reverse --border --exit-0)
  [[ -z $config ]] && { echo "Nothing selected"; return 0; }
  [[ $config == default ]] && config=""
  NVIM_APPNAME="$config" nvim "$@"
}

# Jump to a git worktree (see also: Omarchy's `ga` / `gd`).
changeWorkTree() {
  local selected
  selected=$(git worktree list --porcelain \
    | awk '/^worktree/{p=$2} /^branch/{gsub("refs/heads/","",$2); print $2 " => " p}' \
    | fzf | cut -d' ' -f3)
  [[ -n $selected ]] && cd "$selected"
}
alias gw=changeWorkTree

mkfile() { mkdir -p -- "$1" && touch -- "$1"/"$2"; }

game() { z "$1" && nvim . --listen ./godothost; }

# ── Personal aliases ────────────────────────────────────────────────────────
alias dotconf='cd ~/Work/dotfiles && nvim . && cd -'
alias nvimconf='cd ~/.config/nvim && nvim && cd -'

# ── Compact system summary on new interactive shells ────────────────────────
# Uses fastfetch's system config (/etc/fastfetch/config.jsonc) for the Omarchy
# keys/colors, so no user-level config is created (an existing
# ~/.config/fastfetch/config.jsonc would shadow it and break the About window).
# if [[ -t 1 ]] && command -v fastfetch >/dev/null 2>&1; then
#   fastfetch --logo Linux_small --structure Title:Host:OS:Kernel:Uptime:Memory
# fi
