
# Install Riak KV
RUN curl -sSL https://packagecloud.io/basho/riak/gpgkey | apt-key add -
RUN echo "deb https://packagecloud.io/basho/riak/ubuntu/ trusty main" >/etc/apt/sources.list.d/basho_riak.list
RUN echo "deb-src https://packagecloud.io/basho/riak/ubuntu/ trusty main" >>/etc/apt/sources.list.d/basho_riak.list
RUN apt-get update
RUN apt-get install -y riak

ENV RIAK_FLAVOR KV
