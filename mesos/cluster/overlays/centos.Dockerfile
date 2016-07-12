### Mesos cluster.
FROM centos:centos7
MAINTAINER Nikolay Khabarov <2xl@mail.ru>

### Environment for mesos.
ENV MESOSPKG_BUILD_VERSION=0.28.2
ENV MESOS_LOG_DIR=/var/log/mesos
ENV MESOS_WORK_DIR=/var/lib/mesos

### Environment for zookeeper.
ENV ZK_TICK_TIME=2000
ENV ZK_INIT_LIMIT=5
ENV ZK_SYNC_LIMIT=2
ENV ZK_CLIENT_PORT=2181

### Install mesos and zookeeper.
RUN OS_VERSION=$(rpm -q --queryformat '%{VERSION}' centos-release) && \
    rpm -Uvh http://repos.mesosphere.io/el/${OS_VERSION}/noarch/RPMS/mesosphere-el-repo-${OS_VERSION}-1.noarch.rpm && \
    yum install -q -y mesosphere-zookeeper mesos-${MESOSPKG_BUILD_VERSION}

# Install ifconfig
RUN yum install -q -y net-tools

### Create symlinks for compability
RUN ln -s /opt/mesosphere/zookeeper /usr/share/zookeeper

### Copy start scripts.
RUN mkdir -p /opt
COPY start_mesos_master.sh /opt
RUN chmod a+x /opt/start_mesos_master.sh
COPY start_mesos_slave.sh /opt
RUN chmod a+x /opt/start_mesos_slave.sh
COPY start_zk.sh /opt
RUN chmod a+x /opt/start_zk.sh
COPY start.sh /opt
RUN chmod a+x /opt/start.sh

CMD /opt/start.sh

