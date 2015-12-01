require 'socket'

Vagrant.configure("2") do |config|
  module Vagrant
    module Util
      class Platform
        class << self
          def solaris?
            true
          end
        end
      end
    end
  end

  config.ssh.username = "ubuntu"
  config.ssh.forward_agent = true

  config.vm.synced_folder "#{ENV['HOME']}", '/vagrant', disabled: true

  ssh_key = "#{ENV['HOME']}/.ssh/vagrant"
  
  ("local").split(" ").each do |nm_region|
    config.vm.define nm_region do |region|
      region.vm.provider "virtualbox" do |v, override|
        override.vm.provision "shell", path: "script/cibuild", privileged: false
        override.ssh.private_key_path = ssh_key
        override.vm.box = "ubuntu"
        override.vm.synced_folder "#{ENV['HOME']}", '/vagrant'
        override.vm.synced_folder "#{ENV['HOME']}", "#{ENV['HOME']}"

        override.vm.network "private_network", type: "dhcp"
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

  (0..100).each do |nm_region|
    config.vm.define "d#{nm_region}" do |region|
      region.vm.provider "docker" do |v, override|
        if nm_region == "d0"
          v.image = "ubuntu:packer"
          override.vm.provision "shell", path: "script/cibuild", privileged: false
        else
          v.image = "ubuntu:vagrant"
        end
        
        v.cmd = [ "bash", "-c", "install -d -m 0755 -o root -g root /var/run/sshd; exec /usr/sbin/sshd -D" ]
        v.has_ssh = true
        
        override.vm.synced_folder "#{ENV['HOME']}", '/vagrant'
        override.vm.synced_folder "#{ENV['HOME']}", "#{ENV['HOME']}"
        override.ssh.insert_key = false

        module VagrantPlugins
          module DockerProvider
            class Provider < Vagrant.plugin("2", :provider)
              def host_vm?
                false
              end
            end
            module Action
              class Create
                def forwarded_ports(include_ssh=false)
                  return []
                end
              end
            end
          end
        end
      end
    end
  end

  (ENV['DIGITALOCEAN_REGIONS']||"").split(" ").each do |nm_region|
    config.vm.define nm_region do |region|
      region.vm.provider "digital_ocean" do |v, override|
        override.vm.provision "shell", path: "script/cibuild", privileged: false
        override.ssh.private_key_path = ssh_key
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
        override.vm.provision "shell", path: "script/cibuild", privileged: false
        override.ssh.private_key_path = ssh_key
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
