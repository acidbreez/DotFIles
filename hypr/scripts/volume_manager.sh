#!/bin/bash

get_volume(){
    volume=$(wpctl get-volume 53 | cut -c 9-12)
    percentage=$(awk "BEGIN {print ($volume)*100}")

    perc=$(printf "%.0f\n" $percentage)
	echo "${perc}"
}

notify_user() {
	notify-send -h string:x-canonical-private-synchronous:sys-notify -u low "Speakers : $(get_volume)"
}

inc_volume() {
	wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && notify_user
}

dec_volume() {
	wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && notify_user
}

if [[ "$1" == "--get" ]]; then
	get_volume
elif [[ "$1" == "--inc" ]]; then
	inc_volume
elif [[ "$1" == "--dec" ]]; then
	dec_volume
else
	get_volume
fi