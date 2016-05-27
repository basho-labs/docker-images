TAG 		?= basho/jenkins-mesos

IMAGES 		= $(shell docker images -qa $(TAG))

MARATHON 	?= localhost:8080

.PHONY = install push deploy clean

defaults.tgz:
	tar zcvf $(@) *.xml init.groovy.d/ nodes/ jobs/

install: defaults.tgz
	docker build -t $(TAG) .

push:
	docker push $(TAG)

deploy:
	curl -XPOST -H "Content-Type: application/json" -d @marathon.json http://$(MARATHON)/v2/apps

clean:
	rm -f defaults.tgz
ifneq (,$(IMAGES))
	docker rmi $(IMAGES)
endif
