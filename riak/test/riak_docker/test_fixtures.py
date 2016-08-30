import json
import os
import pytest
import subprocess
import sys
from riak import RiakClient, RiakNode

"""
This class encapsulates a set of interactions that launches a Riak cluster and allows it to be scaled to an arbitrary number of nodes. Access to the IP addresses which the containers are exposed under is availabe via the RiakCluster.ips() function.
"""
class RiakCluster:

  def __init__(self, flavor):
    self.flavor = flavor
    self.base_args = ['docker-compose', '-f', "/usr/src/%s.yml" % self.flavor, '-p', self.flavor]

  """
  Start a Riak cluster
  """
  def start(self):
    args = self.base_args + ['up', '-d', 'coordinator']
    #print "start: %s" % args
    subprocess.check_call(args)
    self.wait()

  """
  Stop a Riak cluster
  """
  def stop(self):
    args = self.base_args + ['down']
    #print "stop: %s" % args
    subprocess.check_call(args)

  """
  Get the IP addresses of the nodes in the Riak cluster managed by this instance
  """
  def ips(self):
    info = self.inspect()
    ips = [ (i['NetworkSettings']['Networks']).values()[0]['IPAddress'] for i in info ]
    return ips

  """
  Get the Docker info for all the containers managed by this instance
  """
  def inspect(self):
    ids = subprocess.check_output(['docker', 'ps', '-q', '-f', "label=com.basho.riak.cluster.name=%s" % self.flavor]).strip().split('\n')

    info = []
    for id in ids:
      for i in json.loads(subprocess.check_output(['docker', 'inspect', id])):
        info.append(i)

    return info

  """
  Scale a Riak cluster to a given number of nodes
  """
  def scale(self, nodes):
    args = self.base_args + ['scale', "member=%i" % (nodes-1)]
    subprocess.check_call(args)
    self.wait()

  """
  Wait for a Riak cluster to be available
  """
  def wait(self):
    # Wait for all nodes to settle
    for i in self.inspect():
      args = ['docker', 'exec', i['Id'], 'riak-admin', 'wait-for-service', 'riak_kv']
      #print "wait args: %s" % args
      subprocess.check_call(args)

  """
  Create a RiakClient connected to this cluster
  """
  def client(self):
    return RiakClient(nodes=[RiakNode(host=ip) for ip in self.ips()])

@pytest.fixture(params=['riak-ts'])
def cluster(request):

  cluster = RiakCluster(request.param)
  request.addfinalizer(cluster.stop)
  cluster.start()

  return cluster
