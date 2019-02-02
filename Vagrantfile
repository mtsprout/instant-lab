
Vagrant.configure("2") do |config|

  config.vm.define "master.vm" do |master|
    master.vm.box = "centos/7"
    master.vm.hostname = "master.vm"
    master.vm.provision "shell", path: "scripts/masterbootstrap.sh"
    master.vm.network "private_network", ip: "192.168.55.4"
    master.vm.provider "virtualbox" do |v|
      v.memory = 4096
      v.cpus = 2
    end
  end

  config.vm.define "gitlab.vm" do |gitlab|
    gitlab.vm.box = "centos/7"
    gitlab.vm.hostname = "gitlab.vm"
    gitlab.vm.provision "shell", path: "scripts/gitlab.sh"
    gitlab.vm.network "private_network", ip: "192.168.55.50"
    gitlab.vm.provider "virtualbox" do |v|
      v.memory = 4096
      v.cpus = 2
    end
  end

  config.vm.define "web1.vm" do |linux|
     ip_addr="192.168.55.5"
     hostname="web1.vm"
     linux.vm.box = "centos/7"
     linux.vm.hostname = hostname
     linux.vm.provision "shell", path: "scripts/nodebootstrap.sh", args: [ip_addr, hostname]
     linux.vm.network "private_network", ip: ip_addr
     linux.vm.provider "virtualbox" do |v|
       v.memory = 512
     end
   end

    config.vm.define "app1.vm" do |linux|
     ip_addr="192.168.55.6"
     hostname="app1.vm"
     linux.vm.box = "centos/7"
     linux.vm.hostname = hostname
     linux.vm.provision "shell", path: "scripts/nodebootstrap.sh", args: [ip_addr, hostname]
     linux.vm.network "private_network", ip: ip_addr
     linux.vm.provider "virtualbox" do |v|
       v.memory = 512
     end
   end

  config.vm.define "db1.vm" do |linux|
     ip_addr="192.168.55.7"
     hostname="db1.vm"
     linux.vm.box = "centos/7"
     linux.vm.hostname = hostname
     linux.vm.provision "shell", path: "scripts/nodebootstrap.sh", args: [ip_addr, hostname]
     linux.vm.network "private_network", ip: ip_addr
     linux.vm.provider "virtualbox" do |v|
       v.memory = 512
     end
   end

  config.vm.define "windows.vm" do |windows|
    windows.vm.box = "ferventcoder/win2012r2-x64-nocm"
    windows.vm.communicator = "winrm"
    windows.vm.hostname = "windows"
    windows.vm.provision "shell", path: "scripts/windows_agent.ps1"
    windows.vm.network "private_network", ip: "192.168.55.8"
    windows.vm.provider "virtualbox" do |v|
      v.memory = 768
    end
  end
end
