import pytest
import requests
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

  def test_cluster_has_settled(self, cluster):
    cluster.scale(3)

    for ip in cluster.ips():
      c = requests.get("http://%s:8098/admin/explore/clusters/default/nodes/riak@%s/config" % (ip, ip)).json()

      # Extract ring_size
      ringSize = c['config']['config']['ring_size']

      # Make sure that settings matches ring_size
      assert ringSize == c['config']['config']['vnode_parallel_start']
      assert ringSize == c['config']['config']['forced_ownership_handoff']
      assert ringSize == c['config']['config']['handoff_concurrency']
