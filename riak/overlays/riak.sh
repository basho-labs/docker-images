#!/bin/bash

RIAK=$RIAK_HOME/bin/riak
RIAK_ADMIN=$RIAK_HOME/bin/riak-admin

CLUSTER_NAME=${CLUSTER_NAME:-dev}
HOST=$(ping -c1 $HOSTNAME | awk '/^PING/ {print $3}' | sed 's/[()]//g')||'127.0.0.1'
MASTER=$((ping -c1 ${CLUSTER_NAME}1 2>/dev/null || echo 'PING local 127.0.0.1') | awk '/^PING/ {print $3}' | sed 's/[()]//g')||''

sed -i -r "s#nodename = (.*)#nodename = riak@$HOST#g" /etc/riak/riak.conf
sed -i -r "s#distributed_cookie = (.*)#distributed_cookie = $CLUSTER_NAME#g" /etc/riak/riak.conf
sed -i -r "s#listener\.protobuf\.internal = (.*)#listener.protobuf.internal = $HOST:8087#g" /etc/riak/riak.conf
sed -i -r "s#listener\.http\.internal = (.*)#listener.http.internal = $HOST:8098#g" /etc/riak/riak.conf

$RIAK start
$RIAK_ADMIN wait-for-service riak_kv riak@$HOST

if [ "$HOST" != "$MASTER" ]; then
  echo "Connecting to cluster @ $MASTER"
  $RIAK_ADMIN cluster join riak@$MASTER
  $RIAK_ADMIN cluster plan
  $RIAK_ADMIN cluster commit
fi

tail -f /var/log/riak/console.log
