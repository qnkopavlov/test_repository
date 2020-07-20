#!/bin/bash -e

source /tmp/provisioning/functions.sh
source /tmp/provisioning/config.sh

yum -y install $MINIKUBE_DEPENDENCIES

systemctl start libvirtd

get_binary kubectl $KUBECTL_DOWNLOAD_URL $BIN_DIR
get_binary minikube $MINIKUBE_DOWNLOAD_URL $BIN_DIR

${BIN_DIR}/minikube start --force

echo "============MINIKUBE DETAILS==============" >> $OUTPUT_FILE

${BIN_DIR}/kubectl cluster-info >> $OUTPUT_FILE