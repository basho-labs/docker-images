TARGET_OS ?= ubuntu:14.04
JAVA ?= 8
MESOS ?= 0.27.2

OS_FAMILY = $(shell echo "$(TARGET_OS)" | cut -d: -f1;)
OS_VERSION = $(shell echo "$(TARGET_OS)" | cut -d: -f2;)
OS_TAG = $(shell echo "$(TARGET_OS)" | sed 's/:/-/g';)

FROM = $(TARGET_OS)
MAINTAINER = Jon Brisbin <jbrisbin@basho.com>
TAG = basho/build-essential:$(OS_TAG)

OVERLAYS_DIR = $(OS_FAMILY)
OVERLAYS = build-essential

ifneq (0,$(JAVA))
OVERLAYS += jdk-$(JAVA)
endif

ifneq (0,$(MESOS))
OVERLAYS += mesos-$(OS_VERSION)
DOCKER_BUILD_OPTS += --build-arg=MESOS_VERSION=$(MESOS)
endif

-include ../../docker.mk

