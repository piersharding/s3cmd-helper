# This Makefile describes a set of common tasks for managing the
# build environment and integrating with the CI/CD pipeline for the
#
# type: `make` to list the available commands.
#

ALPINE_BASE_IMAGE ?= alpine:3.8
TAG ?= $(shell echo $(ALPINE_BASE_IMAGE) | sed 's/\://')
IMAGE ?= piersharding/s3cmd

#
# Defines a default make target so that help is printed if make is called
# without a target
#
.DEFAULT_GOAL := help

.PHONY: build push clean help

help:  ## show this help.
	@echo "$(MAKE) targets:"
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ": .*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo ""; echo "make vars (+defaults):"
	@grep -E '^[0-9a-zA-Z_-]+ \?=.*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = " \\?\\= | ## "}; {printf "\033[36m%-30s\033[0m %-20s %-30s\n", $$1, $$2, $$3}'

build:
	cd build && \
	docker build \
	  --build-arg ALPINE_BASE_IMAGE=$(ALPINE_BASE_IMAGE) \
	  -t s3cmd:latest -f Dockerfile .

push: build
	docker tag s3cmd:latest $(IMAGE):$(TAG)
	docker push $(IMAGE):$(TAG)
	docker tag s3cmd:latest $(IMAGE):latest
	docker push $(IMAGE):latest
