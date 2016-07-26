# Install Apache Mesos
RUN \
  echo "deb http://repos.mesosphere.io/debian/ jessie main" > /etc/apt/sources.list.d/mesos.list && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E56151BF && \
  apt-get update && \
  apt-get install -y mesos
ENV \
  MESOS_NATIVE_JAVA_LIBRARY=/usr/lib/libmesos.so \
  MESOS_NATIVE_LIBRARY=/usr/lib/libmesos.so
