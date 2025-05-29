FROM osrf/ros:jazzy-desktop-full

# installs
RUN apt-get update && apt-get install -y xvfb net-tools
RUN apt-get update && apt-get install -y x11vnc


COPY start.sh /start.sh
RUN chmod +x /start.sh

ENV DISPLAY=:1

CMD ["/start.sh"]