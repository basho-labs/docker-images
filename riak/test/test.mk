TAG = tests
FROM = alpine
MAINTAINER = Jon Brisbin <jbrisbin@basho.com>
OVERLAYS = tests
CLUSTER_CONVERGENCE ?= fast
PYTEST_ARGS ?=

.PHONY: test-pytests

clean::
	rm -Rf .cache __pycache__ riak_docker/__pycache__ riak_docker/*.pyc *.pyc

test-pytests: clean install
	docker-compose -f test.yml -p $@ run -e CLUSTER_CONVERGENCE=$(CLUSTER_CONVERGENCE) tests $(PYTEST_ARGS)

-include ../../docker.mk
