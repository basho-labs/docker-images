TARGET_OS         ?= ubuntu-14.04

TAG               ?= basho/spark:$(TARGET_OS)
FROM               = basho/build-essential-mesos:$(TARGET_OS)
MAINTAINER         = Jon Brisbin <jbrisbin@basho.com>

OVERLAYS = spark

-include ../../docker.mk
