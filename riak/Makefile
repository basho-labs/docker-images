FROM = ubuntu:trusty
MAINTAINER = Jon Brisbin <jbrisbin@basho.com>
CMD = ["/usr/lib/riak/riak-cluster.sh"]
RIAK_FLAVOR ?= ts # | kv
TAG = basho/riak-$(RIAK_FLAVOR)

OVERLAYS = env essential openjdk-8 riak-$(RIAK_FLAVOR) riak-common

-include ../docker.mk
