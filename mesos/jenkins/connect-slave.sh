#!/bin/bash
curl -sSL -XPOST -H "Content-Type: application/json" -d @- "http://marathon.mesos:8080/v2/apps" <<END
{
  "id": "/jenkins/build/$2",
  "cpus": 1,
  "mem": 4096,
  "instances": 1,
  "cmd": "java -jar slave.jar -jnlpUrl http://$1/computer/$2/slave-agent.jnlp -secret $3",
  "uris": [
    "http://$1/jnlpJars/slave.jar"
  ]
}
END
