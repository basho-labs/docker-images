# Riak TS

This image is built from a [`docker.mk`](https://github.com/jbrisbin/docker.mk) enabled repository:
[https://github.com/basho-labs/docker-images/tree/master/riak](https://github.com/basho-labs/docker-images/tree/master/riak)

[Riak TS](http://basho.com/products/riak-ts/) is a [timeseries](https://en.wikipedia.org/wiki/Time_series) database special-built for storage and analysis of timeseries data that is architected on the foundation of the Riak NoSQL database. It has been tailor-made to provide the same operational simplicity and flexibility of [Riak KV](https://github.com/basho/riak) but with special emphasis on dealing with time-based data.

### Starting a Riak TS cluster

You can start a simple Riak TS cluster using `docker-compose`. Create a working directory named `riak-ts` and inside that directory create a file named `docker-compose.yml` based on the following example.

Note: the `primary` node is the first one to be started in the cluster and is the node to which all the others will join. It's also the only container exposed on a predictable port.

```yaml
version: "2"
services:
  primary:
    image: basho/riak-ts:1.3.1
    ports:
      - "8087:8087"
      - "8098:8098"
    labels:
      - "com.basho.riak.cluster.name=test"
    volumes:
      - schemas:/etc/riak/schemas
  secondary:
    image: basho/riak-ts:1.3.1
    ports:
      - "8087"
      - "8098"
    labels:
      - "com.basho.riak.cluster.name=test"
    links:
      - primary
    depends_on:
      - primary
    environment:
      - PRIMARY_NODE=primary

volumes:
  schemas:
    external: false
```

If you bring up the cluster now, you'll get a 2-node cluster.

    $ docker-compose up -d

Open Riak Explorer in the browser by navigating to [localhost:8098/admin/](http://localhost:8098/admin/).

You can now create bucket types and Riak TS tables using the explorer web UI. There is also [a comprehensive REST API](http://basho-labs.github.io/riak_explorer/docs/api.html) your applications can leverage when interacting with this Dockerized cluster.

### Scaling the Cluster

You can scale the cluster to multiple nodes by using `docker-compose` and scaling the `secondary` service to the number of nodes you want.

    $ docker-compose scale secondary=4

The above will scale the cluster to 5 total nodes (1 primary + 4 secondary). If you refresh [the OPS page in Riak Explorer](http://localhost:8098/admin/#/cluster/default/ops) you should see the new nodes (they'll be using the Docker internal IPs which are 172.18.0.X).

### Volumes for data

The default configuration above creates an ephemeral cluster--one you throw away when your task is complete. In order to persist data from one run to the next, provide a volume for the image that mounts to the container path `/var/lib/riak`.

Consult [the official `docker-compose` reference](https://docs.docker.com/compose/compose-file/#volume-configuration-reference) for more information.

### HOST:PORT Discovery

To discover the HOST:PORT values needed to connect to the Riak nodes running in the Dockerized cluster, you can use a combination of `docker inspect` and [`jq`](https://stedolan.github.io/jq/manual/).

Set an environment variable to hold the HOST:PORT pairs.

    $ export RIAK_HOSTS=$(echo $(docker inspect $(docker ps -q -f label=com.basho.riak.cluster.name=test) | jq -r '.[] | "localhost:" + .NetworkSettings.Ports."8087/tcp"[0].HostPort') | tr ' ' ',')

Note: if you change the label `com.basho.riak.cluster.name` in the `docker-compose` configuration, you'll need to make sure the `docker ps` filter in the above command reflects this change.

### Bucket type bootstrapping

Automatic loading of bucket types is supported in this image. It supports both TS buckets and KV data types by looking for files inside the `/etc/riak/schemas/` directory, which can be mounted as a volume. If a file ends with a `.sql` it's assumed to be a [SQL `CREATE TABLE` statement that creates a TS table](http://docs.basho.com/riak/ts/1.3.0/using/creating-activating/). If the file ends in `.dt` it's assumed to be a KV data type definition. The `basename` of the file (minus the `.sql` or `.dt` suffix) will be used as the bucket name.

To use the schema bootstrapping with `docker-compose` you need to set up a volume named "schemas" that contains all the schema files. This volume will be mounted in the container at path `/etc/riak/schemas/`. The following will create a volume named `schemas` and copy the contents of `$(pwd)/schemas/*` to the volume. When `docker-compose up` is run, the sql and dt files will be translated into `riak-admin bucket type create` and activate commands based on the `basename` of the file.

    $ docker run --rm -it -v schemas:/etc/riak/schemas -v $(pwd)/schemas:/tmp/schemas alpine cp /tmp/schemas/* /etc/riak/schemas/
