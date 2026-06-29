#!/usr/bin/env bash
scrDir=$(dirname "$(realpath "$0")")
source "$scrDir/globalcontrol.sh"
readarray -t backlight_devices < <(ls /sys/class/backlight/ 2>/dev/null)
use_swayosd=false
isNotify=${BRIGHTNESS_NOTIFY:-true}
if command -v swayosd-client >/dev/null 2>&1 && pgrep -x swayosd-server >/dev/null; then
    use_swayosd=true
fi
print_error() {
    local cmd
    cmd=$(basename "$0")
    cat <<EOF
    "$cmd" <action> [step]
    ...valid actions are...
        i -- <i>ncrease brightness [+5%]
        d -- <d>ecrease brightness [-5%]

    Example:
        "$cmd" i 10    # Increase brightness by 10%
        "$cmd" d       # Decrease brightness by default step (5%)
EOF
}
apply_to_all() {
    local cmd="$1"
    if [[ ${#backlight_devices[@]} -eq 0 ]]; then
        brightnessctl $cmd
    else
        for dev in "${backlight_devices[@]}"; do
            brightnessctl -d "$dev" $cmd
        done
    fi
}

send_notification() {
    if [[ ${#backlight_devices[@]} -eq 0 ]]; then
        brightness=$(brightnessctl info | grep -oP "(?<=\()\d+(?=%)" | cat)
        brightinfo=$(brightnessctl info | awk -F "'" '/Device/ {print $2}')
    else
        local dev="${backlight_devices[0]}"
        brightness=$(brightnessctl -d "$dev" info | grep -oP "(?<=\()\d+(?=%)" | cat)
        brightinfo=$(brightnessctl -d "$dev" info | awk -F "'" '/Device/ {print $2}')
    fi
    angle="$((((brightness + 2) / 5) * 5))"
    ico="$iconsDir/Wallbash-Icon/media/knob-$angle.svg"
    bar=$(seq -s "." $((brightness / 15)) | sed 's/[0-9]//g')
    [[ $isNotify == true ]] && notify-send -a "HyDE Notify" -r 7 -t 800 -i "$ico" "$brightness$bar" "$brightinfo"
}

get_brightness() {
    if [[ ${#backlight_devices[@]} -eq 0 ]]; then
        brightnessctl -m | grep -o '[0-9]\+%' | head -c-2
    else
        brightnessctl -d "${backlight_devices[0]}" -m | grep -o '[0-9]\+%' | head -c-2
    fi
}
step=${BRIGHTNESS_STEPS:-5}
step="${2:-$step}"
case $1 in
i | -i)
    if
        [[ $(get_brightness) -lt 10 ]]
    then
        step=1
    fi
    $use_swayosd && swayosd-client --brightness raise "$step" && exit 0
    apply_to_all "set +$step%"
    send_notification
    ;;
d | -d)
    if
        [[ $(get_brightness) -le 10 ]]
    then
        step=1
    fi
    if [[ $(get_brightness) -le 1 ]]; then
        apply_to_all "set $step%"
        $use_swayosd && exit 0
    else
        $use_swayosd && swayosd-client --brightness lower "$step" && exit 0
        apply_to_all "set $step%-"
    fi
    send_notification
    ;;
*) print_error ;;
esac
