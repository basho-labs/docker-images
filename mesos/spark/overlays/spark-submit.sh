#!/bin/bash

if [[ ! -z "$@" ]]; then
  export SPARK_SUBMIT_OPTIONS="$(cat /etc/spark/submit.opts) $SPARK_SUBMIT_OPTIONS"
  curl -sSL -o /tmp/spark-job.jar $@
  /usr/lib/spark/bin/spark-submit $SPARK_SUBMIT_OPTS /tmp/spark-job.jar
else
  bash -i
fi
