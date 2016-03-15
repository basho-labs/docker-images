
# Install OpenJDK 8
RUN yum -q -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel
ENV JAVA_HOME $(realpath /usr/lib/jvm/java-openjdk)
ENV PATH $JAVA_HOME/bin:$PATH
