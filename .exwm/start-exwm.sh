#!/bin/sh

# this makes it work in Ubuntu
xhost +
## you might need to append the TTY you are working on
xinit

wmname LG3D
export _JAVA_AWT_WM_NONREPARENTING=1
# export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

export VISUAL=emacsclient
export EDITOR="$VISUAL"

# exec dbus-launch --sh-syntax --exit-with-session emacs --eval "(exwm-enable)"
exec emacs --eval "(exwm-enable)"
