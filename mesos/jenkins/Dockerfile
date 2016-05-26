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
RUN apt-get install -y openssl apt-transport-https ca-certificates git curl wget vim python-setuptools python-pip
RUN apt-get install -y libssl-dev python-dev libffi-dev
RUN pip install --upgrade pip
RUN pip install --upgrade pyopenssl
RUN pip install ansible
RUN apt-get dist-upgrade -y

# Install Keys
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# Install apt repos
RUN echo "deb https://apt.dockerproject.org/repo debian-jessie main" >/etc/apt/sources.list.d/docker.list

RUN apt-get update

# Install Apache Mesos
ADD mesos-0.26.0-debian-8.tgz /usr/lib/mesos
ENV \
  PATH=/usr/lib/mesos/bin:$PATH \
  MESOS_NATIVE_JAVA_LIBRARY=/usr/lib/mesos/lib/libmesos.so \
  MESOS_NATIVE_LIBRARY=/usr/lib/mesos/lib/libmesos.so

# Install Docker
RUN apt-get install -y docker-engine

RUN rm -Rf /var/lib/apt/*

ENV REF_DIR /usr/share/jenkins/ref

ADD defaults.tgz $REF_DIR
COPY plugins.txt $REF_DIR/

RUN chown -R jenkins $REF_DIR
USER jenkins

RUN /usr/local/bin/plugins.sh $REF_DIR/plugins.txt
