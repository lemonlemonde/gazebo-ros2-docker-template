# base image with ros and gazebo combo that play well with each other (jazzy + harmonic)
FROM osrf/ros:jazzy-desktop-full

# installs
# can remove extra flags if unnecessary, but may help with unstable network
RUN apt-get update --fix-missing && apt-get -o Acquire::Retries=5 install -y --no-install-recommends \
    xfce4 xfce4-goodies \
    dbus-x11 x11-xserver-utils libgl1 libgl1-mesa-dri net-tools \
    xvfb x11vnc \
    && rm -rf /var/lib/apt/lists/*

COPY start.sh /start.sh
RUN chmod +x /start.sh

# so that all shells have env var
ENV DISPLAY=:1

CMD ["/start.sh"]