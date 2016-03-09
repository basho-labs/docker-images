FROM jenkinsci/jenkins
MAINTAINER Jon Brisbin <jbrisbin@basho.com>

USER root

# Set user password 
RUN usermod -G shadow -a -p 4Dm3fH39Geavs jenkins
RUN echo "StrictHostKeyChecking no" >>/etc/ssh/ssh_config

# Install basic utilities
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates git curl wget vim
RUN rm -Rf /var/lib/apt/*

USER jenkins
ENV REF_DIR /usr/share/jenkins/ref

COPY defaults.tgz /
RUN tar -zxf /defaults.tgz -C $REF_DIR

COPY plugins.txt $REF_DIR/
RUN /usr/local/bin/plugins.sh $REF_DIR/plugins.txt

