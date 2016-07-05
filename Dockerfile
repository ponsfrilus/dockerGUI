# https://brave.com/
# docker build -t ponsfrilus/dockergui:brave .
# docker run -ti --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix ponsfrilus/dockergui:brave
# docker run -ti --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix ponsfrilus/dockergui:brave /bin/bash

FROM ubuntu:16.04
MAINTAINER @ponsfrilus


# Avoid dbconf error when building
ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /home/developer
WORKDIR /home/developer

RUN apt update
RUN apt install -y wget
RUN apt install -y git
RUN apt install -y gconf2 gconf-service
RUN apt install -y gvfs-bin
RUN apt install -y libgtk2.0
RUN apt install -y libnotify4
RUN apt install -y libnss3 libxtst6 libxss-dev
RUN apt install -y python
RUN apt install -y xdg-utils
RUN apt install -y libasound2
RUN wget -O brave.deb https://laptop-updates.brave.com/latest/dev/ubuntu64
RUN dpkg -i ./brave.deb

CMD ["brave"]
