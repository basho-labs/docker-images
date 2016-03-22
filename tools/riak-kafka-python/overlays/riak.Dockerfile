ENV \
  DEBIAN_FRONTEND=noninteractive \
  DEBCONF_NONINTERACTIVE_SEEN=true

RUN \
  apt-get update && \
  apt-get install -y python-dev python-pip libffi-dev libssl-dev && \
  pip install cryptography riak
  
ENTRYPOINT ["python"]
