#!/usr/bin/env python

import argparse
import os
import sys
import re
import urllib2

try:
  import json
except ImportError:
  import simplejson as json

p = argparse.ArgumentParser(description='inventory script that queries a Mesos cluster via Marathon')
grp = p.add_mutually_exclusive_group(required=True)
grp.add_argument('--list', action='store_true', help='list all hosts')
grp.add_argument('--host', help='get meta for specific host')
opts = p.parse_args(sys.argv[1:])

mesosUrl = os.environ.get('MASTER', 'master.mesos:5050')
group = os.environ.get('GROUP', 'mesos')

data = {}
data[group] = []

def get_tasks():
  slaves = json.loads(urllib2.urlopen(('http://%s/slaves' % mesosUrl)).read())

  for s in slaves["slaves"]:
    data[group] += [s["hostname"]]

  data[group] = list(set(data[group]))
  return data

if opts.list:
  print json.dumps(get_tasks())
elif opts.host:
  data = get_tasks()
  print json.dumps({})
else:
  p.print_help()

sys.exit(0)
