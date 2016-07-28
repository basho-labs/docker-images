RUN apk add --no-cache build-base openssh-client openssl openssl-dev git curl wget python-dev libffi-dev py-pip cyrus-sasl cyrus-sasl-dev ca-certificates ruby-rake ruby-dev ruby-rdoc jq which tar bash
RUN curl -sSL -o /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub
RUN curl -sSL -O https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk
RUN apk add glibc-2.23-r3.apk
