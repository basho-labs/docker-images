FROM alpine
MAINTAINER Jon Brisbin <jbrisbin@basho.com>

RUN \
  apk add --update python py-six py-setuptools curl unzip
RUN \
  cd /usr/lib/python2.7/site-packages && \
  curl -sSLO https://pypi.python.org/packages/2.7/r/riak/riak-2.4.2-py2.7.egg && \
  curl -sSLO https://pypi.python.org/packages/2.7/p/protobuf/protobuf-2.6.1-py2.7.egg && \
  unzip -o riak-2.4.2-py2.7.egg && \
  unzip -o protobuf-2.6.1-py2.7.egg

WORKDIR $HOME
ENTRYPOINT ["python", "-"]
