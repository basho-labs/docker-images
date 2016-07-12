#!/bin/bash

SLAVE_PATH=/usr/sbin/mesos-slave
mkdir -p ${MESOS_FRAMEWORKS_HOME}
mkdir -p ${MESOS_LOG_DIR}

MESOS_ALL=$(printenv | grep MESOS_)
for VARVAL in ${MESOS_ALL}
do
    VAR=${VARVAL%%=*}
    ARG=$(echo ${VAR##*MESOS_} | tr '[:upper:]' '[:lower:]')
    VAL=${VARVAL##*=}
    PARAMS="${PARAMS} --${ARG}=${VAL}"
done

${SLAVE_PATH} ${PARAMS} --no-systemd_enable_support
echo ${PARAMS}
