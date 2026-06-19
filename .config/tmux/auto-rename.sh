#!/bin/bash
path="$1"
name=$(tmux display-message -p '#{window_name}')

if [[ "$name" == "" || "$name" == "Window" ]]; then
  case "$path" in
  */mobile-repo*)
    tmux setw automatic-rename off
    tmux rename-window "MOBILE"
    ;;
  */codename-electron.git*)
    tmux setw automatic-rename off
    tmux rename-window "WEB"
    ;;
  */BoardGame*)
    tmux setw automatic-rename off
    tmux rename-window "Cards"
    ;;
  */nvim*)
    tmux setw automatic-rename off
    tmux rename-window "NVIM"
    ;;
  */dotfiles*)
    tmux setw automatic-rename off
    tmux rename-window "CONFIG"
    ;;
  */obsidian-vault*)
    tmux setw automatic-rename off
    tmux rename-window "OBSIDIAN"
    ;;
  esac
fi
