#!/usr/bin/env bash

control_file=/sys/class/backlight/intel_backlight/brightness
brightness_val=$(sudo cat $control_file)
max_brightness=$(sudo cat /sys/class/backlight/intel_backlight/max_brightness)
step=100

if [ "$2" != "" ]; then
   echo "Using custom step: $2"
   step=$2
fi

if [ "$1" == "down" ]; then
    brightness_val=$(($brightness_val - $step))
    if (( $brightness_val < 0 )); then
	echo "Minimum brightness, clipping"
	brightness_val=0
    fi
    echo $brightness_val | sudo tee $control_file
elif [ "$1" == "up" ]; then
    brightness_val=$(($brightness_val + $step))
    if (( $brightness_val > $max_brightness )); then
	echo "Maximum brighness, clipping"
	brightness_val=$max_brightness
    fi
    echo $brightness_val | sudo tee $control_file
else
    echo "Usage: backlight.sh [up | down]"
    exit -1
fi

pkill -RTMIN+2 i3blocks
