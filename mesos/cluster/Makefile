OS                ?= ubuntu
DOCKER_IMAGE_NAME  = mesos_cluster_node
PWD                = $(shell pwd)

.PHONY: all clean start stop restart

all:
	docker build -t ${DOCKER_IMAGE_NAME} -f ${PWD}/overlays/${OS}.Dockerfile ${PWD}/overlays

clean:
	docker ps -a | grep mesos_cluster_ | awk '{print $$1}' | xargs -I {} docker rm -f {}
	docker rmi -f ${DOCKER_IMAGE_NAME} | true
	docker network rm cluster_app_net | true

start: all
	docker-compose -f ${PWD}/cluster.yml up -d

stop:
	docker-compose -f ${PWD}/cluster.yml kill
	docker-compose -f ${PWD}/cluster.yml rm -f --all

restart: stop start

test:
	@echo Running basic cluster test
	@echo
	@echo -n Test zookeepers nodes...
	@nc -z 172.16.200.11 2181
	@nc -z 172.16.200.12 2181
	@nc -z 172.16.200.13 2181
	@echo ok
	@echo -n Test mesos master nodes...
	@curl -f http://172.16.200.21:5050/health
	@curl -f http://172.16.200.22:5050/health
	@curl -f http://172.16.200.23:5050/health
	@echo ok
	@echo -n Test mesos slave nodes...
	@curl -f http://172.16.200.31:5051/health
	@curl -f http://172.16.200.32:5051/health
	@curl -f http://172.16.200.33:5051/health
	@echo ok
	@echo -n Test marathon...
	@curl -f -s -o /dev/null http://172.16.200.41:8080/ping
	@echo ok
	@echo
	@echo Cluster successfully passed tests

