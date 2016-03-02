# XEphem Docker
[XEphem](http://www.clearskyinstitute.com/xephem/index.html) is a full-featured astronomy application for all UNIX-like systems including Linux and MacOS X.

## Screenshot


## Usage
  * Install [Docker](https://docs.docker.com/engine/installation/)
  * Pull the container: `docker pull ponsfrilus/dockergui:xephem`
  * Launch the container: `docker run -ti --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix ponsfrilus/dockergui:xephem`

