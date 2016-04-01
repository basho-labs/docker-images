ENV \
  DEBIAN_FRONTEND=noninteractive \
  DEBCONF_NONINTERACTIVE_SEEN=true
RUN \
  apt-get update && \
  apt-get install -y openssl tar git wget curl vim apt-transport-https ca-certificates
