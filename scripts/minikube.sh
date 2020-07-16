#!/bin/bash -e

source /tmp/functions.sh
source /tmp/config.sh

yum -y install $MINIKUBE_DEPENDENCIES

systemctl start libvirtd

get_binary kubectl $KUBECTL_DOWNLOAD_URL $BIN_DIR
get_binary minikube $MINIKUBE_DOWNLOAD_URL $BIN_DIR

${BIN_DIR}/minikube start --force