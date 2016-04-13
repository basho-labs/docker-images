#!/bin/bash

CLUSTER_NAME=${2:-dev}
NODES=${3:-3}

case "$1" in
  start)
    START_PORT=${START_PORT:-10017}
    END_PORT=$(($START_PORT+(10*$NODES)))
    PORTS=($(seq $START_PORT 10 $END_PORT))
    for i in $(seq 1 $NODES); do
      docker run -d --name "${CLUSTER_NAME}$i" -p ${PORTS[i-1]}:8087 -e CLUSTER_NAME=$CLUSTER_NAME basho/riak-ts
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
