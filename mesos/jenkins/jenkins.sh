#! /bin/bash

set -e

# Copy files from /usr/share/jenkins/ref into $JENKINS_HOME
# So the initial JENKINS-HOME is set with expected content.
# Don't override, as this is just a reference setup, and use from UI
# can then change this, upgrade plugins, etc.
copy_reference_file() {
	f="${1%/}"
	b="${f%.override}"
	echo "$f" >> "$COPY_REFERENCE_FILE_LOG"
	rel="${b:23}"
	dir=$(dirname "${b}")
	echo " $f -> $rel" >> "$COPY_REFERENCE_FILE_LOG"
	if [[ ! -e $JENKINS_HOME/${rel} || $f = *.override ]]
	then
		echo "copy $rel to JENKINS_HOME" >> "$COPY_REFERENCE_FILE_LOG"
		mkdir -p "$JENKINS_HOME/${dir:23}"
		cp -r "${f}" "$JENKINS_HOME/${rel}";
		# pin plugins on initial copy
		[[ ${rel} == plugins/*.jpi ]] && touch "$JENKINS_HOME/${rel}.pinned"
	fi;
}
: ${JENKINS_HOME:="/var/jenkins_home"}
export -f copy_reference_file
touch "${COPY_REFERENCE_FILE_LOG}" || (echo "Can not write to ${COPY_REFERENCE_FILE_LOG}. Wrong volume permissions?" && exit 1)

if [ "x$USE_PERSISTENT_JENKINS_HOME" == "x" ]; then
	rm -f $JENKINS_HOME/.USE_PERSISTENT_JENKINS_HOME
	echo "--- Copying files at $(date)" >> "$COPY_REFERENCE_FILE_LOG"
	find /usr/share/jenkins/ref/ -type f -exec bash -c "copy_reference_file '{}'" \;
	sed -i "s#\${JENKINS_CONFIG_REPO}#$JENKINS_CONFIG_REPO#g" $JENKINS_HOME/scm-sync-configuration.xml
	cp -R $MESOS_SANDBOX/.ssh $JENKINS_HOME/.ssh
elif [ ! -f $JENKINS_HOME/.USE_PERSISTENT_JENKINS_HOME ]; then
	echo "--- Copying files at $(date)" >> "$COPY_REFERENCE_FILE_LOG"
	find /usr/share/jenkins/ref/ -type f -exec bash -c "copy_reference_file '{}'" \;
	sed -i "s#\${JENKINS_CONFIG_REPO}#$JENKINS_CONFIG_REPO#g" $JENKINS_HOME/scm-sync-configuration.xml
	cp -R $MESOS_SANDBOX/.ssh $JENKINS_HOME/.ssh
	touch $JENKINS_HOME/.USE_PERSISTENT_JENKINS_HOME
fi

if [ [ ! -f $JENKINS_HOME/.gitconfig ] -a [ -f $JENKINS_HOME/gitconfig ] ]; then
	mv -f $JENKINS_HOME/gitconfig $JENKINS_HOME/.gitconfig
fi

# if `docker run` first argument start with `--` the user is passing jenkins launcher arguments
if [[ $# -lt 1 ]] || [[ "$1" == "--"* ]]; then
  eval "exec java $JAVA_OPTS -jar /usr/share/jenkins/jenkins.war $JENKINS_OPTS \"\$@\""
else
# As argument is not jenkins, assume user want to run his own process, for sample a `bash` shell to explore this image
  exec "$@"
fi
