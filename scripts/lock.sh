#!/bin/sh

B='#00000000'  # blank
C='#ffffff22'  # clear ish
D="$(xrdb -query | grep '*.background' | cut -f 2)cc"  # default
T="$(xrdb -query | grep '*.foreground' | cut -f 2)ee"  # text
W='#880000bb'  # wrong
V="$(xrdb -query | grep '*.color1:' | cut -f 2)bb"  # verifying

i3lock \
--insidevercolor=$C   \
--ringvercolor=$V     \
\
--insidewrongcolor=$C \
--ringwrongcolor=$W   \
\
--insidecolor=$D      \
--ringcolor=$D        \
--linecolor=$B        \
--separatorcolor=$D   \
\
--verifcolor=$T        \
--wrongcolor=$T        \
--timecolor=$T        \
--datecolor=$T        \
--layoutcolor=$T      \
--keyhlcolor=$V       \
--bshlcolor=$V        \
\
--blur 20              \
--clock               \
--indicator           \
--timestr="%H:%M:%S"  \
--datestr="%A, %m %Y" \
--keylayout 2         \

# --veriftext="Drinking verification can..."
# --wrongtext="Nope!"
# --textsize=20
# --modsize=10
# --timefont=comic-sans
# --datefont=monofur
# etc

