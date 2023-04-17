#!/bin/bash

(
	# Prevent race conditions
	flock 200

	# Terminate already running bar instances
	killall -q polybar

	# Wait until the processes have been shut down
	while pgrep -u $UID -x polybar >/dev/null; do sleep 0.5; done

	# Preferred output
	preferred_tray_output=DP-0
	fallback_tray_output=HDMI-0

	BAR_NAME=top

	if [[ -x /usr/bin/xrandr ]]; then
		outputs=$(xrandr --query | grep " connected" | cut -d" " -f1)
		tray_output=$fallback_tray_output

		# Set preferred tray output, if connected
		for m in $outputs; do
			if [[ $m == "$preferred_tray_output" ]]; then
				tray_output=$m
			fi
		done

		# Reload polybar with tray on preferred output
		for m in $outputs; do
			export MONITOR=$m
			export TRAY_POSITION=none
			if [[ $m == "$tray_output" ]]; then
				TRAY_POSITION=right
			fi

			# Reload polybar and release the lock
			polybar --reload $BAR_NAME </dev/null >/tmp/polybar-$m.log 2>&1 200>&- &
			disown
		done
	else
		# Just reload polybar and release the lock
		polybar --reload $BAR_NAME </dev/null >/tmp/polybar.log 2>&1 200>&- &
		disown
	fi
) 200>/tmp/polybar-launcher.lock
