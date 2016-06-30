DOCKER_SOCK = -v /var/run/docker.sock:/var/run/docker.sock
WORK_DIR = -v `pwd`:/usr/src/test -w /usr/src/test
BASE_IMG = basho/build-essential:ubuntu-14.04
RUN = docker run --rm -it --net riak $(DOCKER_SOCK) $(WORK_DIR) $(BASE_IMG)

.PHONY = pull build clean shell debug test

pull:
	docker pull $(BASE_IMG)

build:
	docker network create riak
	docker run --name=riak-container-test $(BASE_IMG) pip install riak
	docker commit riak-container-test $(BASE_IMG)

clean:
	rm -Rf .cache __pycache__ *.pyc riak_test/*.pyc

dist-clean:
	docker rm -vf riak-container-test
	docker network rm riak

shell:
	$(RUN) bash

debug:
	$(RUN) py.test -v --pdb

test:
	$(RUN) py.test -v --junit-xml=test-report.xml
