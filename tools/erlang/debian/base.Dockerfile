RUN \
  apt-get update && \
  apt-get install -y openssl libsasl2 libsasl2-modules libffi ca-certificates ncurses curl
