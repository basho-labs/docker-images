ARG ARTIFACTORY_VERSION=4.6.1
RUN wget https://bintray.com/artifact/download/jfrog/artifactory/jfrog-artifactory-oss-$ARTIFACTORY_VERSION.zip
RUN unzip -q jfrog-artifactory-oss-$ARTIFACTORY_VERSION.zip
RUN mv artifactory-oss-$ARTIFACTORY_VERSION /opt/artifactory

WORKDIR /opt/artifactory
CMD ["bin/artifactory.sh"]
