ENV JAVA_PACKAGE        jdk
ENV JAVA_VERSION_MAJOR  8
ENV JAVA_VERSION_MINOR  77
ENV JAVA_VERSION_BUILD  03
ENV JAVA_HOME           /usr/lib/jvm/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}

RUN \
  mkdir -p $JAVA_HOME && \
  curl -jksSL -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz | tar -xzf - -C $JAVA_HOME --strip-components 1 && \
  rm -Rf $JAVA_HOME/*src.zip \
         $JAVA_HOME/lib/missioncontrol \
         $JAVA_HOME/lib/visualvm \
         $JAVA_HOME/lib/*javafx* \
         $JAVA_HOME/jre/bin/javaws \
         $JAVA_HOME/jre/lib/plugin.jar \
         $JAVA_HOME/jre/lib/ext/jfxrt.jar \
         $JAVA_HOME/jre/lib/javaws.jar \
         $JAVA_HOME/jre/lib/desktop \
         $JAVA_HOME/jre/lib/deploy* \
         $JAVA_HOME/jre/lib/*javafx* \
         $JAVA_HOME/jre/lib/*jfx* \
         $JAVA_HOME/jre/lib/amd64/libdecora_sse.so \
         $JAVA_HOME/jre/lib/amd64/libprism_*.so \
         $JAVA_HOME/jre/lib/amd64/libfxplugins.so \
         $JAVA_HOME/jre/lib/amd64/libglass.so \
         $JAVA_HOME/jre/lib/amd64/libgstreamer-lite.so \
         $JAVA_HOME/jre/lib/amd64/libjavafx*.so \
         $JAVA_HOME/jre/lib/amd64/libjfx*.so \
         $JAVA_HOME/jre/plugin
RUN update-alternatives \
  --install /usr/bin/java java $JAVA_HOME/bin/java 1 \
  --slave /usr/bin/javac javac $JAVA_HOME/bin/javac \
  --slave /usr/bin/javadoc javadoc $JAVA_HOME/bin/javadoc \
  --slave /usr/bin/jar jar $JAVA_HOME/bin/jar 
