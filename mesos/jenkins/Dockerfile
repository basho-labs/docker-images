FROM jenkinsci/jenkins
MAINTAINER Jon Brisbin <jbrisbin@basho.com>

USER root

# Set user password
RUN usermod -G shadow -a -p 4Dm3fH39Geavs jenkins

# Configure SSH for no prompts
RUN echo "StrictHostKeyChecking no" >>/etc/ssh/ssh_config

# Set up an ansible inventory based on Marathon
RUN mkdir -p /etc/ansible
COPY marathon-inventory.py /etc/ansible/hosts
RUN chmod +x /etc/ansible/hosts
ENV \
  MARATHON_URL=http://marathon.mesos:8080 \
  APP_ID='^/jenkins-[\w]+-slave-[1-9]+' \
  GROUP=mesos

# Install basic utilities
RUN \
  apt-get update && \
  apt-get install -y apt-transport-https ca-certificates git curl wget vim python-pip python-dev && \
  pip install --upgrade pip && \
  pip install ansible

# Install Apache Mesos
ARG MESOS_VERSION=0.26.0-0.2.145.debian81
RUN \
  echo "deb http://repos.mesosphere.io/debian/ jessie main" > /etc/apt/sources.list.d/mesos.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
  apt-get update && \
  apt-get install -y mesos=$MESOS_VERSION
ENV \
  MESOS_NATIVE_JAVA_LIBRARY=/usr/lib/libmesos.so \
  MESOS_NATIVE_LIBRARY=/usr/lib/libmesos.so

RUN rm -Rf /var/lib/apt/*

USER jenkins
ENV REF_DIR /usr/share/jenkins/ref

COPY defaults.tgz /
RUN tar -zxf /defaults.tgz -C $REF_DIR

COPY plugins.txt $REF_DIR/
RUN /usr/local/bin/plugins.sh $REF_DIR/plugins.txt
