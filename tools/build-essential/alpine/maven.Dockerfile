# RUN apk add --no-cache maven
ENV MAVEN_HOME /usr/lib/maven
ENV PATH $MAVEN_HOME/bin:$PATH

RUN \
  mkdir -p /usr/lib/maven && \
  curl -sSL http://apache.mirrors.tds.net/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz | tar -xz -C /usr/lib && \
  ln -s /usr/lib/apache-maven-3.3.9-bin $MAVEN_HOME
