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
OVERLAYS = env-$(OS_VERSION) build-essential git-ssh docker

ifneq (0,$(JAVA))
OVERLAYS += jdk-$(JAVA) maven
endif

ifneq (0,$(MESOS))
mesos_version_ubuntu_0.26 = 0.26.0-0.2.145.ubuntu1404
mesos_version_ubuntu_0.27 = 0.27.1-2.0.226.ubuntu1404
mesos_version_centos_0.26 = 0.26.0
mesos_version_centos_0.27 = 0.27.2
MESOS_MAJOR_VERSION = $(shell echo "$(MESOS)" | cut -d\. -f1,2)

OVERLAYS += mesos
DOCKER_BUILD_OPTS += --build-arg=MESOS_VERSION=$(mesos_version_$(OS_FAMILY)_$(MESOS_MAJOR_VERSION))
endif

-include ../../docker.mk
