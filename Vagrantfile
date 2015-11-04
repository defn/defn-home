Vagrant.configure("2") do |config|
  config.ssh.username = "ubuntu"
  config.ssh.forward_agent = true

  config.vm.box = "ubuntu"
  config.vm.synced_folder '.', '/vagrant', disabled: true
  
  config.vm.provider "virtualbox" do |v, override|
    v.memory = 2048
    v.cpus = 2
  end

  config.vm.provider "digital_ocean" do |v, override|
    override.ssh.private_key_path = "#{ENV['HOME']}/.ssh/vagrant-#{ENV['LOGNAME']}"
    v.token = ENV['DIGITALOCEAN_API_TOKEN']
    v.size = '1gb'
  end
end
