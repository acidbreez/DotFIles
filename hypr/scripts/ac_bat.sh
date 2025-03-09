#!/bin/bash

AC=/sys/class/power_supply/AC0/online

if [ -r $AC ]; then
	state=$(cat $AC)
	suspend=$(loginctl suspend)
        bat_suspend=$(loginctl suspend-then-hibernate)
		if [ $state -gt 0 ]; then
			$suspend
		elif [ $state -lt 1 ]; then
			$bat_suspend
		fi
fi
