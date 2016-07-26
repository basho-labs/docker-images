# Install Build tools
RUN apt-get update
RUN apt-get install -qy openssl libssl-dev tar git wget curl vim build-essential autoconf automake libtool python-dev python-pip libsasl2-dev libsasl2-modules libapr1-dev libffi-dev apt-transport-https ca-certificates iputils-ping realpath rake ruby-dev jq
