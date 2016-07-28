import jinja2
import json
import os
import pytest
import subprocess
import sys

"""
This class encapsulates a set of interactions that launches a Riak cluster and allows it to be scaled to an arbitrary number of nodes. Access to the IP addresses which the containers are exposed under is availabe via the RiakCluster.ips() function.
"""
class RiakCluster:

  def __init__(self, name):
    self.name = name
    self.env = jinja2.Environment(loader=jinja2.FileSystemLoader(os.path.dirname(__file__)))
    self.tpl = self.env.get_template('docker-compose.yml.tpl')

  """
  Start a Riak cluster
  """
  def start(self):
    with open('docker-compose.yml', 'w') as yaml:
      yaml.write(self.tpl.render(image=self.name,
                                 schemas_dir="%s/schemas" % os.getcwd()))

    subprocess.call(['docker-compose', 'up', '-d', 'coordinator'])
    self.wait()

  """
  Stop a Riak cluster
  """
  def stop(self):
    subprocess.call(['docker-compose', 'down'])
    subprocess.call(['rm', '-f', 'docker-compose.yml'])

  """
  Get the IP addresses of the nodes in the Riak cluster managed by this instance
  """
  def ips(self):
    info = self.inspect()
    return [ i['NetworkSettings']['Networks']['riak']['IPAddress'] for i in info ]

  """
  Get the Docker info for all the containers managed by this instance
  """
  def inspect(self):
    ids = subprocess.check_output(['docker', 'ps', '-q', '-f', "label=com.basho.riak.cluster.name=%s" % os.environ['HOSTNAME']]).strip().split('\n')

    info = []
    for id in ids:
      for i in json.loads(subprocess.check_output(['docker', 'inspect', id])):
        info.append(i)

    return info

  """
  Scale a Riak cluster to a given number of nodes
  """
  def scale(self, nodes):
    subprocess.call(['docker-compose', 'scale', "member=%i" % (nodes-1)])
    self.wait()

  """
  Wait for a Riak cluster to be available
  """
  def wait(self):
    # Wait for all nodes to settle
    for i in self.inspect():
      subprocess.call(['docker', 'exec', i['Id'], 'riak-admin', 'wait-for-service', 'riak_kv'])

@pytest.fixture(params=['basho/riak-ts', 'basho/riak-kv'])
def cluster(request):

  cluster = RiakCluster(request.param)
  request.addfinalizer(cluster.stop)
  cluster.start()

  return cluster
