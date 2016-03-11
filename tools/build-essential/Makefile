TARGET_OS ?= ubuntu:14.04
JAVA ?= 8

FROM = $(TARGET_OS)
MAINTAINER = Jon Brisbin <jbrisbin@basho.com>
TAG = basho/build-essential:$(shell echo "$(TARGET_OS)" | sed 's/:/-/g';)

OVERLAYS_DIR = $(shell echo "$(TARGET_OS)" | cut -d: -f1;)
OVERLAYS = build-essential

ifneq (0,$(JAVA))
OVERLAYS += jdk-$(JAVA)
endif

-include ../../docker.mk
