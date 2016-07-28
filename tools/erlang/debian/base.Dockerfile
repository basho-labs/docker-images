RUN \
  apt-get update && \
  apt-get install -y openssl libsasl2-modules libffi6 ca-certificates ncurses-base ncurses-term curl
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
