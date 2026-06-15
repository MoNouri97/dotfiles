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
  esac
fi
