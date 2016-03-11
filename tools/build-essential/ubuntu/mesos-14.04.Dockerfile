
# Install Apache Mesos
ARG MESOS_VERSION
RUN \
  echo "deb http://repos.mesosphere.io/ubuntu/ trusty main" > /etc/apt/sources.list.d/mesos.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
  apt-get update && \
  apt-get install -y mesos=$MESOS_VERSION
ENV \
  MESOS_NATIVE_JAVA_LIBRARY=/usr/lib/libmesos.so \
