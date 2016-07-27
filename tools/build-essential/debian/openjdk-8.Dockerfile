RUN \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DA1A4A13543B466853BAF164EB9B1D8886F44E2A
RUN \
  echo "deb http://ppa.launchpad.net/openjdk-r/ppa/debian jessie main " >/etc/apt/sources.list.d/openjdk.list && \
  echo "deb-src http://ppa.launchpad.net/openjdk-r/ppa/debian jessie main" >>/etc/apt/sources.list.d/openjdk.list
RUN apt-get update
RUN apt-get install -qy openjdk-8-jdk-headless
