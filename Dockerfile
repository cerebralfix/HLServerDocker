# A docker for a floating licenses for HeadusUV https://www.uvlayout.com/
# HLServer Support: https://www.uvlayout.com/support/hlserver/
# HLServer Docker Git: https://github.com/cerebralfix/HLServerDocker/pkgs/container/hlserver
# Container Registery: https://ghcr.io/cerebralfix/hlserver:latest
# Add license file - add as volume mount to here: /usr/local/hlserver/hlmanager-license.txt

# Linux Base
FROM debian:latest

# Set a Directory for the app
WORKDIR /usr/local

# download the server tgz
ADD https://www.uvlayout.com/files/hlserver/lin/hlserver-f13-v2.11.tgz hlserver.tgz

# extract the server then remove the archive.
RUN tar xvzfo hlserver.tgz \
    &&  rm hlserver.tgz

# Inside extracted folder
WORKDIR /usr/local/hlserver
# Add Launch Script
ADD LaunchHLServer.sh ./

EXPOSE 11668

# Launch the server.
CMD [ "/usr/local/hlserver/LaunchHLServer.sh" ]
