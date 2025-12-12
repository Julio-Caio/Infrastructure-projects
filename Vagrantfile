# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "generic/centos8"
  config.vm.box_check_update = false
  config.vm.hostname = "centos8"

  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network "public_network"

  # Provider: VMware Desktop
  config.vm.provider :vmware_desktop do |vmware|
    vmware.utility_certificate_path = "/opt/vagrant-vmware-desktop/certificates/"
    vmware.linked_clone = false
    vmware.gui = false
    vmware.memory = 2048
    vmware.cpus = 2
  end

  config.vm.provision "shell",
    name: "install-dependencies",
    path: "install-dependencies.sh"
end