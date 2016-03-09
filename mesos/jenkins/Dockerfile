FROM jenkinsci/jenkins
MAINTAINER Jon Brisbin <jbrisbin@basho.com>

USER root

# Set user password 
RUN usermod -G shadow -a -p 4Dm3fH39Geavs jenkins

# Install basic utilities
RUN \
  apt-get update && \
  apt-get install -y apt-transport-https ca-certificates git curl wget

# Apache Mesos
ENV MESOS_VERSION=${MESOS_VERSION:-0.26.0-0.2.145.debian81}
RUN \
  echo "deb http://repos.mesosphere.io/debian/ jessie main" > /etc/apt/sources.list.d/mesos.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
  apt-get update && \
  apt-get install -y mesos=$MESOS_VERSION
ENV \
  MESOS_NATIVE_JAVA_LIBRARY=/usr/lib/libmesos.so \
  MESOS_NATIVE_LIBRARY=/usr/lib/libmesos.so

# Docker
RUN \
  echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list && \
  apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
  apt-get update && \
  apt-get install -y apparmor docker-engine

# Base configuration
USER jenkins

ENV REF_DIR /usr/share/jenkins/ref

COPY defaults.tgz /
RUN tar -zxf /defaults.tgz -C $REF_DIR

#COPY config.xml $REF_DIR/
#COPY credentials.xml $REF_DIR/
#COPY github-plugin-configuration.xml $REF_DIR/
#COPY hudson.tasks.Maven.xml $REF_DIR/
#COPY hudson.tasks.Shell.xml $REF_DIR/
#COPY org.jenkinsci.plugins.docker.commons.tools.DockerTool.xml $REF_DIR/
#COPY org.jenkinsci.plugins.ansible.AnsibleInstallation.xml $REF_DIR/
#COPY org.jvnet.hudson.plugins.SbtPluginBuilder.xml $REF_DIR/
#COPY github-plugin-configuration.xml $REF_DIR/

#COPY tcp-slave-agent-port.groovy $REF_DIR/init.groovy.d/

#RUN mkdir -p $REF_DIR/nodes/mesos-slave
#COPY mesos-slave.xml $REF_DIR/nodes/mesos-slave/config.xml
#RUN mkdir -p $REF_DIR/nodes/spark-slave
#COPY spark-slave.xml $REF_DIR/nodes/spark-slave/config.xml

#RUN mkdir -p $REF_DIR/jobs/connect-mesos-slave
#COPY connect-mesos-slave.xml $REF_DIR/jobs/connect-mesos-slave/config.xml
#RUN mkdir -p $REF_DIR/jobs/disconnect-mesos-slave
#COPY disconnect-mesos-slave.xml $REF_DIR/jobs/disconnect-mesos-slave/config.xml

#RUN mkdir -p $REF_DIR/jobs/connect-spark-slave
#COPY connect-spark-slave.xml $REF_DIR/jobs/connect-spark-slave/config.xml
#RUN mkdir -p $REF_DIR/jobs/disconnect-spark-slave
#COPY disconnect-spark-slave.xml $REF_DIR/jobs/disconnect-spark-slave/config.xml

COPY plugins.txt $REF_DIR/
RUN /usr/local/bin/plugins.sh $REF_DIR/plugins.txt

