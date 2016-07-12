#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

case "$NODE_MODE" in
    mesos_master)
        $DIR/start_mesos_master.sh
        ;;
    mesos_slave)
        $DIR/start_mesos_slave.sh
        ;;
    mesos_zk)
        $DIR/start_zk.sh
        ;;
    *)
        echo "Specify node mode with NODE_MODE env"
        echo "Posible values are: mesos_master, mesos_slave, mesos_zk"
        exit 1
esac

