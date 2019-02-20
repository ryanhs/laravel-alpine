FROM alpine:3.8
MAINTAINER ryanhs <mr.ryansilalahi@gmail.com>

# copy needed scripts to containers
ADD . /docker
RUN chmod -R +x /docker

# installations
RUN /docker/installations/prepare.sh \
    && /docker/installations/basic.sh \
    && /docker/installations/apache.sh \
    && /docker/installations/php.sh \
    && /docker/installations/cleanup.sh

# expose ports
EXPOSE 80

# run bootstrap/start
ENTRYPOINT ["/docker/start.sh"]
