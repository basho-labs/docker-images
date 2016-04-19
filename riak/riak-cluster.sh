#!/bin/bash

CLUSTER_NAME=${2:-dev}
NODES=${3:-3}

case "$1" in
  start)
    for i in $(seq 1 $NODES); do
      docker run -d -h "${CLUSTER_NAME}$i" -p 8087 -p 8098 -e CLUSTER_NAME=$CLUSTER_NAME --link "${CLUSTER_NAME}1" basho/riak-ts
    done
    ;;
  stop)
    docker kill $(seq -f "$CLUSTER_NAME%g" 1 $NODES)
    ;;
  clean)
    docker rm $(seq -f "$CLUSTER_NAME%g" 1 $NODES)
    ;;
  *)
    echo "Usage: $0 start|stop|clean"
esac
