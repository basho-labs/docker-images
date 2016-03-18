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

marathonUrl = os.environ.get('MARATHON_URL', 'http://marathon.mesos:8080')
regex = re.compile(os.environ.get('APP_ID', '.*'))
group = os.environ.get('GROUP', 'mesos')

data = {"_meta": {"hostvars": {}}}
data[group] = []

def get_tasks():
  tasks = json.loads(urllib2.urlopen(('%s/v2/tasks' % marathonUrl)).read())
  appInfo = json.loads(urllib2.urlopen(('%s/v2/apps' % marathonUrl)).read())

  for t in tasks["tasks"]:
    if regex.match(t["appId"]):
      host = t["host"]
      appId = t["appId"]
      data[group] += [host]
      data["_meta"]["hostvars"][host] = {"appId": appId, "marathonUrl": marathonUrl}
  data[group] = list(set(data[group]))

  for h in data[group]:
    for ai in appInfo["apps"]:
      if ai["id"] == data["_meta"]["hostvars"][h]["appId"]:
        for (k, v) in ai["env"]:
          data["_meta"]["hostvars"][h][k] = v
  return data

if opts.list:
	print json.dumps(get_tasks())
elif opts.host:
  data = get_tasks()
  print json.dumps(data["_meta"]["hostvars"][opts.host])
else:
	p.print_help()

sys.exit(0)

