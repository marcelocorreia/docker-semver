FROM node:alpine
MAINTAINER marcelo correia <marcelo@correia.io>
RUN apk update
RUN apk upgrade
RUN apk add ca-certificates && update-ca-certificates
RUN apk add --no-cache --update \
    curl \
    unzip \
    bash \
    python \
    py-pip \
    git \
    openssh \
    make \
    jq \
    tzdata \
    sudo

RUN rm /var/cache/apk/*

RUN npm install semver -g
