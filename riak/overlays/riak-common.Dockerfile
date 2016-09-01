
# Install Riak Explorer
RUN curl -sSL https://github.com/basho-labs/riak_explorer/releases/download/1.2.1/riak_explorer-1.2.1.patch-ubuntu-14.04.tar.gz | tar -zxf - -C /usr/lib/riak --strip-components 2

# Install the Python client
RUN \
  cd /usr/lib/python2.7/dist-packages && \
  curl -sSLO https://pypi.python.org/packages/2.7/r/riak/riak-2.4.2-py2.7.egg && \
  curl -sSLO https://pypi.python.org/packages/2.7/p/protobuf/protobuf-2.6.1-py2.7.egg && \
  unzip -o riak-2.4.2-py2.7.egg && \
  unzip -o protobuf-2.6.1-py2.7.egg

# Expose default ports
EXPOSE 8087
EXPOSE 8098

# Expose volumes for data and logs
VOLUME /var/log/riak
VOLUME /var/lib/riak

# Install custom start script
COPY {{$dir}}/riak-cluster.sh /usr/lib/riak/riak-cluster.sh
RUN chmod a+x /usr/lib/riak/riak-cluster.sh
# Install custom hooks
COPY {{$dir}}/prestart.d /etc/riak/prestart.d
COPY {{$dir}}/poststart.d /etc/riak/poststart.d

# Prepare for bootstrapping schemas
RUN mkdir -p /etc/riak/schemas

WORKDIR /var/lib/riak
