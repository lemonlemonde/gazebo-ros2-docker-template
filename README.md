## What is this?

Dockerized Gazebo (Harmonic) and ROS2 (Jazzy).
Container runs XFCE lightweight desktop env and can interact from host machine via Xvfb virtual server and x11vnc.

---

## Quick Start

1. `docker build -t gazebo-template .`
2. `docker run --name gazebo -d -p 5900:5900 gazebo-template`
- All servers (Gazebo, Xvfb, x11vnc) will automatically run in the background.
- How to pause: `docker stop gazebo`
- How to restart: `docker start gazebo`
    - you might have to wait a few secs to reconnect

3. View on host machine with one of these methods:
- RealVNC (`localhost:5900`)
- OR (`localhost:5900`) Mac's Screen Sharing application, as of Ventura 13.5.2 on 2019 Macbook Pro. Any of these methods:
    - Browser --> redirect to Screen Sharing
    - Finder, Go > Connect to server
    - Open app directly in `System/Library/CoreServices/Applications/Screen Sharing`
4. Gazebo should be automatically open! Looks like this:
- right click Desktop > Desktop Settings to set a mousey background :3
![media](/media/startup.png)

---

## Notes
- Restarting container runs `start.sh` again, and this will clean up any old X files if server didn't properly end. Then spins up all servers again, and you can reconnect!
- `x11vnc` was chosen instead of `TigerVNC` because TigerVNC starts its own X server (Xtigervnc) by default. 
    - Tried to only run TigerVNC, but ran into problems with the additional packages required for Gazebo's Qt (e.g., `libgl1-mesa-glx`, `libgl1-mesa-dri`, `libxcb-xinerama0`) (actually, `libgl1-mesa-glx` was deprecated for newer Ubuntu versions, so it might work if I replace with `libgl1` instead?)
- Unsure exactly why port `5900` is chosen by default, since I thought having the display to `:1` would mean default port becomes `5901`. But it's working fine so far, so I haven't looked into it.
- `net-tools` installation is just there for debugging.
- stdout and stderr of Xvfb, x11vnc, XFCE, and Gazebo are redirected to log files in `/tmp`.