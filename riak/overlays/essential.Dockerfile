
# Install essential software
RUN apt-get update
RUN apt-get install -qy \
  libsasl2-modules \
  libapr1 \
  realpath \
  curl \
  jq \
  python-pip
RUN pip install riak

RUN apt-get purge -y \
  $(apt-cache pkgnames|egrep "(.*)-dev$") \
  build-essential
