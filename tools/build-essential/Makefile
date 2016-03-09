TAG 		?= basho/build-essential:ubuntu-trusty

IMAGES 		= $(shell docker images -qa $(TAG))

.PHONY = install push deploy clean

install: 
	docker build -t $(TAG) .

push: 
	docker push $(TAG)

clean:
ifneq (,$(IMAGES))
	docker rmi $(IMAGES)
endif
