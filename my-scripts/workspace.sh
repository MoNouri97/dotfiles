#!/bin/bash

# Function to list directories
list_dirs() {
  find /mnt/D/Dev/GameDev ~/dotfiles ~/dotfiles/.config /mnt/D/Dev/obsidian -maxdepth 2 -type d \
    -maxdepth 2 \
    -printf "%A@ %p\n" 2>/dev/null |
    sort -rn |
    cut -d' ' -f2-
}

if [ -z "$TMUX" ]; then
  echo "Not in a tmux session"
  exit 1
fi

# Use fzf to select a directory
selected_dir=$(list_dirs | fzf \
  --height 50% \
  --layout=reverse \
  --border)

# If a directory is selected, open it in Neovim
if [ -n "$selected_dir" ]; then

  tmux neww -n "$(basename "$selected_dir")" zsh -c "cd \"$selected_dir\" && nvim ."
  # z \"$selected_dir\" && nvim .
fi
