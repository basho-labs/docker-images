#!/bin/bash

RIAK=$RIAK_HOME/bin/riak
RIAK_ADMIN=$RIAK_HOME/bin/riak-admin

CLUSTER_NAME=${CLUSTER_NAME:-dev}
HOST=$(ping -c1 $HOSTNAME | awk '/^PING/ {print $3}' | sed 's/[()]//g')
MASTER=$(ping -c1 ${CLUSTER_NAME:-dev}1 | awk '/^PING/ {print $3}' | sed 's/[()]//g')||''

sed -i -r "s#nodename = (.*)#nodename = riak@$HOST#g" /etc/riak/riak.conf
sed -i -r "s#distributed_cookie = (.*)#distributed_cookie = $CLUSTER_NAME#g" /etc/riak/riak.conf

$RIAK start

if [ "$HOST" != "$MASTER" ]; then
  echo "Connecting to cluster @ $MASTER"
  $RIAK_ADMIN cluster join riak@$MASTER
  $RIAK_ADMIN cluster plan
  $RIAK_ADMIN cluster commit
fi

tail -f /var/log/riak/console.log
