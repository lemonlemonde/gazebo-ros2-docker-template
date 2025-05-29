#!/bin/bash

# Xvfb
Xvfb :1 -screen 0 1280x800x24 > /tmp/xvfb.log 2>&1 &
XVFB_PID=$!

# x11vnc
x11vnc -display :1 -nopw -forever > /tmp/x11vnc.log 2>&1 &
VNC_PID=$!

# start gazebo
gz sim > /tmp/gazebo.log 2>&1 &
GAZEBO_PID=$!

# interactive shell if you need ROS maybe
bash

# clean exit
# want to kill without having to look up ps aux
echo "Killing Xvfb, x11vnc, and Gazebo..."
kill $XVFB_PID
kill $VNC_PID
kill $GAZEBO_PID
wait $XVFB_PID $VNC_PID $GAZEBO_PID
echo "All processes stopped. Bye!"
exit 0