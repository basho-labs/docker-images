
# Install essential software
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -qy apt-transport-https
RUN apt-get install -qy python python-six python-pkg-resources
RUN apt-get install -qy curl
RUN apt-get install -qy libapr1 realpath jq unzip
RUN apt-get install -qy iproute iputils-ping
