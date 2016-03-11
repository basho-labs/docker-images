ARG MESOS_VERSION
RUN \
  rpm -Uvh http://repos.mesosphere.io/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm && \
  yum install -q -y mesos-$MESOS_VERSION
