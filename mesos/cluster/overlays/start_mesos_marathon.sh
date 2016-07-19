#!/bin/bash

MARATHON_PATH=/usr/bin/marathon

PARAMS="--zk ${MARATHON_ZK} --master ${MARATHON_MASTER}"

${MARATHON_PATH} ${PARAMS}
