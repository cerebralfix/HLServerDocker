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

# Add license file - add as volume mount to here: /usr/local/hlserver
#ADD hlmanager-license.txt ./

ADD GenerateLicenseID.sh ./
RUN ./GenerateLicenseID.sh

EXPOSE 11668

ENV HEADUS_HOME=/usr/local/hlserver
ENV HLBIN=$HEADUS_HOME/hlserver
ENV HLCONF=$HEADUS_HOME/hlserver.conf
ENV HLLOG_NUM=2
ENV HLLOG_DAYS=7
ENV HLLOG_NAME=$HEADUS_HOME/hlserver-%d.log

CMD [ "$HLBIN -c,$HLCONF -l,$HLLOG_NUM,$HLLOG_DAYS,$HLLOG_NAME" ]