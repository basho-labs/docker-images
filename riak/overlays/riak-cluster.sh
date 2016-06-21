#!/bin/bash

RIAK=/usr/sbin/riak
RIAK_CONF=/etc/riak/riak.conf
RIAK_ADMIN=/usr/sbin/riak-admin

CLUSTER_NAME=${CLUSTER_NAME:-riak}
PRIMARY_NODE=${PRIMARY_NODE:-$HOSTNAME}
HOST=$(ping -c1 $HOSTNAME | awk '/^PING/ {print $3}' | sed 's/[()]//g')||'127.0.0.1'
PRIMARY_NODE_HOST=$(ping -c1 $PRIMARY_NODE | awk '/^PING/ {print $3}' | sed 's/[()]//g')||'127.0.0.1'

sed -i -r "s#nodename = (.*)#nodename = riak@$HOST#g" $RIAK_CONF
sed -i -r "s#distributed_cookie = (.*)#distributed_cookie = $CLUSTER_NAME#g" $RIAK_CONF
sed -i -r "s#listener\.protobuf\.internal = (.*)#listener.protobuf.internal = $HOST:8087#g" $RIAK_CONF
sed -i -r "s#listener\.http\.internal = (.*)#listener.http.internal = $HOST:8098#g" $RIAK_CONF

$RIAK start
$RIAK_ADMIN wait-for-service riak_kv

if [ "$PRIMARY_NODE" != "$HOSTNAME" ]; then
  echo "Connecting to cluster @ $PRIMARY_NODE"
  curl -sSL $HOST:8098/admin/control/clusters/default/join/riak@$PRIMARY_NODE_HOST
fi

tail -f /var/log/riak/console.log
