#!/usr/bin/env sh

# Terminate already running bar instances
sudo killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch polybar

BAR_NAME=top

# Use sudo on arch
if [[ -f /etc/lsb-release ]] && grep -q Ubuntu /etc/lsb-release
then
  POLYBAR_CMD="polybar"
else
  POLYBAR_CMD="sudo -E polybar"
fi

if [[ -x /usr/bin/xrandr ]]; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m $POLYBAR_CMD --reload $BAR_NAME &
  done
else
  $POLYBAR_CMD --reload $BAR_NAME &
fi
