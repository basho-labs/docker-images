
# Install OpenJDK 8
RUN \
  echo "deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu trusty main" > /etc/apt/sources.list.d/openjdk-r.list && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 86F44E2A && \
  apt-get update && \
  apt-get install -y openjdk-8-jdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
