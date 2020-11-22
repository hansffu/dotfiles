#!/bin/sh

export _JAVA_AWT_WM_NONREPARENTING=1

exec dbus-launch --sh-syntax --exit-with-session emacs -mm --debug-init
