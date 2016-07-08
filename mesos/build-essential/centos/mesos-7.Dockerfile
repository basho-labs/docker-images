ARG MESOS_VERSION
RUN \
  rpm -Uvh http://repos.mesosphere.io/el/$OS_VERSION/noarch/RPMS/mesosphere-el-repo-$OS_VERSION-3.noarch.rpm && \
  yum install -q -y mesos-$MESOS_VERSION
