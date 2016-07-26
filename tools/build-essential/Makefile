UPGRADE			 ?= y
DOCKER 			 ?= y
FPM	  			 ?= y
JAVA 				 ?= y

FROM 				 ?= ubuntu:14.04
MAINTAINER 		= Jon Brisbin <jbrisbin@basho.com>

OS_FAMILY 		= $(shell echo "$(FROM)" | cut -d: -f1;)
OS_VERSION 		= $(shell echo "$(FROM)" | cut -d: -f2;)
OS_TAG 				= $(shell echo "$(FROM)" | sed 's/:/-/g';)

TAG 					= basho/build-essential:$(OS_TAG)

OVERLAY_DIRS 	= $(OS_FAMILY) .
OVERLAYS 			= env env-$(OS_VERSION) build-base build-base-py git-ssh

ifeq (y,$(UPGRADE))
OVERLAYS 		 += upgrade
endif
ifeq (y,$(DOCKER))
OVERLAYS 		 += docker
endif
ifeq (y,$(FPM))
OVERLAYS 		 += fpm
endif
ifeq (y,$(JAVA))
OVERLAYS 		 += jdk-8 maven #sbt
endif

-include ../../docker.mk
