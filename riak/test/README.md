# Riak Docker tests

The `riak_docker` module contains a test fixture for working with a Dockerized Riak cluster. 

#### Pre-requisites

Currently the test fixture expects a recent enough `docker-compose` to use `version: "2"` (`docker-compose` 1.6 or later). You also need Docker version 1.11 or later. This should work with the native Docker betas for Mac or Windows, `docker-machine`, or plain Docker. If it doesn't work in your environment, then that's a bug. It also expects the files `riak-ts.yml` and `riak-kv.yml` to exist one directory above here.

### Writing tests

These tests use [pytest](http://docs.pytest.org/en/latest/). Please refer to the [pytest documentation on how it searches for tests](http://docs.pytest.org/en/latest/goodpractices.html#test-discovery) and what conventions to use for naming classes and methods that will be discovered when the tests are run.

Tests should declare the use of the `cluster` fixture which, by default, is a single node Riak cluster that should be ready to start receiving requests once the test code has a reference to the fixture.

#### Connecting to the cluster

To create a `RiakClient` using the Python client that is connected to the cluster, you need to get the IPs of the Riak nodes from the fixture's `client()` method:

    assert cluster.client().ping()

### Running the tests

The tests are run inside a Docker container built from the `Dockerfile` residing in this directory. If you add tests to this folder that can be discovered by pytest, then running `make clean test` should pick them up and run them automatically.

In order to pass additional parameters to `pytest` (like restricting what tests are run), declare the ENV variable `PYTEST_ARGS` with the appropriate parameters.

    PYTEST_ARGS="-k my_test" make clean test

### Advanced config: networking

In order for the tests to talk to the cluster started by the test fixture, the container running the tests has to be using the same Docker network. In the default configuration, the `docker-compose` configuration and the `Makefile` specify a network name of `riak`.
