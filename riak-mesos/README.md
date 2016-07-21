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

Based on (../mesos/cluster) mesos cluster.
To choose which operation system should be used in base image, use OS env. Example:
```
OS=centos make start
```
that will build base image based on centos and start cluster. Default OS is ubuntu.
