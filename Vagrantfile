require 'socket'

shome=File.expand_path("..", __FILE__)

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

  config.vm.synced_folder shome, '/vagrant', disabled: true

  ssh_key = "#{shome}/.ssh/vagrant"
  
  config.vm.define "osx" do |region|
    region.vm.box = "ubuntu"
    region.ssh.insert_key = false
    region.vm.synced_folder shome, '/vagrant'
    region.vm.provision "shell", path: "script/cibuild", privileged: false

    region.vm.provider "vmware_fusion" do |v, override|
      v.gui = false
      v.vmx["memsize"] = "2048"
      v.vmx["numvcpus"] = "2"
    end
  end

  config.vm.define "fga" do |region|
    region.vm.box = "ubuntu"
    region.ssh.private_key_path = ssh_key
    region.vm.synced_folder shome, '/vagrant'
    region.vm.synced_folder shome, shome
    region.vm.synced_folder "/tmp/vagrant", '/tmp/vagrant'
    region.vm.provision "shell", path: "script/cibuild", privileged: false

    region.vm.provider "virtualbox" do |v, override|
      override.vm.network "private_network", ip: "172.28.128.3"
      override.vm.network "forwarded_port", guest: 2375, host: 2375
      
      v.memory = 8000
      v.cpus = 4

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

  (0..100).each do |nm_region|
    config.vm.define "fga#{nm_region}" do |region|
      region.ssh.insert_key = false
      region.vm.synced_folder shome, '/vagrant'
      region.vm.synced_folder shome, shome
      region.vm.synced_folder "/tmp/vagrant", '/tmp/vagrant'

      region.vm.provider "docker" do |v, override|
        if nm_region == 0
          override.vm.provision "shell", path: "script/cibuild", privileged: false
          v.image = ENV['IMAGE'] || "ubuntu:packer"
          v.cmd = [ "bash", "-c", "install -d -m 0755 -o root -g root /var/run/sshd; exec /usr/sbin/sshd -D" ]
        else
          v.image = ENV['IMAGE'] || "ubuntu:vagrant"
          v.cmd = [ "/usr/sbin/sshd", "-D" ]
        end
        
        v.has_ssh = true
        
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
      region.vm.box = "ubuntu-#{nm_region}"
      region.ssh.private_key_path = ssh_key
      region.vm.synced_folder 'cache', '/vagrant/cache'
      region.vm.synced_folder 'distfiles', '/vagrant/distfiles'
      region.vm.synced_folder 'packages', '/vagrant/packages'
      region.vm.provision "shell", path: "script/cibuild", privileged: false

      region.vm.provider "digital_ocean" do |v, override|
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
      region.vm.box = "ubuntu-#{nm_region}"
      region.ssh.private_key_path = ssh_key
      region.vm.synced_folder 'cache', '/vagrant/cache'
      region.vm.synced_folder 'distfiles', '/vagrant/distfiles'
      region.vm.synced_folder 'packages', '/vagrant/packages'
      region.vm.provision "shell", path: "script/cibuild", privileged: false

      region.vm.provider "aws" do |v, override|
        v.keypair_name = "vagrant-#{Digest::MD5.file(ssh_key).hexdigest}"
        v.instance_type = 'c4.large'
        v.region = nm_region
      end
    end
  end
end
