#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function check_servers() {
    RES=1
    SN=$(ifconfig eth0 | sed -En 's/.*inet (addr:)?(([0-9]*\.){2}[0-9]*).*/\2/p')
    for N in `seq 31 39`; do
        if netcat -z "$SN.$N" 53; then
            OLD=$(cat /etc/resolv.conf | grep nameserver)
            echo "nameserver $SN.$N" > /etc/resolv.conf
            echo "$OLD" >> /etc/resolv.conf
            RES=0
            break
        fi
    done
    return $RES
}

function search_mesosdns() {
    while ! check_servers; do
        sleep 1
    done
}

search_mesosdns &

case "$NODE_MODE" in
    mesos_marathon)
        $DIR/start_mesos_marathon.sh
        ;;
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
        echo "Possible values are: mesos_marathon, mesos_master, mesos_slave, mesos_zk"
        exit 1
esac

