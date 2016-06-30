DOCKER_SOCK = -v /var/run/docker.sock:/var/run/docker.sock
WORK_DIR = -v `pwd`:/usr/src/test -w /usr/src/test
BASE_IMG = basho/build-essential:ubuntu-14.04
RUN = docker run --rm -it $(DOCKER_SOCK) $(WORK_DIR) $(BASE_IMG)

.PHONY = clean debug test

clean:
	rm -Rf .cache __pycache__ *.pyc

shell:
	$(RUN) bash
	
debug:
	$(RUN) py.test -v --pdb

test:
	$(RUN) py.test -v --junit-xml=test-report.xml
