
# Install essential software
RUN apt-get update
RUN apt-get install -qy python python-six python-pkg-resources curl libapr1 realpath jq unzip
