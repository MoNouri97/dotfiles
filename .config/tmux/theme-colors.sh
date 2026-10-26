#!/usr/bin/env bash
# Sync the Catppuccin tmux palette (@thm_*) from the active Omarchy theme and
# re-apply the theme-dependent styles.
#
# Called from tmux.conf after tpm has loaded (the plugin unsets @thm_* while
# loading, so overrides have to come afterwards) and from the Omarchy
# theme-set hook so a running tmux follows theme changes live.

set -euo pipefail

styles="$HOME/.config/tmux/theme-styles.conf"
theme_dir="${XDG_STATE_HOME:-$HOME/.local/state}/omarchy/current/theme"
colors="$theme_dir/colors.toml"

# No tmux server: nothing to theme (e.g. theme changed while tmux is closed).
tmux show-options -g status >/dev/null 2>&1 || exit 0

if [[ -r $colors ]]; then
  declare -A c=()

  while IFS='=' read -r key value; do
    key=${key//[[:space:]]/}
    value=${value//[[:space:]]/}
    value=${value//\"/}
    if [[ -z $key || $key == \#* ]]; then
      continue
    fi
    c[$key]=$value
  done <"$colors"

  set_color() {
    local name=$1 key=$2
    if [[ -n ${c[$key]:-} ]]; then
      tmux set -g "@thm_$name" "${c[$key]}"
    fi
  }

  set_color bg        background
  set_color mantle    dark_background
  set_color crust     darker_background
  set_color fg        foreground
  set_color subtext_1 dark_foreground
  set_color subtext_0 light_foreground
  set_color overlay_0 muted
  set_color overlay_1 muted
  set_color overlay_2 muted
  set_color surface_0 lighter_background
  set_color surface_1 selection
  set_color surface_2 muted
  set_color rosewater bright_foreground
  set_color flamingo  orange
  set_color pink      bright_magenta
  set_color mauve     magenta
  set_color red       red
  set_color maroon    brown
  set_color peach     orange
  set_color yellow    yellow
  set_color green     green
  set_color teal      cyan
  set_color sky       bright_cyan
  set_color sapphire  bright_blue
  set_color blue      blue
  set_color lavender  bright_magenta
fi

if [[ -r $styles ]]; then
  tmux source-file "$styles"
fi
