#!/bin/sh

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

FILE="$DIR/screenshot-$(date +%F_%H-%M-%S).png"

hyde-shell grimblast save output "$FILE"

notify-send \
  -i "$FILE" \
  "Screenshot saved" \
  "$(basename "$FILE")"

##!bash
#grimblast save output
#notify-send "screenshot"
#
#
