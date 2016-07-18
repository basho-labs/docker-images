# Riak Mesos Framework Marathon JSON Generator

The Python script `generate-json.py` can be used as a stand-alone script or by running the Docker image built from the included `Dockerfile`. Upon invocation it will generate a Marathon JSON file appropriate for deploying the ingest or egress services to a given cluster. It assumes Mesos-DNS is running on the Mesos master on port 8123 and that a Kafka framework is deployed to the cluster that has at least one broker named `broker-0`.

### Installing the script

If running the script outside a Docker container, first install the prerequisites by doing a `pip install -r requirements.txt` in this directory. If using the Docker container, you can either build the image locally and use a tag of your own choosing or run [the default image from the Basho Docker Hub](https://hub.docker.com/r/basho/generate-rmf-config/). You can then get help on running the utility by using the `--help` flag:

##### Non-Docker

```
$ python ./generate-json.py --help
```

##### Docker

```
$ docker run -i basho/generate-ingest-egress-json --help
```

```
Usage: generate-json [OPTIONS]

Options:
  -s, --service [ingest|egress]  Service to generate Marathon JSON for
  -c, --cluster_name TEXT        Name of the cluster
  -m, --mesos TEXT               Mesos-DNS domain name
  -t, --table TEXT               Name of Riak TS table to ingest data into or
                                 select data from
  -p, --topic TEXT               Kafka topic on which to subscribe or publish
                                 data into
  -q, --query TEXT               Riak TS query to exectue for egress
  -f, --timestamp_format TEXT    String format used to parse timestamps from
                                 strings
  --max_cores TEXT               spark.cores.max value
  --driver_mem TEXT              spark.driver.mem value
  --executor_mem TEXT            spark.exectuor.mem value
  --help                         Show this message and exit.
```
