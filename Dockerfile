FROM jenkins/jnlp-slave:latest
MAINTAINER aeternus <aeternus@aliyun.com>

LABEL Description="Add docker-ce-cli"

ARG user=jenkins

## install docker-ce-cli
USER root
RUN set -ex \
  && apt-get update \
  && apt-get install -y \
       apt-transport-https \
       ca-certificates \
       curl \
       gnupg2 \
       software-properties-common \
  && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
  && add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
  && apt-get update \
  && apt-get install -y docker-ce-cli \
  && rm -rf /var/lib/apt/lists/*

USER ${user}
