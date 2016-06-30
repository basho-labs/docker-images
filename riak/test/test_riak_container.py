import pytest
from riak import RiakClient, RiakNode
from riak_test.test import cluster

class TestRiakContainer:

  def test_can_start_single_node(self, cluster):
    # Should be 1 node: the coordinator
    assert len(cluster.ips()) == 1
    # Should be able to ping the node on internal IP
    assert RiakClient(nodes=[RiakNode(host=ip) for ip in cluster.ips()]).ping()
