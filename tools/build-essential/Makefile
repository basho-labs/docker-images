BUILD_BASE    ?= y
UPGRADE       ?= y
DOCKER        ?= y
FPM           ?= y
JAVA          ?= y

FROM          ?= ubuntu:14.04
MAINTAINER     = Jon Brisbin <jbrisbin@basho.com>

OS_FAMILY      = $(shell echo "$(FROM)" | cut -d: -f1)
OS_VERSION     = $(shell echo "$(FROM)" | cut -d: -f2)
OS_TAG         = $(shell echo "$(FROM)" | tr : -)

TAG            = basho/build-essential:$(OS_TAG)

OVERLAY_DIRS   = $(OS_FAMILY) .
OVERLAYS       = env env-$(OS_VERSION)

ifeq (y,$(BUILD_BASE))
OVERLAYS      += build-base build-base-py git-ssh
endif
ifeq (y,$(DOCKER))
OVERLAYS      += docker
endif
ifeq (y,$(FPM))
OVERLAYS      += fpm
endif
ifeq (y,$(JAVA))
OVERLAYS      += jdk-8 maven sbt
endif
ifeq (y,$(UPGRADE))
OVERLAYS      += upgrade
endif

-include ../../docker.mk
