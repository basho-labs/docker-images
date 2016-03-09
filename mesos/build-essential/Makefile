TAG 		?= basho/build-essential-mesos:14.04-0.26
DOCKER_OPTS 	?=

IMAGES 		= $(shell docker images -qa $(TAG))

.PHONY = install push deploy clean

install: 
	docker build -t $(TAG) $(DOCKER_OPTS) .

push: 
	docker push $(TAG)

clean:
ifneq (,$(IMAGES))
	docker rmi $(IMAGES)
endif
