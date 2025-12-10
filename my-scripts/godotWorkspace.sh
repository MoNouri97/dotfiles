#!/bin/bash

# This script opens three applications in consecutive Hyprland workspaces
# - godots in current workspace
# - nvim in next workspace
# - obsidian in third workspace

# Get the current workspace number
CURRENT_WORKSPACE=$(hyprctl activeworkspace -j | jq '.id')

# Launch Godots in the current workspace
hyprctl dispatch exec "[workspace $CURRENT_WORKSPACE] godots"
notify-send "Launched Godots in workspace $CURRENT_WORKSPACE"

# Calculate the next workspace
NEXT_WORKSPACE=$((CURRENT_WORKSPACE + 1))
notify-send "Launched Kitty in workspace $NEXT_WORKSPACE"

# Launch Kitty in the next workspace
# hyprctl dispatch exec "[workspace $NEXT_WORKSPACE] kitty tmux"
project="board"
DIR=$(zoxide query $project)
hyprctl dispatch exec "[workspace $NEXT_WORKSPACE] kitty tmux new-session -s mysession 'zsh -c \"cd $DIR && nvim . --listen ./godothost && zsh || zsh\"'"

# Calculate the third workspace
THIRD_WORKSPACE=$((CURRENT_WORKSPACE + 2))

# Launch Obsidian in the third workspace
hyprctl dispatch exec "[workspace $THIRD_WORKSPACE] obsidian"

notify-send "Launched Obsidian in workspace $THIRD_WORKSPACE"
