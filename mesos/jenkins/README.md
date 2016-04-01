# Jenkins on Mesos

This directory contains the files necessary to generate a Docker image for running [Jenkins](https://jenkins-ci.org/) on [Apache Mesos](http://mesos.apache.org/) with some useful default configuration and jobs pre-installed.

### Building an Image

Included in this repo is a helper `Makefile` for building the image. You can set the tag for the image by setting the `TAG` variable:

    $ TAG=my.private.repo/jenkins-mesos make install
