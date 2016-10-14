FROM = centos:7
MAINTAINER = Travis B. Hartwell <thartwell@contractor.basho.com>
TAG ?= basho/basho-bench

OVERLAYS = essential erlang basho-bench

DOCKER_BUILD_OPTS += --build-arg=ERLANG_URL=$(ERLANG_URL) --build-arg=BASHO_BENCH_BRANCH=$(BASHO_BENCH_BRANCH)

-include ../../docker.mk
