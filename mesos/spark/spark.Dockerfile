# Install Spark
ARG SPARK_HOME=/usr/lib/spark
ARG SPARK_VERSION=1.6.1
ARG HADOOP_VERSION=hadoop2.6
RUN \
  mkdir -p $SPARK_HOME && \
  curl -sSL http://www-us.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz | tar zxf - -C $SPARK_HOME --strip-components=1

ENV \
  SPARK_HOME=$SPARK_HOME \
  PATH=$SPARK_HOME/bin:$PATH \
  MASTER=local[*] \
  SPARK_SUBMIT_OPTIONS="--driver-memory 512M --executor-memory 2G --conf spark.mesos.executor.docker.image=basho/spark"

CMD ["bash", "-i"]
