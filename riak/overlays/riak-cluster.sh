#!/bin/bash

RIAK=/usr/sbin/riak
RIAK_CONF=/etc/riak/riak.conf
RIAK_ADVANCED_CONF=/etc/riak/advanced.config
RIAK_ADMIN=/usr/sbin/riak-admin
SCHEMAS_DIR=/etc/riak/schemas/

CLUSTER_NAME=${CLUSTER_NAME:-riak}
COORDINATOR_NODE=${COORDINATOR_NODE:-$HOSTNAME}
HOST=$(ping -c1 $HOSTNAME | awk '/^PING/ {print $3}' | sed 's/[()]//g')||'127.0.0.1'
COORDINATOR_NODE_HOST=$(ping -c1 $COORDINATOR_NODE | awk '/^PING/ {print $3}' | sed 's/[()]//g')||'127.0.0.1'

sed -i -r "s#nodename = (.*)#nodename = riak@$HOST#g" $RIAK_CONF
sed -i -r "s#distributed_cookie = (.*)#distributed_cookie = $CLUSTER_NAME#g" $RIAK_CONF
sed -i -r "s#listener\.protobuf\.internal = (.*)#listener.protobuf.internal = $HOST:8087#g" $RIAK_CONF
sed -i -r "s#listener\.http\.internal = (.*)#listener.http.internal = $HOST:8098#g" $RIAK_CONF

riak_test_rapid_ready () {
    # only make riak cluster convergence rapid if the cluster is being used for
    # testing. otherwise, cluster communications will have a more dominant share
    # of the overall CPU and Net I/O than they should.
    if echo $RIAK_MODE |grep "test" >/dev/null 2>&1; then
        # set riak_conf vnode_parallel_start, forced_ownership_handoff, and
        # handoff_concurrency to the ring_size.
        local ring_size=$(awk -F'=' '/ring_size/{print $2}' $RIAK_CONF |sed 's/[ ]//')
        local handoff_concurrency=$ring_size
        local forced_ownership_handoff=$ring_size
        local handoff_concurrency=$ring_size
        local sed_riak_core_section="""
/^[ ]*{riak_core,/,/^[ ]*\]}/ {
    s/^[ ]*{.*}[^}]*[^,]/&,/
    s/^[ ]*\]/ \
    {vnode_parallel_start, $vnode_parallel_start}, \
    {forced_ownership_handoff, $forced_ownership_handoff}, \
    {handoff_concurrency, $handoff_concurrency} \
]/
}
"""
        sed -i "$sed_riak_core_section" $RIAK_ADVANCED_CONF
    fi
}
riak_test_rapid_ready

$RIAK start
$RIAK_ADMIN wait-for-service riak_kv

if [ "$RIAK_FLAVOR" == "TS" ]; then
  # Create TS buckets
  echo "Looking for CREATE TABLE schemas in $SCHEMAS_DIR..."
  for f in $(find $SCHEMAS_DIR -name *.sql -print); do
    BUCKET_NAME=$(basename -s .sql $f)
    BUCKET_DEF=$(cat $f)
    $RIAK_ADMIN bucket-type create $BUCKET_NAME '{"props":{"table_def":"'$BUCKET_DEF'"}}'
    $RIAK_ADMIN bucket-type activate $BUCKET_NAME
  done
fi

# Create KV bucket types
echo "Looking for datatypes in $SCHEMAS_DIR..."
for f in $(find $SCHEMAS_DIR -name *.dt -print); do
  BUCKET_NAME=$(basename -s .dt $f)
  BUCKET_DT=$(cat $f)
  $RIAK_ADMIN bucket-type create $BUCKET_NAME '{"props":{"datatype":"'$BUCKET_DT'"}}'
  $RIAK_ADMIN bucket-type activate $BUCKET_NAME
done

# Maybe join to a cluster
IN_CLUSTER="$($RIAK_ADMIN cluster status --format=json | jq -r --arg coordinator $COORDINATOR_NODE_HOST '.[] | select(.type == "table") | .table[] | select(.node | contains($coordinator))')"
if [[ "$IN_CLUSTER" == "" && "$COORDINATOR_NODE_HOST" != "$HOST" ]]; then
  # Not already in this cluster, so join
  echo "Connecting to cluster coordinator $COORDINATOR_NODE"
  curl -sSL $HOST:8098/admin/control/clusters/default/join/riak@$COORDINATOR_NODE_HOST
fi

tail -n 1024 -f /var/log/riak/console.log
