ENV \
  DEBIAN_FRONTEND=noninteractive \
  DEBCONF_NONINTERACTIVE_SEEN=true

# Install Build tools
RUN \
  apt-get update && \
  apt-get install -qy openssl libssl-dev tar git wget curl vim build-essential autoconf automake libtool python-dev libsasl2-dev libsasl2-modules libapr1-dev apt-transport-https ca-certificates && \
  apt-get dist-upgrade -y
