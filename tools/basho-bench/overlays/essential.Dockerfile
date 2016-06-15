# Install essential software
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y build-essential git curl
# Needed for results-browser
RUN apt-get install -y python
