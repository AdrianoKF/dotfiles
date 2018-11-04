#!/usr/bin/env bash

brightness_val=$(cat /sys/class/leds/asus::kbd_backlight/brightness)

if [ "$1" == "down" ]; then
    if [ 0 -lt $brightness_val ]
    then 
	brightness_val=$(($brightness_val - 1))
	echo $brightness_val | tee /sys/class/leds/asus::kbd_backlight/brightness
    fi
elif [ "$1" == "up" ]; then
    if [ 3 -gt $brightness_val ]
    then
	brightness_val=$(($brightness_val + 1))
	echo $brightness_val | tee /sys/class/leds/asus::kbd_backlight/brightness
    fi
else
    echo "Invalid command: $1"
    exit -1
fi
