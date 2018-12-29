#!/bin/sh

# kill old vnc session
[ -z "${DISPLAY}" ] || /usr/bin/vncserver -kill ${DISPLAY}
find /tmp -maxdepth 1 -name ".X*-lock" -type f -exec rm -f {} \;
if [[ -d /tmp/.X11-unix ]]; then
    find /tmp/.X11-unix -maxdepth 1 -name 'X*' -type s -exec rm -f {} \;
fi

sleep 1

# set new vnc password to ARG
if [ -f ${HOME}/.vnc/passwd ]; then
    echo "${vnc_password}" | vncpasswd -f > ${HOME}/.vnc/passwd
fi

# start vnc server
/usr/bin/vncserver -geometry 1920x1080

tail -f /dev/null