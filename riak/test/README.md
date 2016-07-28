# Riak Docker tests

The `riak_docker` module contains some test fixtures for working with a Dockerized Riak cluster.

### `cluster` fixture

The `cluster` fixture provides a parameterized way to test against multiple types of Riak. The current implementation will test against both Riak KV and Riak TS, though just one or the other might fit your use case.

By default the `cluster` fixture creates a single node by calling `docker-compose` on a templated config file. In order to get a fresh Riak cluster of one node to connect to with the Riak Python client, just declare
