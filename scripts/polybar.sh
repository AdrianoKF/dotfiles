#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch polybar

BAR_NAME=top

if [[ -x /usr/bin/xrandr ]]; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload $BAR_NAME &
  done
else
  polybar --reload $BAR_NAME &
fi
