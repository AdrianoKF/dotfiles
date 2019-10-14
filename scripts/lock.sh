#!/bin/sh

B='#00000000'  # blank
C='#ffffff22'  # clear ish
D="$(xrdb -query | grep '*.background' | cut -f 2)cc"  # default
T="$(xrdb -query | grep '*.foreground' | cut -f 2)ee"  # text
W='#880000bb'  # wrong
V="$(xrdb -query | grep '*.color1:' | cut -f 2)bb"  # verifying

lock_screen() {
	~/scripts/i3lock-fancy-rapid 16 2 -n
}

pause_dunst() {
#	notify-send "DUNST_COMMAND_PAUSE"
	killall -SIGUSR1 dunst
}

unpause_dunst() {
#	notify-send "DUNST_COMMAND_RESUME"
	killall -SIGUSR2 dunst
}

pause_dunst
lock_screen
unpause_dunst
