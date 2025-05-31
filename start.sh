#!/bin/bash

# clean up old in case restarting container
rm -f /tmp/.X1-lock /tmp/.X11-unix/X1

# Xvfb, make virtual display :1
Xvfb :1 -screen 0 1920x1080x24 > /tmp/xvfb.log 2>&1 &
sleep 5

# start desktop (xfce4) on same display (:1)
DISPLAY=:1 startxfce4 > /tmp/xfce.log 2>&1 &
sleep 5

# x11vnc server
pkill x11vnc || true
x11vnc -display :1 -nopw -forever > /tmp/x11vnc.log 2>&1 &

# keep alive
tail -f /dev/null