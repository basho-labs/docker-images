RUN \
  curl -sSL https://dl.bintray.com/sbt/native-packages/sbt/0.13.12/sbt-0.13.12.tgz | tar -zxf - -C /usr/lib && \
  /usr/lib/sbt/bin/sbt about
ENV SBT_HOME /usr/lib/sbt
ENV PATH $SBT_HOME/bin:$PATH
