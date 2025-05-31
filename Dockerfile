# base image with ros and gazebo combo that play well with each other (humble + fortress)
    # see here: https://gazebosim.org/docs/all/ros_installation/
FROM osrf/ros:humble-desktop-full

# installs
# can remove extra flags if unnecessary, but may help with unstable network
RUN apt-get update --fix-missing && apt-get -o Acquire::Retries=5 install -y --no-install-recommends \
    xfce4 xfce4-goodies \
    dbus-x11 x11-xserver-utils libgl1-mesa-glx libgl1-mesa-dri net-tools \
    xvfb x11vnc \
    xdg-utils \
    && rm -rf /var/lib/apt/lists/*

# vs code too :p
ENV DEBIAN_FRONTEND=noninteractive
RUN curl -L -o vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" \
    && dpkg -i vscode.deb || apt-get install -f -y \
    && rm vscode.deb
    
    COPY start.sh /start.sh
    RUN chmod +x /start.sh

# so that all shells have env var
ENV DISPLAY=:1

CMD ["/start.sh"]

# don't want root anymore
RUN useradd -m mousey
# default bash
RUN chsh -s /bin/bash mousey
USER mousey
