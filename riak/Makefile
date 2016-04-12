RIAK_URL ?=
ERLANG_URL ?=

FROM = ubuntu:15.10
MAINTAINER = Jon Brisbin <jbrisbin@basho.com>
TAG = basho/riak-ts

OVERLAYS = env essential java-8 erlang riak

DOCKER_BUILD_OPTS += --build-arg ERLANG_URL=$(ERLANG_URL) --build-arg RIAK_URL=$(RIAK_URL)

-include ../docker.mk
