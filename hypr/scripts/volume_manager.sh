#!/bin/bash

iDIR="$HOME/.config/mako/icons"

get_volume(){
    muted=$(wpctl get-volume 53 | cut -c 15-19)
    volume=$(wpctl get-volume 53 | cut -c 9-12)
    percentage=$(awk "BEGIN {print ($volume)*100}")

    perc=$(printf "%.0f\n" $percentage)
	if [[ $muted == "MUTED" ]]; then
        echo "Muted"
    else
	    echo "${perc}"
    fi
}

get_icon(){
    current=$(get_volume)
	if [[ ($current -ge "75") ]]; then
		icon="$iDIR/volume-high.png"
	elif [[ ($current -ge "40") && ("$current" -le "75") ]]; then
		icon="$iDIR/volume-mid.png"
	elif [[ ($current -ge "1") && ("$current" -le "35") ]]; then
		icon="$iDIR/volume-low.png"
	elif [[ ($current -eq "0") ]]; then
		icon="$iDIR/volume-mute.png"
    else
        icon="$iDIR/volume-mute.png"
	fi
}

notify_user() {
	notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$icon" "Speakers : $(get_volume)"
}

inc_volume() {
	wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && get_icon && notify_user
}

dec_volume() {
	wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && get_icon && notify_user
}

mute_volume() {
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && get_icon && notify_user
}

if [[ "$1" == "--get" ]]; then
	get_volume
elif [[ "$1" == "--inc" ]]; then
	inc_volume
elif [[ "$1" == "--dec" ]]; then
	dec_volume
elif [[ "$1" == "--mute" ]]; then
    mute_volume
else
	notify_user
fi