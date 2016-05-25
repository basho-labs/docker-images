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
  APP_ID='.*' \
  GROUP=mesos

  # Install basic utilities
RUN apt-get update
RUN apt-get install -y openssl apt-transport-https ca-certificates git curl wget vim python-pip
RUN apt-get install -y libssl-dev python-dev python-setuptools libffi-dev
RUN pip install --upgrade pip
RUN pip install --upgrade pyopenssl
RUN pip install ansible
RUN apt-get dist-upgrade -y

# Install Keys
RUN apt-key adv --keyserver p80.pool.sks-keyservers.net --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF

# Install apt repos
RUN echo "deb https://apt.dockerproject.org/repo debian-jessie main" >/etc/apt/sources.list.d/docker.list
RUN echo "deb http://repos.mesosphere.io/debian/ jessie main" >/etc/apt/sources.list.d/mesos.list

RUN apt-get update

# Install Apache Mesos
ARG MESOS_VERSION=0.26.1-2.0.19.debian81
RUN apt-get install -y mesos=$MESOS_VERSION
ENV \
  MESOS_NATIVE_JAVA_LIBRARY=/usr/lib/libmesos.so \
  MESOS_NATIVE_LIBRARY=/usr/lib/libmesos.so

# Install Docker
RUN apt-get install -y docker-engine

RUN rm -Rf /var/lib/apt/*

USER jenkins
ENV REF_DIR /usr/share/jenkins/ref

COPY defaults.tgz /
RUN tar -zxf /defaults.tgz -C $REF_DIR

COPY plugins.txt $REF_DIR/
RUN /usr/local/bin/plugins.sh $REF_DIR/plugins.txt
