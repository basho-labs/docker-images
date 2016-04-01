
# Install DCOS
RUN pip install 'dcoscli==0.3.2'

# Set up DCOS user
ENV HOME /var/lib/dcos
RUN adduser -h $HOME -s /bin/bash -D dcos
COPY $CURDIR/bashrc $HOME/.bashrc
RUN mkdir -p /var/cache/dcos /var/tmp

# Configure DCOS
RUN mkdir -p $HOME/.dcos
COPY $CURDIR/dcos.toml $HOME/.dcos
RUN chown -R dcos:dcos $HOME /var/cache/dcos

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
