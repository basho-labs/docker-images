# build-essential

This `Makefile` facilitates building a Docker image for use in CI systems where you need to build software. It uses [docker.mk](https://github.com/jbrisbin/docker.mk) to generate the `Dockerfile` and build the image which means you can create a nearly identical image for Ubuntu or CentOS by setting the appropriate flag.

Built into the `Makefile` is the ability to add Java by just setting a version flag.

### Building an image

To build an image, use the `make` utility. By default, a Ubuntu 14.04 (trusty) image will be built that includes OpenJDK 8.

The following builds a `Dockerfile` from the overlays declared in the `Makefile` and loaded from the `ubuntu` overlay directory and does a `docker build` using the tag declared in `TAG`.

    $ TAG=my.private.repo/build-essential:ubuntu make install

To push this image to your private repo (declared above with `my.private.repo`), do a `make push`:

    $ make push

The following cleans out any previously-generated `Dockerfile` and re-builds the image for CentOS but loading the same overlays as it would for the Ubuntu image, but this time it loads those files from the `centos` directory (in `docker.mk` parlance, we set the `OVERLAYS_DIR` to the `OS_FAMILY`).

    $ TARGET_OS=centos:7 TAG=my.private.repo/build-essential:centos make clean install push
