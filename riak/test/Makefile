TAG = basho/riak-container-test
RUN = docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v `pwd`:/usr/src/test $(TAG)

.PHONY = clean debug test

clean:
	rm -Rf .cache __pycache__
	docker rm $(docker images -q basho/riak-container-test)

debug:
	$(RUN) --pdb

test:
	$(RUN)
