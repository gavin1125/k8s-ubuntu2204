Vagrant.configure("2") do |config|
  config.vm.box_check_update = false

  config.vm.provision "shell", inline: <<-SHELL
    echo "192.168.56.80  master" >> /etc/hosts
    echo "192.168.56.81  worker" >> /etc/hosts
    echo "192.168.56.82  worker" >> /etc/hosts
  SHELL
    
  config.vm.define "master" do |master|
    master.vm.box = "ubuntu/jammy64"
    master.vm.hostname = "master"
    master.vm.network "private_network", ip: "192.168.56.80"
    master.vm.provider "virtualbox" do |vb|
      vb.memory = 4096
      vb.cpus = 2
    end
    master.vm.provision "shell", path: "scripts/common.sh"
    master.vm.provision "shell", path: "scripts/kubeadm.sh"
    master.vm.provision "shell", path: "scripts/images.sh"
    master.vm.provision "shell", path: "scripts/master.sh"
    master.vm.provision "shell", path: "scripts/network.sh"
  end

  (1..2).each do |i|
    config.vm.define "worker#{i}" do |worker|
      worker.vm.box = "ubuntu/jammy64"
      worker.vm.hostname = "worker#{i}"
      worker.vm.network "private_network", ip: "192.168.56.8#{i}"
      worker.vm.provider "virtualbox" do |vb|
        vb.memory = 2048
        vb.cpus = 1
      end
     worker.vm.provision "shell", path: "scripts/common.sh"
     worker.vm.provision "shell", path: "scripts/kubeadm.sh"
     worker.vm.provision "shell", path: "scripts/images.sh"
     worker.vm.provision "shell", path: "scripts/worker.sh"
    end
  end
end
