FROM alpine
MAINTAINER Jon Brisbin <jbrisbin@basho.com>

# Install deps
RUN \
  apk update
RUN \
  apk add \
  build-base \
  tar \
  ca-certificates \
  curl \
  cyrus-sasl-crammd5 \
  git \
  openjdk8 \
  wget \
  apr-dev \
  autoconf \
  automake \
  curl-dev \
  cyrus-sasl-dev \
  fts-dev \
  libelf-dev \
  libtool \
  linux-headers \
  patch \
  protobuf-dev \
  python-dev \
  subversion-dev

# Install Maven
RUN \
  mkdir -p /usr/lib/maven && \
  curl -sSL http://apache.mirrors.tds.net/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz | tar -xzf - -C /usr/lib/maven --strip-components 1

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV MAVEN_HOME /usr/lib/maven

# Compile Mesos
RUN mkdir -p /usr/src && git clone https://github.com/apache/mesos.git /usr/src/mesos
WORKDIR /usr/src/mesos
RUN ./bootstrap
RUN mkdir -p /usr/src/mesos/build
WORKDIR /usr/src/mesos/build
RUN ../configure --prefix=/usr/lib/mesos
RUN make -j8
RUN make install

# Clean up
RUN \
  apk del $(apk info | egrep "\-dev$") && \
  apk del linux-headers autoconf automake patch build-base && \
  rm -Rf /usr/lib/maven && \
  rm -Rf /var/cache/apk/* && \
  rm -Rf /usr/src

WORKDIR /
