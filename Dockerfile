FROM osrf/ros:jazzy-desktop-full

# installs
RUN apt-get update --fix-missing && apt-get -o Acquire::Retries=5 install -y --no-install-recommends \
    xfce4 xfce4-goodies \
    dbus-x11 x11-xserver-utils libgl1 libgl1-mesa-dri net-tools \
    xvfb x11vnc \
    && rm -rf /var/lib/apt/lists/*


COPY start.sh /start.sh
RUN chmod +x /start.sh

ENV DISPLAY=:1

CMD ["/start.sh"]