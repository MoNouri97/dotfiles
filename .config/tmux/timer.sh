#!/bin/bash
mins=$1
end_time=$(($(date +%s) + mins * 60))
timer_file="$HOME/.config/tmux/timer_end"

# save end time for status bar
echo "$end_time" >"$timer_file"

# background loop to update tmux option every second
(
  while true; do
    now=$(date +%s)
    remaining=$((end_time - now))
    if [ "$remaining" -le 0 ]; then
      tmux set-option -g @timer_remains ""
      rm -f "$timer_file"
      break
    fi
    m=$((remaining / 60))
    s=$((remaining % 60))
    tmux set-option -g @timer_remains "⏰ $(printf '%02d:%02d' "$m" "$s") "
    sleep 1
  done
) &

# wait for the timer to finish, then notify
sleep "${mins}m"
notify-send -e -t 0 "⏰ Timer done" "${mins} minute timer finished" -i " "
tmux display-message "⏰ Timer done: ${mins} minutes"
