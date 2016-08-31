RUN apk add --no-cache py-pip docker bash curl
RUN pip install --upgrade pip docker-compose pytest riak

VOLUME /usr/src
WORKDIR /usr/src/test

ENTRYPOINT ["pytest", "-v"]
