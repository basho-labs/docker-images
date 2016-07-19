#!/bin/bash

MARATHON_PATH=/usr/bin/marathon

function run_mesosdns() {
    # wait until marathon starts and run mesosdns
    while ! curl -f -s -o /dev/null http://localhost:8080/ping; do
        sleep 1
    done
    curl -v -XPUT -H 'Content-Type: application/json' http://localhost:8080/v2/apps -d @/opt/mesos-dns-marathon.json
}

run_mesosdns &
# Marathon will read env variable MARATHON_ZK, MARATHON_MASTER itself
${MARATHON_PATH}
