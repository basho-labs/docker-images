
# Install Build tools
RUN \
  yum -q -y groupinstall "Development Tools" && \
  yum -q -y install openssl openssl-devel git wget python-devel python-pip cyrus-sasl-devel cyrus-sasl-lib ca-certificates.noarch 
RUN \
  pip install --upgrade pip && \
  yum -q -y --exclude=kernel* update
