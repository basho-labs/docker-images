
# Install base utilities
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y less curl jq python python-pip git
