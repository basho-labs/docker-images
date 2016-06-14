FROM ubuntu:trusty
MAINTAINER Travis B. Hartwell <thartwell@contractor.basho.com>
ENV \
  DEBIAN_FRONTEND=noninteractive \
  DEBCONF_NONINTERACTIVE_SEEN=true
# Install essential software
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y build-essential git curl
ARG ERLANG_URL
ENV ERLANG_HOME=/usr/lib/erlang

RUN \
  mkdir -p $ERLANG_HOME && \
  curl -sSL $ERLANG_URL | tar zxf - -C $ERLANG_HOME

RUN update-alternatives \
  --install /usr/bin/erl erl $ERLANG_HOME/bin/erl 1 \
  --slave /usr/bin/erlc erlc $ERLANG_HOME/bin/erlc \
  --slave /usr/bin/escript escript $ERLANG_HOME/bin/escript \
  --slave /usr/bin/ct_run ct_run $ERLANG_HOME/bin/ct_run \
  --slave /usr/bin/dialyzer dialyzer $ERLANG_HOME/bin/dialyzer \
  --slave /usr/bin/epmd epmd $ERLANG_HOME/bin/epmd \
  --slave /usr/bin/run_erl run_erl $ERLANG_HOME/bin/run_erl \
  --slave /usr/bin/to_erl to_erl $ERLANG_HOME/bin/to_erl \
  --slave /usr/bin/typer typer $ERLANG_HOME/bin/typer
ARG BASHO_BENCH_BRANCH=master

RUN git clone git://github.com/basho/basho_bench.git -b $BASHO_BENCH_BRANCH /opt/basho_bench
RUN cd /opt/basho_bench && make all
