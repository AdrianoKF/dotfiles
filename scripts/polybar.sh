#!/usr/bin/env sh

# Terminate already running bar instances
sudo killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch polybar

# Use sudo on arch
if grep -q Ubuntu /etc/lsb-release
then
  polybar top &
else
  sudo -E polybar top &
fi
