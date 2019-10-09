#!/bin/bash

PLCTL_BIN=/usr/bin/playerctl

if [[ ! -x $PLCTL_BIN ]]; then
  exit -1
fi

format='{{emoji(status)}} {{xesam:artist}} - {{xesam:title}}'
title=$($PLCTL_BIN metadata --format="$format" 2>/dev/null)

echo -n $title
