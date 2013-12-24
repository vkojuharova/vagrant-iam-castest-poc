# -*- mode: ruby -*-
# vi: set ft=ruby :

if ENV['VAGRANT_DEFAULT_PROVIDER'] == "aws" then
  Vagrant.require_plugin 'aws'
end

#Vagrant.configure("1") do |config|
# Enabling a bridged Network
#  config.vm.network :bridged
# end


Vagrant.configure('2') do |config|
  config.vm.box = 'puppetlabs-centos-64-x64'
# Enabling a bridged Network with this version.
# It is likely that public networks will be replaced by :bridged in a future release,
# since that is in general what should be done with public networks, and providers that
# don't support bridging generally don't have any other features that map to public networks either.
#  config.vm.network "public_network"

# Cisco AnyConnect Secure Mobility Client Virtual Miniport Adapter for Windows x64


  # Puppet Labs CentOS 6.4 for VirtualBox
  config.vm.provider :virtualbox do |virtualbox, override|
    override.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box'
    virtualbox.name = "vagrant.local.harvard.edu"
    virtualbox.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

  end

  # Puppet Labs CentOS 6.4 for VMWare Fusion
  config.vm.provider :vmware_fusion do |fusion, override|
    override.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/debian-607-x64-vf503.box'
  end

  HOST_IP = "192.168.111.222"

  config.vm.hostname = 'vagrant.local.harvard.edu'
  # Private networks allow you to access your guest machine by some address that is not publicly accessible from the global internet.
  # In general, this means your machine gets an address in the private address space.
  # Assign a static IP to the Vagrant machine
  config.vm.network :private_network, ip:  HOST_IP

  # Forward standard ports (local only, does not run under AWS)
  config.vm.network :forwarded_port, guest: 80,  host: 8080, auto_correct: true, id: 'http'
  config.vm.network :forwarded_port, guest: 443, host: 8443, auto_correct: true, id: 'https'
  config.vm.network :forwarded_port, guest: 8016, host: 8016,
  auto_correct: true, id: 'https'
  config.vm.network :forwarded_port, guest: 8017, host: 8017, auto_correct: true, id: 'https'

  # Install r10k using the shell provisioner and download the Puppet modules
  config.vm.provision :shell, :path => 'resources/bootstrap.sh'

  # Puppet provisioner for primary configuration
  config.vm.provision :puppet do |puppet|
    # Set top level variables so that puppet scripts can use those instead of
    # hard- coding on two places.
    # Castest application will be accessed using
    # https://HOST_IP:APACHE_SSL_PORT/castest
    # http://HOST:TOMCAT_HTTP_PORT/castest
    puppet.facter = {
          "servername"  => HOST_IP,
          "fqdn"        => HOST_IP,
    }
    puppet.manifests_path = "resources/manifests"
    puppet.manifest_file  = "init.pp"
    puppet.options        = "--verbose --debug --hiera_config /vagrant/resources/hiera/hiera.yaml --modulepath /vagrant/resources/modules"

  end

end
