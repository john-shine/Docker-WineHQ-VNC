# Using CentOS 7 base image and VNC

FROM ubuntu:18.04
MAINTAINER john.shine <mr.john.shine@gmail.com>
LABEL io.openshift.expose-services="5901:tcp"

USER root

ENV DISPLAY=":1"
ENV USER="wine"
ENV UUID=1000
ENV GGID=0
ENV HOME=/home/${USER}
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1
ARG vnc_password=""
EXPOSE 5901

RUN useradd -g ${GGID} -u ${UUID} -m -r -d ${HOME} -s /bin/bash ${USER}
RUN echo "${USER}:${USER}" | chpasswd

RUN apt-get update && apt-get install -y sudo wget gnupg2 software-properties-common tightvncserver && \
    dpkg --add-architecture i386 && \
    wget -nc -qO- https://dl.winehq.org/wine-builds/winehq.key | apt-key add - && \
    apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main' && \
    apt-get install -y --install-recommends winehq-staging && \
    rm -rf /var/lib/apt/lists/*

# add sudo permission to ${USER}
RUN echo "\n${USER}        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

USER ${USER}

RUN mkdir -p ${HOME}/.vnc
ADD xstartup ${HOME}/.vnc/
RUN touch ${HOME}/.vnc/passwd ${HOME}/.Xauthority
RUN sudo chown ${UUID}:${GGID} ${HOME}/.vnc/xstartup && sudo chmod 600 ${HOME}/.vnc/passwd

RUN /bin/echo -e "export DISPLAY=${DISPLAY}"  >> ${HOME}/.vnc/xstartup

RUN /bin/echo -e "[ -r ${HOME}/.Xresources ] && xrdb ${HOME}/.Xresources\nxsetroot -solid grey"  >> ${HOME}/.vnc/xstartup
