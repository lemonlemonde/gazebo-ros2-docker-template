## What is this?

Gazebo (Harmonic) and ROS2 (Jazzy) on Docker.
Container runs XFCE lightweight desktop env and is displayed on host machine via Xvfb virtual server and x11vnc.

---

## Quick Start

1. `docker build -t gazebo-template .`
2. `docker run --name gazebo -d -p 5900:5900 gazebo-template`
- Run detached, since want to keep VNC server up and running (AKA don't give container SIGINT with ctrl+C)
- All servers (Gazebo, Xvfb, x11vnc) will automatically run in the background.
- How to pause: `docker stop gazebo`
- How to restart: `docker start gazebo`
    - this will clean up any old X files if server didn't properly end, then spins up all servers again, and you can reconnect!
    - you might have to wait a few secs

3. View on host machine with one of these methods:
- RealVNC (`localhost:5900`)
- OR (`localhost:5900`) Mac's Screen Sharing application, as of Ventura 13.5.2. Any of these methods:
    - Browser --> redirect to Screen Sharing
    - Finder, Go > Connect to server
    - Open app directly in `System/Library/CoreServices/Applications/Screen Sharing`
4. Gazebo should be automatically open! Looks like this:
- right click Desktop > Desktop Settings to set a mousey background :3
![media](/media/startup.png)

---

## Notes
- `x11vnc` was chosen instead of `TigerVNC` because TigerVNC starts its own X server (Xtigervnc) by default. 
    - Tried to only run TigerVNC, but ran into problems with the additional packages required for Gazebo's Qt (e.g., `libgl1-mesa-glx`, `libgl1-mesa-dri`, `libxcb-xinerama0`)
- Unsure exactly why port `5900` is chosen by default, since I thought having the display to `:1` would mean default port becomes `5901`. But it's working fine so far, so I haven't looked into it.
- `net-tools` installation is just there for debugging.
- stdout and stderr of the servers (Xvfb and x11vnc) and Gazebo are redirected to log files in `/tmp`.
- Since you can just pause the container, no need for killing the servers. But, if you need, it's commented out in the `start.sh` script.