# http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/
# docker build -t ponsfrilus/dockergui:firefox .
# docker run -ti --rm -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix ponsfrilus/dockergui:firefox
FROM ubuntu:16.04
MAINTAINER @ponsfrilus
RUN apt-get update
RUN apt-get install -y firefox
RUN apt-get clean autoclean autoremove
RUN useradd -ms /bin/bash developer
RUN usermod -aG sudo developer
USER developer
#ENV HOME /home/developer
WORKDIR /home/developer
CMD /usr/bin/firefox --no-remote --private
