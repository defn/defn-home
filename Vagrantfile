Vagrant.configure("2") do |config|
  config.ssh.username = "ubuntu"
  config.ssh.insert_key = false
  config.ssh.forward_agent = true

  config.vm.box = "ubuntu"
  # config.vm.synced_folder '.', '/vagrant', disabled: true
  
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end
end
