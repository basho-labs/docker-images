TARGET_OS      ?= ubuntu-14.04

FROM            = basho/build-essential:$(TARGET_OS)
MAINTAINER      = Jon Brisbin <jbrisbin@basho.com>
TAG            ?= basho/build-essential-mesos:$(TARGET_OS)

OVERLAY_DIRS    = $(shell echo "$(TARGET_OS)" | cut -d- -f1) .
OVERLAYS        = mesos

all:
	@for os in debian-8 centos-7 ubuntu-14.04; do \
	  TARGET_OS=$$os $(MAKE) clean install; \
	done

include ../../docker.mk
