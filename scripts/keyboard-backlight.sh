#!/usr/bin/env bash

control_file=/sys/class/leds/*::kbd_backlight/brightness

brightness_val=$(cat $control_file)

if [ "$1" == "down" ]; then
    if [ 0 -lt $brightness_val ]
    then 
	brightness_val=$(($brightness_val - 1))
	echo $brightness_val | sudo tee $control_file
    fi
elif [ "$1" == "up" ]; then
    if [ 3 -gt $brightness_val ]
    then
	brightness_val=$(($brightness_val + 1))
	echo $brightness_val | sudo tee $control_file
    fi
else
    echo "Invalid command: $1"
    exit -1
fi
