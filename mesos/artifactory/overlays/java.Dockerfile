
# Install OpenJDK 8
RUN \
  echo "deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu trusty main" > /etc/apt/sources.list.d/openjdk-r.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv 86F44E2A && \
  apt-get update && \
  apt-get install -y openjdk-8-jdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Install Maven
RUN \
  mkdir -p /usr/lib/maven && \
  curl -sSL http://apache.mirrors.tds.net/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz | tar zxf - -C /usr/lib/maven --strip-components 1
ENV MAVEN_HOME /usr/lib/maven
ENV PATH $MAVEN_HOME/bin:$PATH
