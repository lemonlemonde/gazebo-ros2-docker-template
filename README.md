## What is this?

Template for Dockerized ROS2 (Humble) (base image: humble-desktop-full, which is on Ubuntu 22.04).

Container runs XFCE lightweight desktop env and can interact from host machine via Xvfb virtual server and x11vnc.

Preinstalled:
- everything in `humble-desktop-full`, so `ros2`
    - `Gazebo` is part of this, but seemingly not configured with CLI (e.g., can't do `gz sim`, whereas `ros2 launch ros_gz_sim_demos imu.launch.py` works)
- code (start with `code &`, or in Applications > Development)


Inspired(?) by:
- https://medium.com/@oelmofty/ros2-in-docker-why-and-how-b72b3880dc97
- https://github.com/jbnunn/ROSGazeboDesktop

---

## Quick Start

1. `docker build -t ros-humble-template .`
2. `docker run --name ros-humble -d -p 5900:5900 ros-humble-template`
    - All servers (Xvfb, x11vnc) will automatically run in the background.
    - How to pause: `docker stop ros-humble`
    - How to restart: `docker start ros-humble`
        - you might have to wait a few secs to reconnect

3. View on host machine with one of these methods:
    - RealVNC (`localhost:5900`)
    - OR (`vnc://localhost:5900`) Mac's Screen Sharing application, as of Ventura 13.5.2 on 2019 Macbook Pro. Any of these methods:
        - Browser --> redirect to Screen Sharing
        - Finder, Go > Connect to server
        - Open app directly in `System/Library/CoreServices/Applications/Screen Sharing`

4. Follow [this](https://docs.ros.org/en/humble/Tutorials/Beginner-CLI-Tools/Configuring-ROS2-Environment.html) to set up ROS2 env.
5. Profit 📈

---

## Notes
- Restarting container runs `start.sh` again, and this will clean up any old X files if server didn't properly end. Then spins up all servers again, and you can reconnect!
- `x11vnc` was chosen instead of `TigerVNC` because TigerVNC starts its own X server (Xtigervnc) by default. 
- `x11vnc`'s `-nopw` flag means there's no password, so...it's insecure :)
- Unsure exactly why port `5900` is chosen by default, since I thought having the display to `:1` would mean default port becomes `5901`. But it's working fine so far, so I haven't looked into it.
- stdout and stderr of Xvfb, x11vnc, and XFCE are redirected to log files in `/tmp`.
- `net-tools` installation is just there for debugging.
- `xdg-utils` for VS Code installation, for some reason
- `dbus-x11 x11-xserver-utils libgl1-mesa-glx libgl1-mesa-dri` are extra utils for the X server and for rendering Gazebo's Qt GUI.
    - (`libgl1-mesa-glx` is replaced with `libgl1` for newer Ubuntu versions (24.04)) 
