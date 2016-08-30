import pytest
import httplib
import json
from riak_docker.test_fixtures import cluster

class TestRiakContainer:

  def test_can_start_single_node(self, cluster):
    # Should be 1 node: the coordinator
    assert len(cluster.ips()) == 1

    # Should be able to ping the node on internal IP
    assert cluster.client().ping()

  def test_can_scale_to_three_nodes(self, cluster):
    # Should be 1 node: the coordinator
    assert len(cluster.ips()) == 1

    # Scale to three nodes
    cluster.scale(3)

    # Should be 3 nodes
    assert len(cluster.ips()) == 3

    # Should be able to ping the nodes on internal IP
    assert cluster.client().ping()
