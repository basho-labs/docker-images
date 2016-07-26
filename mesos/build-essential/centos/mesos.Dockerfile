RUN \
  rpm -Uvh http://repos.mesosphere.com/el-testing/7/noarch/RPMS/mesosphere-el-repo-7-3.noarch.rpm && \
  yum install -q -y mesos
