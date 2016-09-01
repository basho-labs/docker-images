TAG = cluster-convergence
FROM = basho/riak-ts
CLUSTER_CONVERGENCE ?= fast

.PHONY: test-cluster-convergence

clean::
	docker rm -f `docker ps -a -q -f ancestor=$(TAG)`

test-cluster-convergence: clean install
	COORDINATOR=`docker run --name=$(TAG) -d -e CLUSTER_CONVERGENCE=$(CLUSTER_CONVERGENCE) $(TAG)`; \
	docker exec $(TAG) riak-admin wait-for-service riak_kv; \
	CONFIG=`docker exec -i $(TAG) riak config effective | egrep vnode_parallel_start`; \
	[[ "$$CONFIG" =~ "vnode_parallel_start,64" ]]

-include ../../docker.mk
