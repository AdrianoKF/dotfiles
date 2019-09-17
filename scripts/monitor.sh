#!/bin/bash

eDP_STATUS=$(</sys/class/drm/card0/card0-eDP-1/status)
DP_LEFT_STATUS=$(</sys/class/drm/card0/card0-DP-2/status)
DP_RIGHT_STATUS=$(</sys/class/drm/card0/card0-DP-3/status)

echo "-------------- $(date) -------------"
echo "eDP Status: $eDP_STATUS" >> /tmp/monitorlog
echo "LEFT Status: $DP_LEFT_STATUS" >> /tmp/monitorlog
echo "RIGHT Status: $DP_RIGHT_STATUS" >> /tmp/monitorlog

# Invoke autorandr if present
if [ -x /usr/bin/autorandr ]; then
    /usr/bin/autorandr --change --batch
    DISPLAY=:0 /usr/bin/notify-send --urgency=low -t 5000 "Graphics Update" "Running autorandr"
fi

