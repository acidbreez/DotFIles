!/usr/bin/env bash

iDIR="$HOME/.config/mako/icons"

# Get brightness
get_backlight() {

	brightness=$(brightnessctl g)
	max_brightness=$(cat /sys/class/backlight/intel_backlight/max_brightness)
	percentage=$(($brightness * 100 / $max_brightness))

	LIGHT=$(printf "%.0f\n" $percentage)
	echo "${LIGHT}"
}

# Get icons
get_icon() {
	current="$(brightnessctl g)"
	if [[ ("$current" -ge "15360") && ("$current" -le "19200") ]]; then
		icon="$iDIR/brightness-100.png"
	elif [[ ("$current" -ge "11520") && ("$current" -le "15360") ]]; then
		icon="$iDIR/brightness-80.png"
	elif [[ ("$current" -ge "7680") && ("$current" -le "11520") ]]; then
		icon="$iDIR/brightness-60.png"
	elif [[ ("$current" -ge "3840") && ("$current" -le "7680") ]]; then
		icon="$iDIR/brightness-40.png"
	elif [[ ("$current" -ge "0") && ("$current" -le "3840") ]]; then
		icon="$iDIR/brightness-20.png"
	fi
}

# Notify
notify_user() {
	notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$icon" "Brightness : $(get_backlight)"
}

# Increase brightness
inc_backlight() {
	brightnessctl s +5% && get_icon && notify_user
}

# Decrease brightness
dec_backlight() {
	brightnessctl s 5%- && get_icon && notify_user
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
	get_backlight
elif [[ "$1" == "--inc" ]]; then
	inc_backlight
elif [[ "$1" == "--dec" ]]; then
	dec_backlight
else
	get_backlight
fi
