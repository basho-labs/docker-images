### Mesos cluster.
FROM ubuntu:14.04
MAINTAINER Nikolay Khabarov <2xl@mail.ru>

### Environment for mesos.
ENV MESOSPKG_BUILD_VERSION=0.28.2-2.0.27.ubuntu1404
ENV MESOS_LOG_DIR=/var/log/mesos
ENV MESOS_WORK_DIR=/var/lib/mesos

### Environment for zookeeper.
ENV ZK_TICK_TIME=2000
ENV ZK_INIT_LIMIT=5
ENV ZK_SYNC_LIMIT=2
ENV ZK_CLIENT_PORT=2181

### Install mesos and zookeeper.
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
RUN DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]') &&\
    CODENAME=$(lsb_release -cs) &&\
    echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" | sudo tee /etc/apt/sources.list.d/mesosphere.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install zookeeperd mesos=${MESOSPKG_BUILD_VERSION}
RUN apt-mark hold mesos

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

