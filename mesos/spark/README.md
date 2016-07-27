# Spark Image

`basho/spark` is a base image suitable for deploying Spark jobs onto a Mesos cluster without having to download Spark to the slave in the form of a tarball. The default `SPARK_SUBMIT_OPTIONS` for this image contains the options necessary to use this image when submitting Spark jobs to a Mesos cluster using Mesos as the scheduler.

### Usage

If using this image in a long-running Spark application, use Marathon:

```
{
  "id": "/spark-streaming-app",
  "cmd": "spark-submit --verbose --master mesos://leader.mesos:5050 --class com.mycompany.spark.StreamingApp $MESOS_SANDBOX/streaming-app_2.11-1.0.0-assembly.jar",
  "cpus": 1,
  "mem": 2048,
  "container": {
    "type": "DOCKER",
    "docker": {
      "image": "basho/spark",
      "network": "HOST"
    }
  },
  "uris": [
    "https://mycompany.artifactoryonline.com/mycompany/libs-release-local/com/mycompany/spark/streaming-app_2.11/1.0.0/streaming-app_2.11-1.0.0-assembly.jar"
  ]
}
```
