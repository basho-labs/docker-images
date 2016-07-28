RUN \
  mkdir -p /usr/lib/mesos && \
  curl -sL https://basholabs.artifactoryonline.com/basholabs/build/alpine-3.4/mesos/1.0.0/mesos-1.0.0.tgz | tar -zxf - -C /usr/lib/mesos
