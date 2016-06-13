FROM jenkinsci/jenkins:2.7
MAINTAINER Jon Brisbin <jbrisbin@basho.com>

USER root

# Set user password
RUN usermod -G shadow -a -p 4Dm3fH39Geavs jenkins

# Configure SSH 
RUN echo "StrictHostKeyChecking no" >>/etc/ssh/ssh_config
RUN echo "UserKnownHostsFile /dev/null" >>/etc/ssh/ssh_config

# Set up an ansible inventory based on Marathon
RUN mkdir -p /etc/ansible
COPY mesos-inventory.py /etc/ansible/hosts
RUN chmod +x /etc/ansible/hosts
ENV \
  GROUP=mesos

  # Install basic utilities
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y openssl apt-transport-https ca-certificates git curl wget vim python-setuptools python-pip
RUN apt-get install -y libssl-dev python-dev libffi-dev
RUN pip install --upgrade pip
RUN pip install --upgrade cffi
RUN pip install --upgrade pyopenssl
RUN pip install ansible

# Install apt repos
RUN echo "deb https://apt.dockerproject.org/repo debian-jessie main" >/etc/apt/sources.list.d/docker.list
RUN echo "deb http://repos.mesosphere.io/debian/ jessie main" >/etc/apt/sources.list.d/mesos.list

# Install Keys
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv E56151BF
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv 2C52609D

RUN apt-key update -y
RUN apt-get update -y

# Install Apache Mesos
RUN apt-get install -y mesos
ENV \
  MESOS_NATIVE_JAVA_LIBRARY=/usr/lib/libmesos.so \
  MESOS_NATIVE_LIBRARY=/usr/lib/libmesos.so

# Install Docker
RUN apt-get install -y docker-engine

# Clean up
RUN rm -Rf /var/lib/apt/*

# Add default jobs, config
COPY connect-slave.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/connect-slave.sh

ENV REF_DIR /usr/share/jenkins/ref
ADD defaults.tgz $REF_DIR
COPY plugins.txt $REF_DIR/

RUN chown -R jenkins $REF_DIR
USER jenkins

# Install plugins
RUN /usr/local/bin/plugins.sh $REF_DIR/plugins.txt
