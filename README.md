<!-- Auto generated file, DO NOT EDIT. Please refer to README.yml -->
# docker-semver

---
![https://img.shields.io/docker/pulls/marcelocorreia/terraform.svg](https://img.shields.io/docker/pulls/marcelocorreia/terraform.svg)
![https://img.shields.io/github/languages/top/marcelocorreia/docker-terraform.svg](https://img.shields.io/github/languages/top/marcelocorreia/docker-terraform.svg)
![https://api.travis-ci.org/marcelocorreia/docker-terraform.svg?branch=master](https://api.travis-ci.org/marcelocorreia/docker-terraform.svg?branch=master)
![https://img.shields.io/github/release/marcelocorreia/docker-terraform.svg?flat-square](https://img.shields.io/github/release/marcelocorreia/docker-terraform.svg?flat-square)
---
### TLDR;
- [Overview](#overview)
- [Description](#description)
- [Dockerfile](#dockerfile)
- [Usage](#usage)
- [Setting Timezone](#setting-timezone)
- [License](#license)
- **Semver versioning**
### Overview
Docker image with [Node semver](https://github.com/semver/semver)


### Description
Docker image with [Node semver](https://github.com/semver/semver)

## INFO
- Workdir is set to /app




### Usage
```bash
$> docker run --rm marcelocorreia/semver server -c -i minor VERSION

```
## Example
```bash
$> docker run --rm marcelocorreia/semver server -c -i minor 1.1.0
$> docker run --rm marcelocorreia/semver server -c -i minor $(git describe --tags --abbrev=0)
```




## Dockerfile 
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


### License
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Copyright [2015]

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.


---
[:hammer:**Created with a Hammer**:hammer:](https://github.com/marcelocorreia/hammer)
<!-- -->
















