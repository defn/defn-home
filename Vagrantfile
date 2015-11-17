require 'socket'

Vagrant.configure("2") do |config|
  config.ssh.username = "ubuntu"
  config.ssh.forward_agent = true

  config.vm.synced_folder '.', '/vagrant', disabled: true
  
  config.vm.provision "shell", path: "bin/foo.sh", privileged: false
  
  ("local").split(" ").each do |nm_region|
    config.vm.define nm_region do |region|
      region.vm.provider "virtualbox" do |v, override|
        override.vm.box = "ubuntu"
        override.vm.synced_folder '.', '/vagrant'
        v.memory = 2048
        v.cpus = 2
      end
    end
  end

  (ENV['DIGITALOCEAN_REGIONS']||"").split(" ").each do |nm_region|
    config.vm.define nm_region do |region|
      region.vm.provider "digital_ocean" do |v, override|
        override.vm.box = "ubuntu-#{nm_region}"

        ssh_key = "#{ENV['HOME']}/.ssh/vagrant-#{ENV['LOGNAME']}"
        override.ssh.private_key_path = ssh_key
        v.ssh_key_name = "vagrant-#{Digest::MD5.file(ssh_key).hexdigest}"
        v.token = ENV['DIGITALOCEAN_API_TOKEN']
        v.size = '2gb'
        v.setup = false
        v.user_data = "#cloud-config\n\nruncmd:\n  - install -d -o ubuntu -g ubuntu -m 0700 ~ubuntu/.ssh && install -o ubuntu -g ubuntu -m 0600 ~root/.ssh/authorized_keys ~ubuntu/.ssh/authorized_keys"
      end
    end
  end

  (ENV['AWS_REGIONS']||"").split(" ").each do |nm_region|
    config.vm.define nm_region do |region|
      region.vm.provider "aws" do |v, override|
        override.vm.box = "ubuntu-#{nm_region}"
        ssh_key = "#{ENV['HOME']}/.ssh/vagrant-#{ENV['LOGNAME']}"
        override.ssh.private_key_path = ssh_key
        v.keypair_name = "vagrant-#{Digest::MD5.file(ssh_key).hexdigest}"
        v.instance_type = 't2.small'
        v.region = nm_region
      end
    end
  end
end
