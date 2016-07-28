TARGET_OS ?= alpine-3.4

TAG = test-erlang-container
FROM = basho/erlang:$(TARGET_OS)
OVERLAYS = greeting
CMD = ["/tmp/greeting.sh"]

test-escript: clean install
	GREETING=`docker run --rm -i $(TAG)`; \
	[ "hello world" = "$$GREETING" ]

-include ../../../docker.mk
