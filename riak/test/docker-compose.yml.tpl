version: "2"
services:
  coordinator:
    image: {{ image }}
    ports:
      - "8087"
      - "8098"
    environment:
      - CLUSTER_NAME={{ cluster_name }}
    labels:
      - "com.basho.riak.cluster.name={{ cluster_name }}"
    volumes:
      - {{ schemas_dir }}:/etc/riak/schemas
  member:
    image: {{ image }}
    ports:
      - "8087"
      - "8098"
    labels:
      - "com.basho.riak.cluster.name={{ cluster_name }}"
    links:
      - coordinator
    depends_on:
      - coordinator
    environment:
      - CLUSTER_NAME={{ cluster_name }}
      - COORDINATOR_NODE=coordinator
