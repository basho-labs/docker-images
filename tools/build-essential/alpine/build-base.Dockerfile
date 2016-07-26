RUN apk add --no-cache build-base openssh-client openssl openssl-dev git curl wget python-dev libffi-dev py-pip cyrus-sasl cyrus-sasl-dev ca-certificates ruby-rake ruby-dev ruby-rdoc jq which tar bash

{{get "https://raw.githubusercontent.com/frol/docker-alpine-glibc/master/Dockerfile" 3}}
