Vagrant.configure("2") do |config|
  config.ssh.username = "ubuntu"
  config.ssh.insert_key = false
  config.ssh.forward_agent = true

  config.vm.box = "ubuntu"
  config.vm.synced_folder '.', '/vagrant2', disabled: true
end
