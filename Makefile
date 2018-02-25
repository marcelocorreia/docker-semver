REPOSITORY=docker-semver
CONTAINER=semver
GITHUB_USER=marcelocorreia
VERSION=$(shell $(MAKE) get-version)
DOCKER_GITHUB_RELEASE := socialengine/github-release
PIPELINE_NAME=$(REPOSITORY)-release
CI_TARGET=dev
GITHUB_NAMESPACE := github.com/$(GITHUB_USER)
GITHUB_TOKEN ?=
PROJECT_PATH := $(GOPATH)/src/$(GO_NAMESPACE)/$(APP_NAME)

ifdef GITHUB_TOKEN
TOKEN_FLAG := -H "Authorization: token $(GITHUB_TOKEN)"
endif


.PHONY: default
default: get-version

get-version:
	@OUT=$(shell curl -s $(TOKEN_FLAG) https://api.github.com/repos/npm/node-semver/tags | jq ".[]|.name" | head -n1 | sed 's/\"//g' | sed 's/v*//g') && \
	echo $${OUT}

git-push:
	git add .; git commit -m "Pipeline WIP"; git push

docker-build:
	cat Dockerfile | sed  's/ARG version=".*"/ARG version="$(VERSION)"/' > /tmp/Dockerfile.tmp
	cat /tmp/Dockerfile.tmp > Dockerfile
	rm /tmp/Dockerfile.tmp
	docker build -t $(GITHUB_USER)/$(CONTAINER):latest .
	docker build -t $(GITHUB_USER)/$(CONTAINER):$(VERSION) .
.PHONY: build

docker-shell:
	docker run --rm -it $(GITHUB_USER)/$(CONTAINER):latest bash

set-pipeline: git-push
	fly -t $(CI_TARGET) set-pipeline \
		-n -p $(PIPELINE_NAME) \
		-c pipeline.yml \
		-l $(HOME)/.ssh/ci-credentials.yml \
		-v git_repo_url=git@github.com:$(GITHUB_USER)/$(REPOSITORY).git \
        -v container_fullname=$(GITHUB_USER)/$(CONTAINER) \
        -v container_name=$(CONTAINER) \
		-v git_repo=$(REPOSITORY) \
        -v git_branch=master \
        -v release_version=$(VERSION)

	fly -t $(CI_TARGET) unpause-pipeline -p $(PIPELINE_NAME)
	fly -t $(CI_TARGET) trigger-job -j $(PIPELINE_NAME)/$(PIPELINE_NAME)
	fly -t $(CI_TARGET) watch -j $(PIPELINE_NAME)/$(PIPELINE_NAME)
.PHONY: set-pipeline

pipeline-login:
	fly -t dev login -n dev -c https://ci.correia.io

watch-pipeline:
	fly -t $(CI_TARGET) watch -j $(PIPELINE_NAME)/$(PIPELINE_NAME)
.PHONY: watch-pipeline

destroy-pipeline:
	fly -t $(CI_TARGET) destroy-pipeline -p $(PIPELINE_NAME)
.PHONY: destroy-pipeline

docs:
	grip -b

release: _github-info


# Github
_github-release:
	@$(call githubRelease, release, -t "$(VERSION)")
	@git pull --tags

_github-info:
	@$(call githubRelease, info)

_docker-pull-gh:
	docker pull $(DOCKER_GITHUB_RELEASE)


define githubRelease
	echo "Please enter Github Token"
    read GITHUB_TOKEN && \
    echo $$GITHUB_TOKEN
	docker run --rm \
    -v $(shell pwd):$(shell pwd) \
    -w $(shell pwd) \
    $(DOCKER_GITHUB_RELEASE) \
    bash -c "github-release  $1 -s $(GITHUB_TOKEN) -u $(GITHUB_USER) -r $(CONTAINER) $2"
endef
