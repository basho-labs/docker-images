#!/bin/bash

MASTER_PATH=/usr/sbin/mesos-master
mkdir -p ${MESOS_WORK_DIR}
mkdir -p ${MESOS_LOG_DIR}

MESOS_ALL=$(printenv | grep MESOS_)
for VARVAL in ${MESOS_ALL}
do
    VAR=${VARVAL%%=*}
    ARG=$(echo ${VAR##*MESOS_} | tr '[:upper:]' '[:lower:]')
    VAL=${VARVAL##*=}
    PARAMS="${PARAMS} --${ARG}=${VAL}"
done

${MASTER_PATH} ${PARAMS}
echo ${PARAMS}
