#!/bin/bash

COOKIE=${CLUSTER_NAME:-riak}
CONTAINER_IP=$(ip addr show dev eth0 | egrep "scope global" | cut -d\/ -f1 | awk '{print $2}')

sed -i -r "s#nodename = (.*)#nodename = riak@$CONTAINER_IP#g" /etc/riak/riak.conf
sed -i -r "s#distributed_cookie = (.*)#distributed_cookie = $COOKIE#g" /etc/riak/riak.conf

$RIAK_HOME/bin/riak console
