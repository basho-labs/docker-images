RUN \
  mkdir -p /usr/lib/maven && \
  curl -sSL http://apache.mirrors.tds.net/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz | tar zxf - -C /usr/lib/maven --strip-components 1
ENV MAVEN_HOME /usr/lib/maven
ENV PATH $MAVEN_HOME/bin:$PATH
