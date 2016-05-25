TARGET_OS ?= ubuntu:14.04
JAVA ?= 8

OS_FAMILY = $(shell echo "$(TARGET_OS)" | cut -d: -f1;)
OS_VERSION = $(shell echo "$(TARGET_OS)" | cut -d: -f2;)
OS_TAG = $(shell echo "$(TARGET_OS)" | sed 's/:/-/g';)

FROM = $(TARGET_OS)
MAINTAINER = Jon Brisbin <jbrisbin@basho.com>
TAG = basho/build-essential:$(OS_TAG)

OVERLAYS_DIR = $(OS_FAMILY)
OVERLAYS = env-$(OS_VERSION) build-essential git-ssh docker

ifneq (0,$(JAVA))
OVERLAYS += jdk-$(JAVA) maven sbt
endif

-include ../../docker.mk
