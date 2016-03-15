
# Install OpenJDK 8
RUN yum -q -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel
ENV JAVA_HOME /usr/lib/jvm/java-openjdk
