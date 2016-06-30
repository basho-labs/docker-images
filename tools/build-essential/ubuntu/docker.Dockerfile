RUN \
  apt-key adv --keyserver p80.pool.sks-keyservers.net --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
  echo "deb https://apt.dockerproject.org/repo ubuntu-$OS_FLAVOR main" >/etc/apt/sources.list.d/docker.list && \
  apt-get update && \
  apt-get install -y docker-engine
RUN \
  curl -L https://github.com/docker/compose/releases/download/1.8.0-rc1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose
