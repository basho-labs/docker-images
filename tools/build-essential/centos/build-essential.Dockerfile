
# Install Build tools
RUN \
  yum -qy groupinstall "Development Tools" && \
  yum -qy install openssl openssl-devel git wget python-devel cyrus-sasl-devel cyrus-sasl-lib ca-certificates.noarch && \
  yum -qy --exclude=kernel* update
