
# Install Build tools
RUN rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-6.noarch.rpm
RUN \
  yum -q -y groupinstall "Development Tools" && \
  yum -q -y install openssl openssl-devel git wget python-devel libffi-devel python-pip cyrus-sasl-devel cyrus-sasl-lib ca-certificates rubygem-rake ruby-devel
RUN \
  pip install --upgrade pip && \
  pip install --upgrade pyopenssl && \
  yum -q -y --exclude=kernel* update
RUN \
  gem install fpm
