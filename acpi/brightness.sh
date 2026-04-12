#!/bin/sh
case "$1" in
    video/brightnessdown*) brightnessctl set 5%- ;;
    video/brightnessup*)   brightnessctl set +5% ;;
esac
