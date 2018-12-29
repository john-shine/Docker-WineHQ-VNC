# Docker-WineHQ-VNC
A docker for run Wine though VNC remote manage

## Quick start

Begin, pull image from Docker hub:

`sudo docker pull johnshine/winehq-vnc:latest`

After, run image with following code (replace variable with actual value):

`sudo docker run -d -p ${VNC_PORT}:5901 -e vnc_password=${YOUR_VNC_PASSWORD} johnshine/winehq-vnc:latest`

The last, connect && view vnc server with your vnc clients, at ${your_docker_host_ip}:${VNC_PORT}. 

If vnc_password argument not specified, no password should input, just type enter. Otherwise, connect with ${YOUR_VNC_PASSWORD}.

Anothor, [CrossOver VNC](https://github.com/john-shine/Docker-CodeWeavers_CrossOver-VNC) (Non-free solution): better stability, more convenient && timesaver

## VNC clients recommend

1. [VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/windows/)
2. [jump desktop](https://jumpdesktop.com/)
3. [TightVNC](https://github.com/TigerVNC/tigervnc/releases)
