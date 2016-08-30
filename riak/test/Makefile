CONTAINER ?= tests
DOCKER_RUN = docker run --name=$(CONTAINER) --net=riak -it -v /var/run/docker.sock:/var/run/docker.sock -v $(shell realpath ..):/usr/src
PYTEST_ARGS ?=

.PHONY: build test clean

build: Dockerfile
	docker build -t $(CONTAINER) .
	@[ "$(shell docker network inspect -f '{{.Id}}' riak)" != "" ] || docker network create riak

test: build
	$(DOCKER_RUN) $(CONTAINER) $(PYTEST_ARGS)

shell: build
	$(DOCKER_RUN) --entrypoint=sh $(CONTAINER)

clean:
	rm -Rf .cache __pycache__ riak_docker/__pycache__ riak_docker/*.pyc *.pyc
	@[ "$(shell docker ps -q -a -f ancestor=$(CONTAINER))" == "" ] || docker rm -f $(CONTAINER)
