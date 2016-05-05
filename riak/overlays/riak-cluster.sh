#!/bin/bash

RIAK=/usr/sbin/riak
RIAK_CONF=/etc/riak/riak.conf
RIAK_ADMIN=/usr/sbin/riak-admin

CLUSTER_NAME=${CLUSTER_NAME:-riak}
CLUSTER1=${CLUSTER1:-$HOSTNAME}
HOST=$(ping -c1 $HOSTNAME | awk '/^PING/ {print $3}' | sed 's/[()]//g')||'127.0.0.1'
MASTER=$((ping -c1 $CLUSTER1 2>/dev/null || echo 'PING local 127.0.0.1') | awk '/^PING/ {print $3}' | sed 's/[()]//g')||''

sed -i -r "s#nodename = (.*)#nodename = riak@$HOST#g" $RIAK_CONF
sed -i -r "s#distributed_cookie = (.*)#distributed_cookie = $CLUSTER_NAME#g" $RIAK_CONF
sed -i -r "s#listener\.protobuf\.internal = (.*)#listener.protobuf.internal = $HOST:8087#g" $RIAK_CONF
sed -i -r "s#listener\.http\.internal = (.*)#listener.http.internal = $HOST:8098#g" $RIAK_CONF

$RIAK start

if [ "$HOST" != "$MASTER" ]; then
  echo "Connecting to cluster @ $MASTER"
  $RIAK_ADMIN cluster join riak@$MASTER
  $RIAK_ADMIN cluster plan
  $RIAK_ADMIN cluster commit
fi

tail -f /var/log/riak/console.log
