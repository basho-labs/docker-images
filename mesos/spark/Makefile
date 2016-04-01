FROM = ubuntu:14.04
MAINTAINER = Jon Brisbin <jbrisbin@basho.com>
TAG ?= basho/spark

#DOCKER_BUILD_OPTS += --build-arg=MESOS_VERSION=0.26.0-0.2.145.ubuntu1404

OVERLAYS = base jdk-8 mesos spark

-include ../../docker.mk
