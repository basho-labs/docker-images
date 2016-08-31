TAG = tests
FROM = alpine
MAINTAINER = Jon Brisbin <jbrisbin@basho.com>
OVERLAYS = tests
PYTEST_ARGS ?=
CMD = $(PYTEST_ARGS)

.PHONY: test-pytest-tests

clean::
	rm -Rf .cache __pycache__ riak_docker/__pycache__ riak_docker/*.pyc *.pyc

test-pytest-tests: clean install
	docker-compose -f test.yml -p $@ up

include ../../docker.mk
