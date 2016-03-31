
# Install base utilities
RUN \
  apk add --update bash git curl jq py-pip openjdk8 && \
  pip install --upgrade pip
