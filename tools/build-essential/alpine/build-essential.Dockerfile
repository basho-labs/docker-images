# Install Build tools
RUN \
  apk add --no-cache git curl python py-pip gcc musl-dev python-dev libffi-dev openssl openssl-dev bash

RUN \
  pip install --upgrade pip && \
  pip install --upgrade pyopenssl
RUN \
  pip install pytest Jinja2
