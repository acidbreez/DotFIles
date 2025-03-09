#!/bin/bash

lid_state="/proc/acpi/button/lid/LID/state"

if [ -r $lid_state ]; then
	state=$(cat $lid_state | cut -b 13-18)
		if [ $state == closed ]; then
			echo "The screen is now off"
		else
			echo "The screen is still open"
		fi
fi 
	
