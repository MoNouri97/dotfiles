#!/bin/bash
mins=$1
sleep "${mins}m"
notify-send "⏰ Timer done" "${mins} minute timer finished"
tmux display-message "⏰ Timer done: ${mins} minutes"
