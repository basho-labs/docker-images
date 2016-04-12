
ARG ERLANG_URL
ENV ERLANG_HOME=/usr/lib/erlang

RUN \
  mkdir -p $ERLANG_HOME && \
  curl -sSL $ERLANG_URL | tar zxf - -C $ERLANG_HOME

ENV update-alternatives \
  --install /usr/bin/erl erl $ERLANG_HOME/bin/erl 1 \
  --slave /usr/bin/erlc erlc $ERLANG_HOME/bin/erlc \
  --slave /usr/bin/escript escript $ERLANG_HOME/bin/escript \
  --slave /usr/bin/ct_run ct_run $ERLANG_HOME/bin/ct_run \
  --slave /usr/bin/dialyzer dialyzer $ERLANG_HOME/bin/dialyzer \
  --slave /usr/bin/epmd epmd $ERLANG_HOME/bin/epmd \
  --slave /usr/bin/run_erl run_erl $ERLANG_HOME/bin/run_erl \
  --slave /usr/bin/to_erl to_erl $ERLANG_HOME/bin/to_erl \
  --slave /usr/bin/typer typer $ERLANG_HOME/bin/typer
