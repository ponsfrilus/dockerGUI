# http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/
# docker build -t ponsfrilus/dockergui:atom .
# docker run -ti --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix ponsfrilus/dockergui:atom
# docker run -ti --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix ponsfrilus/dockergui:atom /bin/bash

FROM ubuntu:14.04
MAINTAINER @ponsfrilus

RUN mkdir -p /home/developer
WORKDIR /home/developer

RUN apt-get update
RUN apt-get install -y curl wget firefox libcanberra-gtk-module
RUN wget -O /home/developer/atom-amd64.deb $(curl -s https://api.github.com/repos/atom/atom/releases/latest | grep browser_download_url | grep atom-amd64.deb | cut -d '"' -f 4)
RUN dpkg --install atom-amd64.deb || true
RUN apt-get --yes --fix-broken install

# Use apm search <packages>
RUN apm install minimap color-picker pigments emmet atom-beautify \
                file-icons git-plus open-recent xkcd-comics \
                auto-detect-indentation

RUN apt-get clean autoclean autoremove
# Save 68Mo
RUN rm -f /home/developer/atom-amd64.deb

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

USER developer
ENV HOME /home/developer

CMD ["/usr/bin/atom", "-f", "/home/developer"]
