RUN curl -fsSL https://get.docker.com/ | sh
RUN curl -L -o /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/1.8.0-rc1/docker-compose-Linux-x86_64
RUN chmod a+x /usr/local/bin/docker-compose
