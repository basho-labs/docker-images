FROM basho/build-essential:ubuntu-14.04
MAINTAINER Jon Brisbin <jbrisbin@basho.com>

RUN pip install riak

VOLUME /usr/src/test
WORKDIR /usr/src/test

ENTRYPOINT ["py.test", "-v", "--junit-xml=test-report.xml"]
