#
# LinuxGSM Base Dockerfile
#
# https://github.com/GameServerManagers/LinuxGSM-Docker
#

FROM ubuntu:20.04

LABEL maintainer="LinuxGSM <me@danielgibbs.co.uk>"

ENV DEBIAN_FRONTEND noninteractive
SHELL ["/bin/bash", "-o", "pipefail", "-c"]


RUN apt-get update \
    && apt upgrade -y \
    && apt-get install -y \
    curl \
    wget \
    file \
    unzip \
    cpio \
    bsdmainutils \
    python3 \
    ca-certificates \
    binutils \
    bc \
    jq \
    tmux \
    netcat \
    lib32gcc1 \
    lib32stdc++6 \
    iproute2 \
    xz-utils \
    vim \

# Install SteamCMD
&& echo steam steam/question select "I AGREE" | debconf-set-selections \
&& echo steam steam/license note '' | debconf-set-selections \
&& dpkg --add-architecture i386 \
&& apt-get update -y \
&& apt-get install -y --no-install-recommends steamcmd libsdl2-2.0-0:i386 \

# Cleanup
&& apt-get -y autoremove \
&& apt-get -y clean \
&& rm -rf /var/lib/apt/lists/* \
&& rm -rf /tmp/* \
&& rm -rf /var/tmp/*

## user config
RUN adduser \
--disabled-login \
--disabled-password \
--shell /bin/bash \
--gecos "" \
linuxgsm \
&& chown -R linuxgsm:linuxgsm /home/linuxgsm \

## linuxgsm.sh
RUN set -ex; \
mkdir /opt/linuxgsm; \
chown linuxgsm:linuxgsm /opt/linuxgsm; \
wget -O /opt/linuxgsm/linuxgsm.sh https://raw.githubusercontent.com/GameServerManagers/LinuxGSM/master/linuxgsm.sh; \
chmod +x /opt/linuxgsm/linuxgsm.sh

USER linuxgsm

WORKDIR /home/linuxgsm

VOLUME [ "/home/linuxgsm" ]

# need use xterm for LinuxGSM
ENV TERM=xterm

## Docker Details
ENV PATH=$PATH:/home/linuxgsm

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["bash","/entrypoint.sh" ]
