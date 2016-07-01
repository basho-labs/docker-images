DOCKER_SOCK = -v /var/run/docker.sock:/var/run/docker.sock
WORK_DIR = -v `pwd`:/usr/src/test -w /usr/src/test
BASE_IMG = basho/build-essential:ubuntu-14.04
CONTAINER_NAME = riak-container-test
RUN = docker run --rm --net riak $(DOCKER_SOCK) $(WORK_DIR) $(CONTAINER_NAME)

.container:
	@echo "Creating network riak"
	docker network create riak
	@echo "Setting up container ${CONTAINER_NAME}"
	docker run --name=$(CONTAINER_NAME) $(BASE_IMG) pip install riak
	docker commit $(CONTAINER_NAME) $(CONTAINER_NAME) >.container

.PHONY = pull build clean dist-clean shell debug test

pull:
	@echo "Pulling latest ${BASE_IMG}"
	docker pull $(BASE_IMG)

clean:
	rm -Rf .cache __pycache__ *.pyc riak_test/*.pyc

dist-clean: clean
	@echo "Removing ${CONTAINER_NAME}"
	docker rm -vf $(CONTAINER_NAME)
	rm -f .container
	@echo "Removing network riak"
	docker network rm riak

shell: .container
	$(RUN) bash

debug: .container
	$(RUN) py.test -v --pdb

test: .container
	$(RUN) py.test -v --junit-xml=test-report.xml
