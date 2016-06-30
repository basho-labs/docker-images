FROM basho/build-essential:ubuntu-14.04
MAINTAINER Jon Brisbin <jbrisbin@basho.com>

RUN pip install pytest Jinja2

RUN curl -L https://github.com/docker/compose/releases/download/1.8.0-rc1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

VOLUME /usr/src/test
WORKDIR /usr/src/test

ENTRYPOINT ["py.test", "-v"]
