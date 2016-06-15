# Jenkins on Mesos

Jenkins is deployed on Mesos using a Docker image deployed through Marathon. The image contains some basic configuration and an init script that produces a fully-functioning server, including connected build slaves, OOTB.

### Building the image

First check out the source from GitHub so you can modify the base config to suit your deployment scenario:

```
$ git clone git@github.com:basho-labs/docker-images.git
$ cd docker-images/mesos/jenkins
$ vi Dockerfile
... edit default/base configs ...
```

The included `Makefile` should be used to build the Docker image. It creates a file called `defaults.tgz` that contains all the default configuration and init scripts. The `install` target will build the Docker image using the value of the `TAG` env variable (by default "basho/jenkins-mesos").

The default password for the `jenkins` user is set in the `Dockerfile` in this line:

```
# Set user password
RUN usermod -G shadow -a -p 4Dm3fH39Geavs jenkins
```

To set the value to your own pre-installed password, pre-encode it using `openssl passwd`. Just replace "newpasswd" in the following command with your own password:

```
$ echo newpasswd | openssl passwd -stdin
JWiPlEoKa1Z3c
```

Replace the string "4Dm3fH39Geavs" in the `Dockerfile` with the output from the `openssl passwd` command.

#### Build

```
$ TAG=jenkins make clean install
rm -f defaults.tgz
docker rmi efdd7594d810
Untagged: jenkins:latest
Deleted: sha256:efdd7594d810f962c2e41827b3249ddb6a66195d60be2f383082710346bf44a9
...
tar zcvf defaults.tgz *.xml init.groovy.d/
a config.xml
a credentials.xml
...
docker build -t jenkins .
Sending build context to Docker daemon 70.14 kB
Step 1 : FROM jenkinsci/jenkins:2.8
2.8: Pulling from jenkinsci/jenkins
...
```

### Deploying the image

The image is deployed to Mesos with Marathon. An example `marathon.json` file exists in the source repository.

The main value to change in the `marathon.json` is the env var `JENKINS_CONFIG_REPO`, which should be set to an `org/repo` where the Jenkins configuration will be backed up. If using an existing repository, know that once the Jenkins server is running, you'll have to visit the configuration page and reload everything from SCM using the provided link.

#### SSH keys

Note that the provided JSON assumes that slaves have a user dedicated to Jenkins named `jenkins` and that a valid SSH key (that can access source repositories on GitHub) is contained in a `.tar.gz` file located in `/home/jenkins/` and named `ssh.tar.gz`. This file will be copied into the Jenkins server's `/var/jenkins_home` directory and will be used as the SSH key when syncing configuration and checking out source code.

After making any necessary changes, submit the JSON to Marathon (these commands assume the hostnames `master.mesos`, `leader.mesos`, and `marathon.mesos` are all resolvable, either from DNS or as `/etc/hosts` entries):

```
$ curl -s -XPOST -H 'Content-Type: application/json' -d@marathon.json 'marathon.mesos:8080/v2/apps' | jq '.'
```

You can open the Jenkins dashboard by navigating to Marathon's UI ([http://marathon.mesos:8080/](http://marathon.mesos:8080/)) or by discovering it via Marathon's REST API and `jq`:

```
$ export JENKINS_URL=http://$(curl -s marathon.mesos:8080/v2/tasks | jq -r '.tasks[] | select(.appId == "/jenkins/build/master") | .host + ":" + (.ports[0] | tostring)')/
$ open $JENKINS_URL
```

### Configuring

Once you have a running Jenkins server, it will be necessary to add credentials to services like GitHub and Artifactory, which the image assumes you'll be using to get source code and publish artifacts to. The OSS version of Artifactory is fine for most things and can also be run in Mesos with a simple `marathon.json` like this one:

```
{
  "id": "/artifactory",
  "cpus": 1,
  "mem": 8192,
  "instances": 1,
  "container": {
    "type": "DOCKER",
    "docker": {
      "image": "jfrog-docker-reg2.bintray.io/jfrog/artifactory-oss",
      "network": "BRIDGE",
      "portMappings": [
        { "containerPort": 8081, "hostPort": 0, "protocol": "tcp" }
      ]
    }
  },
  "healthChecks": [
    {
      "path": "/",
      "portIndex": 0,
      "protocol": "HTTP",
      "gracePeriodSeconds": 300,
      "intervalSeconds": 300,
      "timeoutSeconds": 300,
      "maxConsecutiveFailures": 25,
      "ignoreHttp1xx": false
    }
  ]
}
```

After visiting `$JENKINS_URL/configure` and setting any values needed, you should have a working Jenkins server that's ready to start creating build jobs.

## Builds
