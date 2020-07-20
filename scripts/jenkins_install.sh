#!/bin/bash -e

source /tmp/provisioning/functions.sh
source /tmp/provisioning/config.sh

download http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo /etc/yum.repos.d/jenkins.repo
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key

yum clean all

yum -y install $JENKINS_DEPENDENCIES
yum -y install jenkins

systemctl start jenkins
systemctl enable jenkins
systemctl status jenkins

sleep 60

JENKINS_PASS=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)

if [[ ! -d $JENKINS_CLI_DIR ]]; then
	mkdir -p $JENKINS_CLI_DIR
fi

get_binary jenkins-cli.jar http://localhost:8080/jnlpJars/jenkins-cli.jar $JENKINS_CLI_DIR

java -jar $JENKINS_CLI_JAR \
-s http://localhost:8080/ \
-auth $JENKINS_USER:$JENKINS_PASS \
install-plugin $JENKINS_PLUGINS

echo ":: initial admin password ::" >> $OUTPUT_FILE
echo $JENKINS_PASS >> $OUTPUT_FILE