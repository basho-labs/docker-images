import pytest
from riak import RiakClient, RiakNode
from riak_test.test import cluster

class TestRiakContainer:

  def test_can_start_single_node(self, cluster):

    assert len(cluster.ips()) == 1

    print ("nodes: %s" % [ RiakNode(host=ip[0], pbc_port=ip[1]) for ip in cluster.ips() ])

    cl = RiakClient(nodes=[ RiakNode(host=ip[0], pbc_port=ip[1]) for ip in cluster.ips() ])
    # assert cl.ping()
