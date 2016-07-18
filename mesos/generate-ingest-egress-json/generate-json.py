#!/usr/bin/python

import requests, jinja2, click

ingest_tmpl = """{
  "id": "/marqs-ingest",
  "cmd": "$SPARK_HOME/bin/spark-submit --verbose --master mesos://leader.{{mesos}}:5050 --class com.basho.marqs.ingest.IngestApp --conf spark.mesos.executor.docker.image=basho/spark:centos-7 --conf spark.mesos.coarse=false --conf spark.cores.max={{max_cores}} --conf spark.driver.memory={{driver_mem}} --conf spark.executor.memory={{executor_mem}} $MESOS_SANDBOX/marqs-ingest_2.10-1.0.1-assembly.jar",
  "cpus": 1,
  "mem": 2048,
  "container": {
    "type": "DOCKER",
    "docker": {
      "image": "basho/spark:centos-7",
      "network": "HOST"
    }
  },
  "env": {
    "KAFKA_BROKERS": "{{brokers}}",
    "KAFKA_TOPIC": "{{topic}}",
    "RIAK_HOSTS": "{{hosts}}",
    "RIAK_TABLE": "{{table}}",
    "INGEST_TIMESTAMP_FORMAT": "{{timestamp_format}}"
  },
  "uris": [
    "https://basholabs.artifactoryonline.com/basholabs/libs-release-local/com/basho/marqs/marqs-ingest_2.10/1.0.1/marqs-ingest_2.10-1.0.1-assembly.jar"
  ]
}
"""

egress_tmpl = """{
  "id": "/marqs-egress-submit",
  "cmd": "$SPARK_HOME/bin/spark-submit --verbose --master mesos://leader.{{mesos}}:5050 --class com.basho.marqs.egress.EgressApp --conf spark.mesos.executor.docker.image=basho/spark:centos-7 --conf spark.mesos.coarse=false --conf spark.cores.max={{max_cores}} --conf spark.driver.memory={{driver_mem}} --conf spark.executor.memory={{executor_mem}} $MESOS_SANDBOX/marqs-egress_2.10-1.0.1-assembly.jar && curl -X DELETE marathon.{{mesos}}:8080/v2/apps/marqs-egress-submit",
  "cpus": 1,
  "mem": 2048,
  "container": {
    "type": "DOCKER",
    "docker": {
      "image": "basho/spark:centos-7",
      "network": "HOST"
    }
  },
  "env": {
    "KAFKA_BROKERS": "{{brokers}}",
    "KAFKA_TOPIC": "{{topic}}",
    "RIAK_HOSTS": "{{hosts}}",
    "RIAK_TABLE": "{{table}}",
    "RIAK_QUERY": "{{query}}"
  },
  "uris": [
    "https://basholabs.artifactoryonline.com/basholabs/libs-release-local/com/basho/marqs/marqs-egress_2.10/1.0.1/marqs-egress_2.10-1.0.1-assembly.jar"
  ]
}
"""

# select max(value) from ingest where measurementDate >= 1420092000000 AND measurementDate <= 1420182000000 AND site = 'MY7' AND species = 'PM10'
@click.command()
@click.option('--service', '-s', type=click.Choice(['ingest', 'egress']), help='Service to generate Marathon JSON for')
@click.option('--cluster_name', '-c', default='default', help='Name of the cluster')
@click.option('--mesos', '-m', default='mesos', help='Mesos-DNS domain name')
@click.option('--table', '-t', envvar='RIAK_TABLE', default='ingest', help='Name of Riak TS table to ingest data into or select data from')
@click.option('--topic', '-p', envvar='KAFKA_TOPIC', default='ingest', help='Kafka topic on which to subscribe or publish data into')
@click.option('--query', '-q', envvar='RIAK_QUERY', help='Riak TS query to exectue for egress')
@click.option('--timestamp_format', '-f', envvar='INGEST_TIMESTAMP_FORMAT', default='yyyy-MM-dd HH:mm:ss', help='String format used to parse timestamps from strings')
@click.option('--max_cores', envvar='SPARK_CORES_MAX', default='5', help='spark.cores.max value')
@click.option('--driver_mem', envvar='SPARK_DRIVER_MEM', default='2g', help='spark.driver.mem value')
@click.option('--executor_mem', envvar='SPARK_EXECUTOR_MEM', default='2g', help='spark.exectuor.mem value')
def generate(**args):
  director_url = 'http://leader.%s:8123/v1/services/_%s-director._tcp.marathon.%s' % (args['mesos'], args['cluster_name'], args['mesos'])
  director = requests.get(director_url).json()
  if len(director) < 3:
    raise ValueError('No director found in mesos-dns at URL %s' % director_url)
  args['hosts'] = '%s:%s' % (director[1]['ip'], director[1]['port'])

  kafka_url = 'http://leader.%s:8123/v1/services/_broker-0._tcp.kafka.%s' % (args['mesos'], args['mesos'])
  broker = requests.get(kafka_url).json()
  if len(broker) < 1:
    raise ValueError('No Kafka broker-0 found in mesos-dns at URL %s' % kafka_url)
  args['brokers'] = '%s:%s' % (broker[0]['ip'], broker[0]['port'])

  tmpl = ""
  if 'ingest' == args['service']:
    tmpl = ingest_tmpl
  else:
    tmpl = egress_tmpl
  click.echo(jinja2.Template(tmpl).render(args))

if __name__ == '__main__':
    generate()
