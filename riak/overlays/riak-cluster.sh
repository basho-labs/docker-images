#!/bin/bash

export RIAK=/usr/sbin/riak
export RIAK_CONF=/etc/riak/riak.conf
export RIAK_ADMIN=/usr/sbin/riak-admin
export SCHEMAS_DIR=/etc/riak/schemas/

export CLUSTER_NAME=${CLUSTER_NAME:-riak}
export COORDINATOR_NODE=${COORDINATOR_NODE:-$HOSTNAME}
export HOST=$(ping -c1 $HOSTNAME | awk '/^PING/ {print $3}' | sed 's/[()]//g')||'127.0.0.1'
export COORDINATOR_NODE_HOST=$(ping -c1 $COORDINATOR_NODE | awk '/^PING/ {print $3}' | sed 's/[()]//g')||'127.0.0.1'

PRESTART=$(find /etc/riak/prestart.d -name *.sh -print)
for s in $PRESTART; do
  . $s
done

$RIAK start
$RIAK_ADMIN wait-for-service riak_kv

POSTSTART=$(find /etc/riak/poststart.d -name *.sh -print)
for s in $POSTSTART; do
  . $s
done

tail -n 1024 -f /var/log/riak/console.log
