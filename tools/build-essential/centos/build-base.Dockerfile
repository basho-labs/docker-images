# Install Build tools
RUN yum install -y epel-release
RUN yum -q -y groupinstall "Development Tools"
RUN yum -q -y install openssl openssl-devel git wget python-devel libffi-devel python-pip cyrus-sasl-devel cyrus-sasl-lib ca-certificates rubygem-rake ruby-devel jq which
