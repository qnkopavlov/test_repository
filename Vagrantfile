scripts_folder_vm="/tmp/provisioning"
scripts_folder_local="./scripts"
jcasc_folder_vm="/opt/jenkins/jcasc"
jcasc_folder_local="./jcasc"

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  
  config.vm.network "forwarded_port", guest: 8080, host: 8080

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.cpus = 2
    vb.memory = "4096"
    vb.customize ["modifyvm", :id, "--nested-hw-virt", "on"]
  end

  config.vm.provision "file", source: "#{scripts_folder_local}/config.sh", destination: "#{scripts_folder_vm}/config.sh"
  config.vm.provision "file", source: "#{scripts_folder_local}/functions.sh", destination: "#{scripts_folder_vm}/functions.sh"

  # config.vm.provision "file", source: jcasc_folder_local, destination: "/tmp/jcasc"
  # config.vm.provision "shell",
  #   inline: "mkdir -p /opt/jenkins && mv /tmp/jcasc /opt/jenkins/"

  config.vm.provision "shell" do |shell|
  	shell.name = "Preinstall phase"
    shell.path = "#{scripts_folder_local}/preinstall.sh"
  end

  config.vm.provision "shell" do |shell|
  	shell.name = "Installing jenkins and plugins"
    shell.path = "#{scripts_folder_local}/jenkins_install.sh"
  end

  config.vm.provision "shell" do |shell|
    shell.name = "Installing libvirt, minikube and kubectl"
    shell.path = "#{scripts_folder_local}/minikube.sh"
  end

  config.vm.provision "shell" do |shell|
    shell.name = "Configuring Jenkins"
    shell.path = "#{scripts_folder_local}/jenkins_configure.sh"
  end

  config.vm.provision "shell" do |shell|
  	shell.name = "Postinstall phase"
    shell.path = "#{scripts_folder_local}/postinstall.sh"
  end
end
