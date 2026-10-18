#!/usr/bin/env bash
# Apply these dotfiles to $HOME with GNU stow.
#
#   ./apply.sh          link everything (hypr, nvim and my-scripts are
#                       excluded via .stow-local-ignore)
#   ./apply.sh -n -v    dry run: show what would change
#   ./apply.sh -R       restow (unstow + stow, prunes stale links)
#   ./apply.sh -D       unstow: remove all symlinks this repo owns
#
# TROUBLESHOOTING — "cannot stow ... over existing target":
# an editor with atomic saves (VSCode, codium, ...) replaces a stow symlink
# with a plain file when you save through it. That's usually YOUR edit:
#   diff ~/.config/<path> <repo>/<path>     # see what changed
#   cp -p ~/.config/<path> <repo>/<path>    # keep your version in the repo
#   rm ~/.config/<path> && ./apply.sh       # re-link
# Edits made with editors that write in place (vim default, etc.) land in the
# repo directly through the symlink — nothing to do, just git commit them.
#
# -t/--target is required here: without it stow targets the PARENT of
# this directory (~/Work), not $HOME.
set -euo pipefail
cd "$(dirname "$0")"
exec stow --target "$HOME" "$@" .
