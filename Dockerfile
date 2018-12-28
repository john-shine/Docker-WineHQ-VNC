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
ARG vnc_password=""
EXPOSE 5901

RUN useradd -g ${GGID} -u ${UUID} -m -r -d ${HOME} -s /bin/bash ${USER}
RUN echo "${USER}:${USER}" | chpasswd

RUN sudo dpkg --add-architecture i386 

RUN apt update && apt install -y wget sudo && \
    wget -nc -qO- https://dl.winehq.org/wine-builds/winehq.key | apt-key add - && \
    apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main' && \
    apt update && \
    apt install --install-recommends winehq-staging

RUN echo -e "\n${USER}        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

USER ${USER}

RUN touch ${HOME}/.vnc/passwd ${HOME}/.Xauthority
