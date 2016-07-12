#!/bin/bash

CFG_PATH=/etc/zookeeper/conf/zoo.cfg
SERVER_PATH=/usr/share/zookeeper/bin/zkServer.sh

sed -e "s/tickTime=[0-9]*/tickTime=${ZK_TICK_TIME}/" ${CFG_PATH} > ${CFG_PATH}.tmp && mv ${CFG_PATH}.tmp ${CFG_PATH}
sed -e "s/initLimit=[0-9]*/initLimit=${ZK_INIT_LIMIT}/" ${CFG_PATH} > ${CFG_PATH}.tmp && mv ${CFG_PATH}.tmp ${CFG_PATH}
sed -e "s/syncLimit=[0-9]*/syncLimit=${ZK_SYNC_LIMIT}/" ${CFG_PATH} > ${CFG_PATH}.tmp && mv ${CFG_PATH}.tmp ${CFG_PATH}
sed -e "s/clientPort=[0-9]*/clientPort=${ZK_CLIENT_PORT}/" ${CFG_PATH} > ${CFG_PATH}.tmp && mv ${CFG_PATH}.tmp ${CFG_PATH}
sed -e "/^server./ d" ${CFG_PATH} > ${CFG_PATH}.tmp && mv ${CFG_PATH}.tmp ${CFG_PATH}

if [ -z "${MESOS_ZK}" ]; then
    echo "Specify Zookeeper url with MESOS_ZK env"
    exit 1
fi
CUTSCHEME=${MESOS_ZK#*//}
ZKARRAY=$(echo ${CUTSCHEME%/*} | tr "," " ")
for ZK in $ZKARRAY
do
    IP=${ZK%:*}
    echo "server.${IP##*.}=${IP}:2888:3888" >> ${CFG_PATH}
done

LOCAL_IP=$(ifconfig eth0 | sed -En 's/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
echo ${LOCAL_IP##*.} > /etc/zookeeper/conf/myid
echo ${LOCAL_IP##*.} > /var/lib/zookeeper/myid

${SERVER_PATH} start-foreground ${CFG_PATH}
