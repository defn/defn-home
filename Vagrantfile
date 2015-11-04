require 'socket'

Vagrant.configure("2") do |config|
  config.ssh.username = "ubuntu"
  config.ssh.forward_agent = true

  nm_guest = Socket.gethostname.split('.')[0]
  config.vm.define nm_guest do
  end

  config.vm.box = "ubuntu"
  config.vm.synced_folder '.', '/vagrant', disabled: true
  
  config.vm.provider "virtualbox" do |v, override|
    v.memory = 2048
    v.cpus = 2
  end

  config.vm.provider "digital_ocean" do |v, override|
    ssh_key = "#{ENV['HOME']}/.ssh/vagrant-#{ENV['LOGNAME']}"
    override.ssh.private_key_path = ssh_key
    override.ssh.username = "root"
    v.ssh_key_name = "vagrant-#{Digest::MD5.file(ssh_key).hexdigest}"
    v.token = ENV['DIGITALOCEAN_API_TOKEN']
    v.size = '1gb'
    v.setup = false
  end
end
