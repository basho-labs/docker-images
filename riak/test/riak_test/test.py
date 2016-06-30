import jinja2
import json
import os
import pytest
import subprocess
import sys

class RiakCluster:

  def __init__(self, name):
    self.name = name
    self.env = jinja2.Environment(loader=jinja2.FileSystemLoader(os.path.dirname(__file__)))
    self.tpl = self.env.get_template('docker-compose.yml.tpl')

  def start(self):
    with open('docker-compose.yml', 'w') as yaml:
      yaml.write(self.tpl.render(image=self.name,
                                 schemas_dir="%s/schemas" % os.getcwd()))

    subprocess.call(['docker-compose', 'up', '-d', 'coordinator'])

    for i in self.inspect():
      subprocess.call(['docker', 'exec', i['Id'], 'riak-admin', 'wait-for-service', 'riak_kv'])

  def stop(self):
    subprocess.call(['docker-compose', 'down'])
    subprocess.call(['rm', '-f', 'docker-compose.yml'])

  def ips(self):
    info = self.inspect()
    return [ i['NetworkSettings']['Networks']['riak']['IPAddress'] for i in info ]

  def inspect(self):
    ids = subprocess.check_output(['docker', 'ps', '-q', '-f', "label=com.basho.riak.cluster.name=%s" % os.environ['HOSTNAME']]).strip().split('\n')

    info = []
    for id in ids:
      for i in json.loads(subprocess.check_output(['docker', 'inspect', id])):
        info.append(i)

    return info

  def scale(self, nodes):
    subprocess.call(['docker-compose', 'scale', "member=%i" % nodes])

@pytest.fixture(params=['basho/riak-ts', 'basho/riak-kv'])
def cluster(request):

  cluster = RiakCluster(request.param)
  request.addfinalizer(cluster.stop)
  cluster.start()

  return cluster
