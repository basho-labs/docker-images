
# Install essential software
RUN apt-get update
RUN apt-get install -qy libsasl2-modules libapr1 realpath curl jq python-pip
RUN pip install riak

RUN apt-get purge -y $(awk '/installed/ {print $5}' /var/log/dpkg.log | cut -d: -f1 | sort -u | egrep "\-dev$") build-essential
RUN apt-get autoremove -y
RUN rm -Rf /var/lib/apt/* /var/cache/apt/*
