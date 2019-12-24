FROM jenkins/jnlp-slave:latest
MAINTAINER aeternus <aeternus@aliyun.com>

LABEL Description="Add docker-ce-cli"

ARG user=jenkins

## install docker-ce-cli
USER root
RUN set -ex \
  ## install dependencies
  && dep_pkgs="apt-transport-https ca-certificates curl gnupg2 software-properties-common" \
  && apt-get update \
  && apt-get install -y $dep_pkgs \
  && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
  ## add repo
  && add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
  ## install docker-ce-cli
  && apt-get update \
  && apt-get install -y docker-ce-cli \
  ## clean
  && apt-get remove $dep_pkgs \
  && apt-get autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

USER ${user}
