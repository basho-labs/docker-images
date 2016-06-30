import pytest
from riak.test import cluster

class TestRiakContainer:

  def test_can_start_single_node(self, cluster):
    assert len(cluster.ips()) > 0
