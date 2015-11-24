require 'socket'

Vagrant.configure("2") do |config|
  config.ssh.username = "ubuntu"
  config.ssh.forward_agent = true

  config.vm.synced_folder '.', '/vagrant', disabled: true
  
  config.vm.provision "shell", path: "bin/foo.sh", privileged: false

  ssh_key = "#{ENV['HOME']}/.ssh/vagrant"
  config.ssh.private_key_path = ssh_key
  
  ("local").split(" ").each do |nm_region|
    config.vm.define nm_region do |region|
      region.vm.provider "virtualbox" do |v, override|
        override.vm.box = "ubuntu"
        override.vm.synced_folder '.', '/vagrant'
        override.vm.synced_folder "#{ENV['HOME']}", "#{ENV['HOME']}"

        override.vm.network "forwarded_port", guest: 2375, host: 2375
        
        v.memory = 2048
        v.cpus = 2

        if File.exists?('cidata.iso')
          v.customize [ 
            'storageattach', :id, 
            '--storagectl', 'SATA Controller', 
            '--port', 1, 
            '--device', 0, 
            '--type', 'dvddrive', 
            '--medium', 'cidata.iso'
          ]
        end

      end
    end
  end

  (ENV['DIGITALOCEAN_REGIONS']||"").split(" ").each do |nm_region|
    config.vm.define nm_region do |region|
      region.vm.provider "digital_ocean" do |v, override|
        override.vm.box = "ubuntu-#{nm_region}"
        override.vm.synced_folder 'cache', '/vagrant/cache'
        override.vm.synced_folder 'distfiles', '/vagrant/distfiles'
        override.vm.synced_folder 'packages', '/vagrant/packages'

        v.ssh_key_name = "vagrant-#{Digest::MD5.file(ssh_key).hexdigest}"
        v.token = ENV['DIGITALOCEAN_API_TOKEN']
        v.size = '2gb'
        v.setup = false
        v.user_data = "\n#cloud-config\nusers:\n - name: ubuntu\n   ssh-authorized-keys:\n    - #{File.read('cidata/user-data')}"
      end
    end
  end

  (ENV['AWS_REGIONS']||"").split(" ").each do |nm_region|
    config.vm.define nm_region do |region|
      region.vm.provider "aws" do |v, override|
        override.vm.box = "ubuntu-#{nm_region}"
        override.vm.synced_folder 'cache', '/vagrant/cache'
        override.vm.synced_folder 'distfiles', '/vagrant/distfiles'
        override.vm.synced_folder 'packages', '/vagrant/packages'

        v.keypair_name = "vagrant-#{Digest::MD5.file(ssh_key).hexdigest}"
        v.instance_type = 'c4.large'
        v.region = nm_region
      end
    end
  end
end
