#Mesos dev clster
This set of scripts starts developer riak-mesos cluster.

#Usage
Use 'make' command with following targets:
* all - build base docker image
* clean - clean up everything after this cluster
* start - run cluster, if base image isn't built, it will be built 
* stop - stop cluster
* restart - restart cluster
* test - run simple healthy test on running cluster
* update-head - update riak-mesos git submodule
* attach - run shell from node with riak-mesos tool.

Based on (../mesos/cluster) mesos cluster.
To choose which operation system should be used in base image, use OS env. Example:
```
OS=centos make start
```
that will build base image based on centos and start cluster. Default OS is ubuntu.

# Web interfaces
http://172.16.200.21:5050 - mesos master
http://172.16.100.41:8080 - marathon

#riak-mesos util usage
see https://github.com/basho-labs/riak-mesos-tools#usage
Util is preinstall and preconfigured on each nodes.
