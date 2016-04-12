#!/bin/bash

COOKIE=${CLUSTER_NAME:-riak}
NODENAME=${HOSTNAME:-riak}

sed -i -r "s#nodename = (.*)#nodename = $NODENAME@127.0.0.1#g" /etc/riak/riak.conf
sed -i -r "s#distributed_cookie = (.*)#distributed_cookie = $COOKIE#g" /etc/riak/riak.conf

$RIAK_HOME/bin/riak console
