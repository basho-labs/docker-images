
.PHONY: test clean

test:
	docker-compose -f pytests.yml up --remove-orphans

clean:
	rm -Rf .cache __pycache__ riak_docker/*.pyc *.pyc docker-compose.yml
	docker-compose -f pytests.yml down
