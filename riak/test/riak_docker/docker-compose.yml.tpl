version: "2"
services:
  coordinator:
    image: {{ image }}
    tty: true
    ports:
      - "8087"
      - "8098"
    environment:
      - CLUSTER_NAME=${HOSTNAME}
    labels:
      - "com.basho.riak.cluster.name=${HOSTNAME}"
    volumes:
      - {{ schemas_dir }}:/etc/riak/schemas
  member:
    image: {{ image }}
    tty: true
    ports:
      - "8087"
      - "8098"
    labels:
      - "com.basho.riak.cluster.name=${HOSTNAME}"
    links:
      - coordinator
    depends_on:
      - coordinator
    environment:
      - CLUSTER_NAME=${HOSTNAME}
      - COORDINATOR_NODE=coordinator

volumes:
  schemas: {}
