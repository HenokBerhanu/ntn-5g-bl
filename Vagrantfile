# -*- mode: ruby -*-
# vi: set ft=ruby :
# About: Vagrant file for the development environment

###############
#  Variables  #
###############

CPUS = 6
RAM = 16384
BOX = "ubuntu/focal64"
VM_NAME = "blntn"

####################
#  Vagrant Config  #
####################

Vagrant.configure("2") do |config|

  # For nr_ntn testbed
  config.vm.define "blntn" do |blntn|
    blntn.vm.box = BOX
   # ntn.disksize.size = "100GB"

    # For Virtualbox provider
    blntn.vm.provider "virtualbox" do |vb|
      vb.name = VM_NAME
      vb.cpus = CPUS
      vb.memory = RAM
      # MARK: The vCPUs should have SSE4 to compile DPDK applications.
      vb.customize ["setextradata", :id, "VBoxInternal/CPUM/SSE4.1", "1"]
      vb.customize ["setextradata", :id, "VBoxInternal/CPUM/SSE4.2", "1"]
    end
    blntn.vm.synced_folder ".", "/vagrant", disabled: false
    blntn.vm.hostname = "blntn"
    blntn.vm.box_check_update = true

    # VM networking
    blntn.vm.network "forwarded_port", guest: 8888, host: 8888, host_ip: "127.0.0.1"
    blntn.vm.network "forwarded_port", guest: 8082, host: 8082
    blntn.vm.network "forwarded_port", guest: 8083, host: 8083
    blntn.vm.network "forwarded_port", guest: 8084, host: 8084

    # - Uncomment the underlying line to add a private network to the VM.
    #   If VirtualBox is used as the hypervisor, this means adding or using (if already created) a host-only interface to the VM.
    blntn.vm.network "private_network", ip: "192.168.56.100"
    # ntn.vm.network "private_network", ip: "10.10.1.2", virtualbox__intnet: true
    
    # Enable X11 forwarding
    config.ssh.forward_x11 = true
    config.ssh.forward_agent = true
  end
end
