### Mesos cluster.
FROM mesos_cluster_node
MAINTAINER Nikolay Khabarov <2xl@mail.ru>

### Environment for erlang.
ENV KERL_DIR=/opt
ENV KERL_VSN=1.3.2
ENV ERL_DIR=/opt/erlang
ENV ERL_VSN="git git://github.com/basho/otp.git OTP_R16B02_basho8"
ENV ERL_BUILD_VSN=r16b02_basho

### Install Erlang deps.
RUN apt-get -y install libncurses5-dev libpam0g-dev
RUN apt-get install -y build-essential autoconf libncurses5-dev openssl \
    libssl-dev fop xsltproc unixodbc-dev libpam0g-dev maven

### Install kerl.
RUN mkdir -p $KERL_DIR
RUN cd ${KERL_DIR} && curl -L -O https://github.com/kerl/kerl/archive/${KERL_VSN}.tar.gz
RUN cd ${KERL_DIR} && tar zxf ${KERL_VSN}.tar.gz -C ${KERL_DIR} && rm ${KERL_VSN}.tar.gz
RUN cd ${KERL_DIR}/kerl-${KERL_VSN} && chmod +x kerl

### Install erlang.
RUN mkdir -p $ERL_DIR
RUN ${KERL_DIR}/kerl-${KERL_VSN}/kerl build ${ERL_VSN} ${ERL_BUILD_VSN}
RUN mkdir ${ERL_DIR}/${ERL_BUILD_VSN}
RUN ${KERL_DIR}/kerl-${KERL_VSN}/kerl install ${ERL_BUILD_VSN} ${ERL_DIR}/${ERL_BUILD_VSN}
RUN echo "export PATH=$PATH:${ERL_DIR}/${ERL_BUILD_VSN}/bin" >> /etc/bash.bashrc

### Copy riak-mesos config.
RUN mkdir -p /etc/riak-mesos
COPY config.json /etc/riak-mesos

### Install riak-mesos tool
RUN apt-get update
RUN apt-get -y install python-pip
RUN pip install --upgrade git+https://github.com/basho-labs/riak-mesos-tools.git@riak-mesos-v1.1.x#egg=riak_mesos
