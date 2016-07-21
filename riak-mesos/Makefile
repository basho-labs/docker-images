OS                              ?= ubuntu
MESOS_CLUSTER_DOCKER_IMAGE_NAME  = mesos_cluster_node
DOCKER_IMAGE_NAME                = riak_mesos_cluster_node
PWD                              = $(shell pwd)

.PHONY: all clean start stop restart update-head

all: .update-head
	docker build -t ${MESOS_CLUSTER_DOCKER_IMAGE_NAME} -f ${PWD}/../mesos/cluster/overlays/${OS}.Dockerfile ${PWD}/../mesos/cluster/overlays
	docker build -t ${DOCKER_IMAGE_NAME} -f ${PWD}/overlays/${OS}.Dockerfile ${PWD}/overlays

clean:
	docker ps -a | grep riak_mesos_cluster_ | awk '{print $$1}' | xargs -I {} docker rm -f {}
	docker rmi -f ${DOCKER_IMAGE_NAME} | true
	docker rmi -f ${MESOS_CLUSTER_DOCKER_IMAGE_NAME} | true
	docker network rm cluster_app_net | true

start: all
	docker-compose -f ${PWD}/cluster.yml up -d

stop:
	docker-compose -f ${PWD}/cluster.yml kill
	docker-compose -f ${PWD}/cluster.yml rm -f --all

restart: stop start

update-head:
	git submodule update --init --recursive

.update-head: update-head
	touch .update-head

test:
	@echo Running basic cluster test
	@echo
	@echo -n Test zookeepers nodes...
	@nc -z 172.16.100.11 2181
	@nc -z 172.16.100.12 2181
	@nc -z 172.16.100.13 2181
	@echo ok
	@echo -n Test mesos master nodes...
	@curl -f http://172.16.100.21:5050/health
	@curl -f http://172.16.100.22:5050/health
	@curl -f http://172.16.100.23:5050/health
	@echo ok
	@echo -n Test mesos slave nodes...
	@curl -f http://172.16.100.31:5051/health
	@curl -f http://172.16.100.32:5051/health
	@curl -f http://172.16.100.33:5051/health
	@echo ok
	@echo -n Test marathon...
	@curl -f -s -o /dev/null http://172.16.100.41:8080/ping
	@echo ok
	@echo -n Test mesos-dns...
	@docker exec -i -t mesos_cluster_marathon ping -c 1 marathon.mesos > /dev/null
	@echo ok
	@echo
	@echo Cluster successfully passed tests

