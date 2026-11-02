###############################################################################
# AGENT TASK — make this file work on BOTH Omarchy (Arch) and macOS
#
# This file is stowed to two machines but is written Linux/Omarchy-first with no
# OS branching. Diagnosed on the Mac (2026-11-02) by running it under a real pty.
# Every item below is marked inline at its site with `# FIX n:`.
#
# Current symptoms on macOS:
#   .zshrc:source:9:  no such file or directory: /default/bash/envs
#   .zshrc:source:10: no such file or directory: /default/bash/aliases
#   .zshrc:source:11: no such file or directory: /default/bash/functions
#   l  -> command not found: eza
#   ll -> ls: unrecognized option `--all'
#   no autosuggestions / syntax highlighting / history-substring-search
#   bare default prompt (starship missing): PS1=[%n@%m %1~ %# ]
#
# Do them in this order:
#   0. Add an OS-detect helper near the top, e.g.
#        if [[ $OSTYPE == darwin* ]]; then IS_MAC=1; else IS_MAC=0; fi
#   1. FIX 1  guard the three Omarchy `source` lines on $OMARCHY_PATH.
#   2. FIX 2  per-OS plugin prefix + swap load order + add bindkeys.
#   3. FIX 3  ls aliases that work on BSD ls and without eza.
#   4. FIX 4  guard zoxide like every other integration.
#   5. FIX 5  repoint the stale ~/Work and /home/mono paths.
#   6. FIX 6  Linux-only aliases/functions (bios, swww).
#   7. FIX 7  behaviour choices — ask me before changing these.
#   8. On macOS run: brew install eza starship zsh-autosuggestions \
#        zsh-syntax-highlighting zsh-history-substring-search
#   9. Verify on BOTH machines:  script -q /dev/null zsh -i -c exit
#      Must print nothing. (`zsh -i -c` without a pty emits a spurious
#      "can't change option: zle" — an artifact of no TTY, not a real error.)
#
# ALSO: apply.sh's header comment still says stow targets ~/Work — the repo
# moved to ~/dotfiles. Fix that comment too.
# Delete this block and every `# FIX n:` marker once applied.
###############################################################################

# Omarchy environment (OMARCHY_PATH + PATH), needed even for non-interactive shells
[[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap

# If not running interactively, don't do anything else
[[ $- != *i* ]] && return

# Source only the Zsh-compatible Omarchy defaults
# (skipping bash-specific shell, init, completions, and inputrc)
#
# FIX 1 — three errors on EVERY macOS shell startup.
# The bootstrap above is guarded with [[ -r ... ]], so on a non-Omarchy box
# OMARCHY_PATH stays empty and these expand to /default/bash/envs etc.
# The guard exists; it just isn't carried through to the lines that need it.
# Wrap all three:
#     if [[ -n $OMARCHY_PATH ]]; then
#       source "$OMARCHY_PATH/default/bash/envs"
#       source "$OMARCHY_PATH/default/bash/aliases"
#       source "$OMARCHY_PATH/default/bash/functions"
#     fi
# Knock-on: on macOS the Omarchy aliases never load, which is why FIX 3's
# `ls` aliases break — Omarchy makes `ls` an eza wrapper in that file.
source "$OMARCHY_PATH/default/bash/envs"
source "$OMARCHY_PATH/default/bash/aliases"
source "$OMARCHY_PATH/default/bash/functions"

# Zsh equivalents of the bash shopt settings from .bashrc
#
# FIX 7 — behaviour choices, not bugs. ASK ME before changing any of these.
#
# (a) CORRECT_ALL below is the one I'd drop first. The comment claims these
#     mirror bash's cdspell/dirspell, but those are cd-only. CORRECT_ALL
#     second-guesses every argument of every command — the setting people
#     famously turn back off. Plain CORRECT already matches the stated intent.
# (b) compinit (next section) rebuilds the dump on every startup, costing
#     startup time. Usual pattern: check .zcompdump's age once a day and use
#     `compinit -C` otherwise.
# (c) `export LC_ALL=` in the Environment section overrides every LC_* and
#     LANG. Setting LANG instead leaves per-category overrides working.
# (d) `alias sudo='sudo '` + `alias cat=bat`: the trailing space makes the
#     next word alias-expand, so `sudo cat` silently becomes `sudo bat`.
#     Usually what people want, but worth knowing it's happening.
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
#
# FIX 2 — two bugs here.
#
# (a) These paths are Arch-only, so on macOS all three silently do nothing:
#     no autosuggestions, no syntax highlighting, no history-substring-search.
#     They fail quietly because they're -f guarded, which is why the shell is
#     just worse with no complaint. Use a per-OS prefix:
#         if [[ $IS_MAC == 1 ]]; then
#           ZSH_PLUGIN_DIR=/opt/homebrew/share
#         else
#           ZSH_PLUGIN_DIR=/usr/share/zsh/plugins
#         fi
#     Homebrew's layout differs from Arch's — verify the real filenames with
#     `ls /opt/homebrew/share | grep zsh` after installing; brew drops them at
#     e.g. /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
#     (no /plugins/ segment). Don't guess the paths, check them.
#
# (b) Load ORDER is wrong on Linux too: history-substring-search must be
#     sourced AFTER zsh-syntax-highlighting (its README requires it), but it's
#     currently before. Swap the two blocks below.
#     And it's a no-op on both machines anyway — the arrow keys were never
#     bound. After sourcing it, add:
#         bindkey '^[[A' history-substring-search-up
#         bindkey '^[[B' history-substring-search-down
#         bindkey -M vicmd 'k' history-substring-search-up
#         bindkey -M vicmd 'j' history-substring-search-down
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
#
# FIX 3 — both of the next two lines are hard-broken on macOS.
#   l  -> command not found: eza        (not installed; brew install eza)
#   ll -> ls: unrecognized option `--all'  (BSD ls has no long options)
# `ll` only works on Omarchy because the Omarchy aliases from FIX 1 replace
# `ls` with an eza wrapper — so this is really two bugs stacked.
# Either define `l` only when eza exists and fall back to `ls` otherwise, or
# (simpler) make eza a hard requirement on both boxes and route every alias
# through it. Then `ll` must stop using GNU `--all`: use `-a` or eza directly.
alias l='eza --all --classify=auto -h --group-directories-first --icons=auto'
alias ll='ls -l --all'
alias la='ls -a'
alias lla='ls -la'
alias lsd='ls -d'
alias l.='ls -d .*'

# Personal aliases
#
# FIX 5 — stale paths. `dotconf` points at ~/Work/dotfiles and `ask` at ~/Work;
# neither exists — the repo lives at ~/dotfiles now. Repoint both.
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
#
# FIX 6 — Linux-only, dead on macOS:
#   bios  -> systemctl doesn't exist on macOS
#   godot -> hard-coded /home/mono/... path
# Guard both behind the IS_MAC check (or drop godot if you no longer use it).
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
#
# FIX 4 — this is the only integration in this section NOT wrapped in a
# `command -v` check (fzf, starship and tv all are). In a non-login shell,
# where .zprofile's `brew shellenv` hasn't run yet, it throws
# "command not found: zoxide". Wrap it to match the others.
eval "$(zoxide init zsh)"

# starship (same prompt as Omarchy's bash setup)
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# swww override
#
# FIX 6 (cont.) — `awww` doesn't exist on macOS, so this shadows swww with a
# function that always fails. Define it only on Linux.
swww() { awww "$@"; }

# television (tv)
if command -v tv >/dev/null 2>&1; then
  eval "$(tv init zsh)"
fi
