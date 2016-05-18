OS_FAMILY 			?= ubuntu
OS_VERSION 			?= 14.04
MESOS_VERSION 	?= 0.28

mesos_version_ubuntu_0.26 = 0.26.0-0.2.145.$(OS_FAMILY)$(shell echo "$(OS_VERSION)" | tr -d '.')
mesos_version_ubuntu_0.27 = 0.27.1-2.0.226.$(OS_FAMILY)$(shell echo "$(OS_VERSION)" | tr -d '.')
mesos_version_ubuntu_0.28 = 0.28.1-2.0.20.$(OS_FAMILY)$(shell echo "$(OS_VERSION)" | tr -d '.')
mesos_version_centos_0.26 = 0.26.0
mesos_version_centos_0.27 = 0.27.2
mesos_version_centos_0.28 = 0.28.1
MESOS_MAJOR_VERSION 			= $(shell echo "$(MESOS_VERSION)" | cut -d\. -f1,2)

FROM 				 = basho/build-essential:$(OS_FAMILY)-$(OS_VERSION)
MAINTAINER 	 = Jon Brisbin <jbrisbin@basho.com>
TAG 				?= basho/build-essential-mesos:$(OS_FAMILY)-$(OS_VERSION)-$(MESOS_MAJOR_VERSION)

DOCKER_BUILD_OPTS += --build-arg=MESOS_VERSION=$(mesos_version_$(OS_FAMILY)_$(MESOS_MAJOR_VERSION))

OVERLAYS_DIR 	= $(OS_FAMILY)
OVERLAYS 			= mesos-$(OS_VERSION)

-include ../../docker.mk
