
# Install Riak
RUN curl -sSL https://packagecloud.io/basho/riak-ts/gpgkey | apt-key add -
RUN echo "deb https://packagecloud.io/basho/riak-ts/ubuntu/ trusty main" >/etc/apt/sources.list.d/basho_riak-ts.list
RUN echo "deb-src https://packagecloud.io/basho/riak-ts/ubuntu/ trusty main" >>/etc/apt/sources.list.d/basho_riak-ts.list
RUN apt-get update
RUN apt-get install -y riak-ts

ENV RIAK_FLAVOR TS
