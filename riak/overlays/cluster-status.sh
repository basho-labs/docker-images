#!/bin/bash

RIAK_ADMIN=$RIAK_HOME/bin/riak-admin

$RIAK_ADMIN cluster status --format=csv | cut -d@ -f2 | tail -n +2
