# http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/
# http://www.clearskyinstitute.com/xephem/
# docker build -t ponsfrilus/dockergui:xephem .
# docker run -ti --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix ponsfrilus/dockergui:xephem
# docker run -ti --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix ponsfrilus/dockergui:xephem /bin/bash

FROM ubuntu:14.04
MAINTAINER @ponsfrilus

# Avoid dbconf error when building
ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /home/developer/.xephem
WORKDIR /home/developer

RUN apt-get update
RUN apt-get install -y wget make gcc \
                    libxt-dev libxp-dev libxmu-dev libmotif-dev \
                    x11proto-print-dev \
                    groff \
                    libxbae4m \
                    firefox libcanberra-gtk-module
RUN apt-get clean autoclean autoremove

RUN wget -O /home/developer/xephem-3.7.7.tar.gz http://97.74.56.125/free/xephem-3.7.7.tar.gz
RUN tar zxvf xephem-3.7.7.tar.gz 
RUN cd /home/developer/xephem-3.7.7/GUI/xephem
WORKDIR /home/developer/xephem-3.7.7/GUI/xephem
RUN make MOTIF=../../libXm/linux86 
RUN cp xephem /usr/bin

RUN echo "XEphem.ShareDir: /home/developer/xephem-3.7.7/GUI/xephem" > /home/developer/.xephem/XEphem
RUN echo "XEphem*SaveRes*AutoSave.set:                 True" >> /home/developer/.xephem/XEphem



# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

USER developer
ENV HOME /home/developer

CMD ["/usr/bin/xephem"]
