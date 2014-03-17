# -*- mode: ruby -*-
# vi: set ft=ruby :

box32      = 'precise32'
box32_url  = 'http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-i386-vagrant-disk1.box'

box32deb = "wheezy32"
box32deb_url = "https://dl.dropboxusercontent.com/u/197673519/debian-7.2.0.box"

# box64      = 'precise64'
# box64_url  = 'http://files.vagrantup.com/precise64.box'

# ssh_key    = '/Users/username/.ssh/yourkey.pub'

Vagrant.configure("2") do |config|

  config.vm.box = box32
  config.vm.box_url = box32_url
  #config.ssh.private_key_path = ssh_key
  ## setup private network for use by vagrant machines
  ##  10.0.1.1 is reserved for the router
  config.vm.network :private_network, ip: '10.0.1.100'

  #config.vm.network :hostonly, ip: "10.0.1.1"

  # set auto_update to false, if you do NOT want to check the correct
  # additions version when booting this machine
  # install the plugin first!
  # ~ vagrant plugin install vagrant-vbguest
  config.vbguest.auto_update = false

  ## webserver - nginx - 1
  config.vm.define :web do |web|
    web.vm.hostname = "nginx-php-mysql"
    # config.ssh.username = 'vagnrat1'
    # config.ssh.port = 22

    # set custom name to showup in Virtualbox
    web.vm.provider "virtualbox" do |vm|
      vm.name = "nginx-php-mysql"
    end

    ## http/https port mappings
    web.vm.network :forwarded_port, guest: 80, host: 8000
    # config.vm.network :forwarded_port, guest: 443, host: 44

    # Source Code folder mounting
    ## NFS based folder mounting is OSX and Linux only!!!!
    # web.vm.synced_folder "./source", "/var/www", id: "vagrant-root", :nfs => true

    ## Rsync based folder mounting
    web.vm.synced_folder "./source", "/var/www/", type: "rsync", rsync__exclude: [".git/" , "node_modules", ".sass-cache"]
    ## Windows Users ##

    # default synced_folder method
    # web.vm.synced_folder './source', '/var/www/'

    ## SMB based mounts - WINDOWS Only!
    ## http://docs.vagrantup.com/v2/synced-folders/smb.html
    # web.vm.synced_folder "./source", "/var/www/", type: "smb"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible/playbook-lemp.yml"
    ansible.verbose = 'vv' #accepts 'v' to 'vvvv'
    ansible.sudo = 'true'
  end

end # end of vagrant config


# Vagrantfile will be searched for by the system until it is found
# in the followting paths
# /home/user_name/projects/foo/Vagrantfile
# /home/user_name/projects/Vagrantfile
# /home/user_name/Vagrantfile
# /home/Vagrantfile
# /Vagrantfile
