#!/bin/bash

STATUS=$(bluetoothctl show | grep "Powered" | awk '{print $2}')

if [ $STATUS = "yes" ]; then
	bluetoothctl power off
else
	bluetoothctl power on
fi
