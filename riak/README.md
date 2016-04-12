# Riak Docker Image

### Building

```
$ cd riak
$ export ERLANG_URL=$ARTIFACTORY_URL/builds/erlang/OTP_R16B02_basho10/ubuntu/15.10/erlang-OTP_R16B02_basho10.tgz
$ export RIAK_URL=$ARTIFACTORY_URL/builds/riak/riak_ts.1.3.0rc7/ubuntu/15.10/riak_ts.1.3.0rc7-bin.tgz
$ make clean install
```

### Running

```
$ docker run --rm -it -p 8087:8087 basho/riak-ts
```
