TAG = tests
FROM = alpine
MAINTAINER = Jon Brisbin <jbrisbin@basho.com>
OVERLAYS = tests
RIAK_MODE ?= test
PYTEST_ARGS ?=

.PHONY: test-pytest-tests

clean::
	rm -Rf .cache __pycache__ riak_docker/__pycache__ riak_docker/*.pyc *.pyc

test-pytests: clean install
	docker-compose -f test.yml -p $@ run -e RIAK_MODE=$(RIAK_MODE) tests $(PYTEST_ARGS)

include ../../docker.mk
