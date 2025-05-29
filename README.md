## What is this?

Gazebo (Harmonic) and ROS2 (Jazzy) on Docker, with Xvfb virtual server and x11vnc.

It's actually not very comfortable without the desktop environment....so I'm not sure why one would choose this. But I think you could install a desktop env on top of this template, and it should work?

## Quick Start

1. `docker build -t gazebo-template .`
2. `docker run --name gazebo -it -p 5900:5900 gazebo-template`
- All servers (Gazebo, Xvfb, x11vnc) will automatically run in the background.
- Exit with `exit`. (This will kill the servers and)
- Restart paused container with `docker start -ai gazebo`

3. View on host machine with one of these methods:
- RealVNC (`localhost:5900`)
- (`localhost:5900`) Mac's Screen Sharing application, as of Ventura 13.5.2. Any of these methods:
    - Browser --> redirect to Screen Sharing
    - Finder, Go > Connect to server
    - Open app directly in `System/Library/CoreServices/Applications/Screen Sharing`

---

## Notes
- `x11vnc` was chosen instead of `TigerVNC` because TigerVNC starts its own X server (Xtigervnc) by default. 
    - Tried to only run TigerVNC, but ran into problems with the additional packages required for Gazebo's Qt (e.g., `libgl1-mesa-glx`, `libgl1-mesa-dri`, `libxcb-xinerama0`)
- Unsure exactly why port `5900` is chosen by default, since I thought having the display to `:1` would mean default port becomes `5901`. But it's working fine so far, so I haven't looked into it.
- `net-tools` installation is just there for debugging.
- stdout and stderr of the servers (Xvfb and x11vnc) and Gazebo are redirected to log files in `/tmp`.
- Since you can just pause the container, no need for killing the servers. But, if you need, it's commented out in the `start.sh` script.