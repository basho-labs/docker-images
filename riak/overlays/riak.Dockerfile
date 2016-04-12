
ARG RIAK_URL
ENV RIAK_HOME=/usr/lib/riak

# Install Riak
RUN \
  mkdir -p $RIAK_HOME && \
  curl -sSL $RIAK_URL | tar zxf - -C $RIAK_HOME
ENV PATH=$RIAK_HOME/bin:$PATH

# Setup/copy config
RUN \
  sed -i -r 's#RUNNER_ETC_DIR=\$RUNNER_BASE_DIR(.*)#RUNNER_ETC_DIR=/etc/riak#g' $RIAK_HOME/lib/env.sh && \
  sed -i -r 's#RUNNER_LOG_DIR=\$RUNNER_BASE_DIR(.*)#RUNNER_LOG_DIR=/var/log/riak#g' $RIAK_HOME/lib/env.sh
RUN \
  mkdir -p /etc/riak/init.sql.d && \
  mkdir -p /var/log/riak && \
  mkdir -p /var/lib/riak/data
COPY $CURDIR/riak.conf /etc/riak/riak.conf
COPY $CURDIR/riak.sh /var/lib/riak/riak.sh

WORKDIR /var/lib/riak/data
CMD ["../riak.sh"]
