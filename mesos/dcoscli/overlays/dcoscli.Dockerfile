
# Install DCOS
RUN pip install 'dcoscli==0.3.5'

# Set up DCOS user
ENV HOME /var/lib/dcos
RUN adduser -h $HOME -s /bin/bash -D dcos
COPY $CURDIR/bashrc $HOME/.bashrc

# Configure DCOS
RUN mkdir -p $HOME/.dcos
COPY $CURDIR/dcos.toml $HOME/.dcos/
RUN chown -R dcos:dcos $HOME

USER dcos

# Install base utilties to get cli commands
RUN \
  dcos package update && \
  dcos package install --cli --yes kafka && \
  dcos package install --cli --yes riak

# Set up ENTRYPOINT
# ENTRYPOINT ["dcos"]
ENTRYPOINT ["bash", "-i"]
