# https://brave.com/
# docker build -t ponsfrilus/dockergui:brave .
# docker run -ti --rm -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix ponsfrilus/dockergui:brave

FROM ubuntu:16.04
MAINTAINER @ponsfrilus

RUN apt update
RUN apt install -y wget git gconf2 gconf-service gvfs-bin libgtk2.0 libnotify4 libnss3 libxtst6 libxss-dev python xdg-utils libasound2 libgnome-keyring0
RUN wget -O brave.deb https://laptop-updates.brave.com/latest/dev/ubuntu64
RUN dpkg -i ./brave.deb
RUN apt clean autoclean autoremove

RUN useradd -ms /bin/bash developer
RUN usermod -aG sudo developer
USER developer

WORKDIR /home/developer

CMD ["brave"]
