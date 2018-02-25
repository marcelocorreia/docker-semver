# marcelocorreia/semver

Docker image with [Node semver](https://github.com/semver/semver)

##### Github [https://github.com/marcelocorreia/docker-semver](https://github.com/marcelocorreia/docker-semver)
 
### Dockerfile
```Dockerfile
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
```
## INFO
- Github: [https://github.com/marcelocorreia/docker-semver](https://github.com/marcelocorreia/docker-semver)


## Usage
```bash
$> docker run --rm marcelocorreia/semver server -c -i minor VERSION
    
```
## Example
```bash
$> docker run --rm marcelocorreia/semver server -c -i minor 1.1.0
$> docker run --rm marcelocorreia/semver server -c -i minor $(git describe --tags --abbrev=0)
```


