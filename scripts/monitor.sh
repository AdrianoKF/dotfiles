#!/bin/bash

# Bail out on error
set -e

DP_LEFT_STATUS=$(</sys/class/drm/card0/card0-DP-2/status)
DP_RIGHT_STATUS=$(</sys/class/drm/card0/card0-DP-3/status)

echo "LEFT Status: $DP_LEFT_STATUS" >> /tmp/monitorlog
echo "RIGHT Status: $DP_RIGHT_STATUS" >> /tmp/monitorlog

DISPLAY=:0 /usr/bin/notify-send --urgency=low -t 5000 "Graphics Update" "Something happened"
