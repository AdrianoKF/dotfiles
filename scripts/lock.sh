#!/bin/sh

B='#00000000'  # blank
C='#ffffff22'  # clear ish
D="$(xrdb -query | grep '*.background' | cut -f 2)cc"  # default
T="$(xrdb -query | grep '*.foreground' | cut -f 2)ee"  # text
W='#880000bb'  # wrong
V="$(xrdb -query | grep '*.color1:' | cut -f 2)bb"  # verifying

i3lock_fancy_rapid() {
	~/scripts/i3lock-fancy-rapid 16 2
}

i3lock_fancy_rapid
