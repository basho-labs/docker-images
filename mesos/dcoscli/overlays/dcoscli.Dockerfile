
# Install DCOS
RUN pip install --upgrade pip
RUN pip install 'dcoscli==0.3.2'

# Set up DCOS user
ENV HOME /var/lib/dcos
RUN useradd -d $HOME -s /bin/bash dcos
COPY $CURDIR/bashrc $HOME/.bashrc

# Configure DCOS
RUN mkdir -p $HOME/.dcos /etc/riak-mesos /var/cache/dcos
COPY $CURDIR/dcos.toml $HOME/.dcos
RUN chown -R dcos:dcos $HOME /var/cache/dcos /etc/riak-mesos

COPY $CURDIR/dcos.sh /
RUN chmod 0755 /dcos.sh

USER dcos

# Install base utilties to get cli commands
RUN dcos package update
RUN \
  dcos package install --cli --yes kafka && \
  dcos package install --cli --yes riak

# Set up ENTRYPOINT
ENTRYPOINT ["/dcos.sh"]
