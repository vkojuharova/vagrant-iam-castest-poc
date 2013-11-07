vagrant-iam-castest-poc
=======================

Vagrant-powered environment for deploying a CAS test application using Apache and Tomcat.

General notes
-------------
For the local install, we are using a box (image) from [Puppet Labs](http://puppet-vagrant-boxes.puppetlabs.com/). For the remote install, we are using the most recent Amazon Linux AMI.

Puppet modules are pulled in using r10k on the VM.

Local install using VirtualBox
------------------------------
1. Install VirtualBox
2. Install Vagrant
3. Checkout this repo
4. Run: `vagrant up --provider virtualbox`

Remote install using AWS
------------------------
1. Install Vagrant 1.2 or newer
2. Install the Vagrant AWS plugin:
        vagrant plugin install vagrant-aws
3. Create an EC2 Security Group called "basic-web" if it does not already exist.  Open up at minimum SSH access.
* Create a Vagrant configuration file in your home directory to contain your AWS
  config values: `cd ~/.vagrant.d/ && vim Vagrantfile`
  It should resemble this:
```ruby
    Vagrant.configure("2") do |config|
      config.vm.provider :aws do |aws, override|
        aws.access_key_id = "YOUR_AWS_ACCESS_KEY"
        aws.secret_access_key = "YOUR_AWS_SECRET_KEY"
        aws.keypair_name = "CHOOSE_AN_EXISTING_KEYPAIR"

        override.ssh.private_key_path = "PATH_TO_PRIVATE_KEY"
      end
    end
```
  For more options see: https://github.com/mitchellh/vagrant-aws
4. Import the Vagrant box we are using: `vagrant box add amazon-linux-x64-13.09 https://github.com/huit/huit-vagrant-boxes/blob/master/aws/amazon-linux-2013.09.box?raw=true`
5. Run: `vagrant up --provider=aws`
