FROM = ubuntu:trusty
MAINTAINER = Travis B. Hartwell <thartwell@contractor.basho.com>
TAG ?= basho/basho-bench

OVERLAYS = env essential erlang basho-bench

DOCKER_BUILD_OPTS += --build-arg=ERLANG_URL=$(ERLANG_URL) --build-arg=BASHO_BENCH_BRANCH=$(BASHO_BENCH_BRANCH)

-include ../../docker.mk
