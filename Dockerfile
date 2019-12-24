FROM jenkins/jnlp-slave:alpine
MAINTAINER aeternus <aeternus@aliyun.com>

LABEL Description="Install docker-ce-cli"

ARG user=jenkins

## install docker-ce-cli
USER root
RUN set -ex \
  \
  ## add repo
  && echo "http://dl-cdn.alpinelinux.org/alpine/latest-stable/community" >>/etc/apk/repositories \
  \
  ## install docker-cli
  && apk add --no-cache docker-cli \
  \
  ## cleanup
  && && rm -rf /tmp/*

USER ${user}
