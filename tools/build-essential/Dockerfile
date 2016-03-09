FROM ubuntu:trusty
MAINTAINER Jon Brisbin <jbrisbin@basho.com>

ENV \
  DEBIAN_FRONTEND=noninteractive \
  DEBCONF_NONINTERACTIVE_SEEN=true

# Install Build tools
RUN \
  apt-get update && \
  apt-get install -y apt-transport-https ca-certificates openssl tar git wget curl build-essential autoconf automake libtool python-dev python-boto libcurl4-nss-dev libsasl2-dev libsasl2-modules libapr1-dev libsvn-dev libncurses5-dev libssl-dev unixodbc-dev fop xsltproc && \
  apt-get dist-upgrade -y

# Install Docker
RUN \
  echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list && \
  apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
  apt-get update && \
  apt-get install -y apparmor docker-engine

# Install Java 8 and SBT
RUN \
  echo "deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu trusty main" > /etc/apt/sources.list.d/openjdk-r.list && \
  echo "deb https://dl.bintray.com/sbt/debian /" > /etc/apt/sources.list.d/sbt.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv 86F44E2A && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv 642AC823 && \
  apt-get update && \
  apt-get install -y openjdk-8-jdk sbt

# Install Maven
RUN curl -sSL http://www-us.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz | tar -zxvf - -C /opt
ENV MAVEN_HOME /opt/apache-maven-3.3.9
ENV PATH $MAVEN_HOME/bin:$PATH
