FROM          ?= ubuntu:14.04
MAINTAINER     = Jon Brisbin <jbrisbin@basho.com>

OS_FAMILY      = $(shell echo "$(FROM)" | cut -d: -f1)
OS_VERSION     = $(shell echo "$(FROM)" | cut -d: -f2)
OS_TAG         = $(shell echo "$(FROM)" | tr : -)

TAG            = basho/erlang:$(OS_TAG)

DOCKER_BUILD_OPTS = --build-arg OS_TAG=$(OS_TAG)

OVERLAY_DIRS   = $(OS_FAMILY) .
OVERLAYS       = base erlang

-include ../../docker.mk
