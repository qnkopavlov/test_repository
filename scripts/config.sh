BIN_DIR="/usr/local/bin"
DEPENDENCIES="wget"
OUTPUT_FILE="/tmp/provisioning/outputs.txt"

MINIKUBE_DOWNLOAD_URL="https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64"
MINIKUBE_DEPENDENCIES="libvirt qemu-kvm"

KUBECTL_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
KUBECTL_DOWNLOAD_URL="https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl"

JENKINS_DEPENDENCIES="java-1.8.0-openjdk-devel git"
JENKINS_CLI_DIR="/opt/jenkins"
JENKINS_CLI_JAR="${JENKINS_CLI_DIR}/jenkins-cli.jar"
JENKINS_USER="Admin"
JENKINS_PLUGINS="kubernetes"