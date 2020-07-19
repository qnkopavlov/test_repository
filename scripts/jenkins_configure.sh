#!/bin/bash -e

source /tmp/provisioning/config.sh

MINIKUBE_URL=$(grep server /root/.kube/config | cut -f 2,3,4 -d ':')
KUBE_CONFIG_BYTES=$(cat /root/.kube/config | base64 -w 0)
JENKINS_URL=http://localhost:8080

if [[ ! -d $JCASC_FOLDER ]]; then
    mkdir -p $JCASC_FOLDER
fi

chmod -R 755 ~/.minikube

echo -e "unclassified:
  location:
    url: ${JENKINS_URL}

jenkins:
  clouds:
    - kubernetes:
        name: advanced-k8s-config
        serverUrl:${MINIKUBE_URL}
        skipTlsVerify: true
        credentialsId: kubernetes-credentials
        namespace: default
        jenkinsUrl: ${JENKINS_URL}
        jenkinsTunnel: jenkinsTunnel
        containerCapStr: 42
        maxRequestsPerHostStr: 64
        retentionTimeout: 5
        connectTimeout: 10
        readTimeout: 20

        templates:
          # - name: test_template
          #   serviceAccount: serviceAccount
          #   instanceCap: 1234
          #   idleMinutes: 0
          #   label: label
          #   volumes:
          #     - hostPathVolume:
          #         mountPath: mountPath
          #         hostPath: hostPath

          #   containers:
          #     - name: test_container
          #       image: centos:7
          #       privileged: true
          #       alwaysPullImage: true
          #       command: cat
          #       args: args
          #       workingDir: workingDir
          #       ttyEnabled: true
          #       resourceRequestCpu: resourceRequestCpu
          #       resourceRequestMemory: resourceRequestMemory
          #       resourceLimitCpu: resourceLimitCpu
          #       resourceLimitMemory: resourceLimitMemory
          #   imagePullSecrets:
          #     - name: imagePullSecrets

          #   envVars:
          #     - envVar:
          #         key: FOO
          #         value: BAR

          - name: k8s-slave
            namespace: default
            label: linux-x86_64
            nodeUsageMode: EXCLUSIVE
            containers:
              - name: jnlp
                image: jenkinsci/jnlp-slave:latest
                alwaysPullImage: true
                workingDir: /home/jenkins
                ttyEnabled: true
                resourceRequestCpu: 500m
                resourceLimitCpu: 1000m
                resourceRequestMemory: 1Gi
                resourceLimitMemory: 2Gi
            volumes:
              - emptyDirVolume:
                  memory: false
                  mountPath: /tmp
            idleMinutes: 1
            activeDeadlineSeconds: 120
            slaveConnectTimeout: 1000" > ${JCASC_FOLDER}/kubernetes.yaml

echo -e "credentials:
  system:
    domainCredentials:
      - credentials:
          - file:
              scope: GLOBAL
              id: "kubernetes-credentials"
              fileName: kubeconfig
              secretBytes: ${KUBE_CONFIG_BYTES}" > ${JCASC_FOLDER}/kubernetes-credentials.yaml