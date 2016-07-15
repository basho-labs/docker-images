FROM alpine
MAINTAINER Jon Brisbin <jbrisbin@basho.com>

RUN apk add --update python py-pip
COPY requirements.txt /tmp/requirements.txt
RUN \
  pip install -r /tmp/requirements.txt && \
  rm -f /tmp/requirements.txt

COPY generate-config.py /usr/sbin/generate-config
RUN chmod a+x /usr/sbin/generate-config

WORKDIR /root

ENTRYPOINT ["/usr/sbin/generate-config"]
