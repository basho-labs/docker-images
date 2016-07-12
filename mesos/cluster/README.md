#Mesos dev clster
This set of scripts starts developer Mesos cluster of few nodes using Docker Compose. Cluster contains Mesos master, slave and zookeeper nodes. cluster.yml file contains config of the cluster. Base docker image for all nodes is the same. Node role depends on enviroment variable from cluster config. Network settings are also in cluster.yml.

#Usage
Use 'make' command with following targets:
* all - build base docker image
* clean - clean up everything after this cluster
* start - run cluster, if base image isn't built, it will be built 
* stop - stop cluster
* restart - restart cluster
* test - run simple healthy test on running cluster

To choose which operation system should be used in base image, use OS env. Example:
```
OS=centos make start
```
that will build base image based on centos and start cluster. Default OS is ubuntu. List of all aviliable OSes in `docker` dir (extensions of Dockerfiles).

# Default hosts and ports
Zookeeper server - zk://172.16.200.11:2181,172.16.200.12:2181,172.16.200.113:2181  
Mesos master web interface - http://172.16.200.21:5050  

# Adding base image with new OS
Create new file in 'docker' dir named `Dockerfile.osname` and implement Dockerfile for this OS using existing examples.
