#!/bin/sh

[ -z "${DISPLAY}" ] || /usr/bin/vncserver -kill ${DISPLAY}
rm -f /tmp/.X*-lock /tmp/.X11-unix/X*
sleep 3
/usr/bin/vncserver -geometry 1920x1080 -fg
