#!/bin/sh

apk add \
    curl \
    ca-certificates \
    openssl \
    openssh \
    git \
    tzdata \
    openntpd \
    supervisor

# supervisor default conf
cp /docker/configs/supervisord.conf /etc/supervisord.conf
