# basho/dcos

This Docker image contains an installation of the DCOS CLI tool for use with Apache Mesos. It assumes you either are running the DCOS server on `leader.mesos` or the OSS `dcos-proxy-shim`, which is a small nginx image that proxies the URLs from Marathon and Mesos to make the CLI happy.

### Using

To use the `basho/dcoscli` image, pull it and run it with an appropriate `--add-host` setting for `leader.mesos` or by setting the env vars `MARATHON`, `MESOS`, and `DCOS` to the URLs to those respective services.

e.g. to run the DCOS CLI connected to a `leader.mesos` of 192.168.0.10:

    $ docker run --rm -it --add-host leader.mesos:192.168.0.10 basho/dcoscli
    [marathon.url]: set to 'http://leader.mesos:8080'
    [core.mesos_master_url]: set to 'http://leader.mesos:5050'
    [core.dcos_url]: set to 'http://leader.mesos'
    http://leader.mesos:5050 >

You're now at a command prompt where you can issue dcos commands against the Mesos cluster:

    http://leader.mesos:5050 > dcos marathon task list
    APP               HEALTHY          STARTED                 HOST       ID
    /dcos-proxy-shim    True   2016-03-30T19:56:36.258Z  192.168.0.11 dcos-proxy-shim.768a574d-f6b1-11e5-8165-065135d5f202
    /mesos-dns          True   2016-03-30T19:56:10.395Z  192.168.0.12 mesos-dns.72f4383c-f6b1-11e5-8165-065135d5f202
    http://leader.mesos:5050 >

### Building

This image is based on Alpine Linux and uses the [docker.mk](https://github.com/jbrisbin/docker.mk) utility to build.

### License

This image is [Apache 2.0 Licensed](http://www.apache.org/licenses/LICENSE-2.0).
