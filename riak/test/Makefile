CONTAINER ?= tests
EXISTING = $(shell docker ps -q -a -f ancestor=$(CONTAINER))
DOCKER_RUN = docker-compose -f test.yml up
PYTEST_ARGS ?=

.PHONY: build test clean

build: Dockerfile
	docker build -t $(CONTAINER) .

test: build
	$(DOCKER_RUN) $(CONTAINER) $(PYTEST_ARGS)

shell: build
	$(DOCKER_RUN) --entrypoint=sh $(CONTAINER)

clean:
	rm -Rf .cache __pycache__ riak_docker/__pycache__ riak_docker/*.pyc *.pyc
	[ "$(EXISTING)" == "" ] || docker rm -f $(EXISTING)
