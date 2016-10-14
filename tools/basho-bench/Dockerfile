FROM centos:7
MAINTAINER Travis B. Hartwell <thartwell@contractor.basho.com>

# overlay: overlays/essential.Dockerfile 
RUN yum install -y epel-release
RUN yum -q -y update
RUN yum -q -y upgrade
RUN yum -q -y groupinstall "Development Tools"
RUN yum -q -y install openssl openssl-devel git wget python-devel libffi-devel python-pip cyrus-sasl-devel cyrus-sasl-lib ca-certificates jq which
# overlay: overlays/erlang.Dockerfile 
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
# overlay: overlays/basho-bench.Dockerfile 
ARG BASHO_BENCH_BRANCH=master

RUN git clone git://github.com/basho/basho_bench.git -b $BASHO_BENCH_BRANCH /opt/basho_bench
RUN cd /opt/basho_bench && make locked-deps && make all
