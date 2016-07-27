ARG SBT_VERSION=0.13.11

RUN curl -sSL --retry 3 "http://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz" | tar -xz -C /usr/lib && \
  /usr/lib/sbt/bin/sbt about

ENV SBT_HOME /usr/lib/sbt
ENV PATH $SBT_HOME/bin:$PATH
