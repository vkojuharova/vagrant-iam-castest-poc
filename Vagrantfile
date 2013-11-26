# -*- mode: ruby -*-
# vi: set ft=ruby :

if ENV['VAGRANT_DEFAULT_PROVIDER'] == "aws" then
  Vagrant.require_plugin 'aws'
end

Vagrant.configure('2') do |config|
  config.vm.box = 'puppetlabs-centos-64-x64'

# Comment the following as it starts throwing an exception puppet provisioner: 
# The manifests path specified for Puppet does not exist: C:/...
# Add debugging info
#  config.vm.provision :puppet do |puppet|
#     puppet.options        = "--verbose --debug "
#  end


  # Puppet Labs CentOS 6.4 for VirtualBox
  config.vm.provider :virtualbox do |virtualbox, override|
    override.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box'
  end


  # Puppet Labs CentOS 6.4 for VMWare Fusion
  config.vm.provider :vmware_fusion do |fusion, override|
    override.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/debian-607-x64-vf503.box'
  end

  # Amazon Linux AMI
  config.vm.provider :aws do |aws, override|
    aws.access_key_id = "XX"
    aws.secret_access_key = "XX"
    aws.keypair_name = "XX"

    aws.region = "us-east-1"

#    # Simple region config
#    aws.region_config "us-east-1", :ami => "ami-35792c5c"

    aws.security_groups = ["basic-web"]
    aws.instance_type = "t1.micro"
    aws.tags = {
    'Name' => "VanjaVagrantServer"
    }

# Don;t have the user
#    override.ssh.username="ec2-user"
    override.ssh.private_key_path = "C:/Users/vak860/.ssh/vanyaKey.pem"

    override.vm.box     = 'amazon-linux-x64-13.09'
    override.vm.box_url = 'https://raw.github.com/huit/huit-vagrant-boxes/master/aws/amazon-linux-13.09.box'
  end

  # Forward standard ports (local only, does not run under AWS)
  config.vm.network :forwarded_port, guest: 80,  host: 8080, auto_correct: true
  config.vm.network :forwarded_port, guest: 443, host: 8443, auto_correct: true

  # Install r10k using the shell provisioner and download the Puppet modules
  config.vm.provision :shell, :path => 'resources/bootstrap.sh'

  # Puppet provisioner for primary configuration
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "resources/manifests"
    puppet.manifest_file  = "init.pp"
#    puppet.options        = "--verbose --hiera_config /vagrant/resources/hiera/hiera.yaml --modulepath /vagrant/resources/modules"
    puppet.options        = "--verbose --debug --hiera_config /vagrant/resources/hiera/hiera.yaml --modulepath /vagrant/resources/modules --debug"
  end
end
