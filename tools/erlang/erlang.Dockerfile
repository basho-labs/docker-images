ENV \
  ERLANG_HOME=/usr/lib/erlang \
  PATH=$ERLANG_HOME/bin:$PATH
RUN mkdir -p $ERLANG_HOME
ARG OS_TAG
RUN curl -sS "https://basholabs.artifactoryonline.com/basholabs/build/${OS_TAG}/erlang/OTP_R16B02_basho10/erlang-OTP_R16B02_basho10.tgz" | tar -zxf - -C "$ERLANG_HOME"
