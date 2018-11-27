
Vagrant.configure(2) do |config|
  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.box = "sbeliakou/centos"
    jenkins.vm.network "private_network", ip: "192.168.56.20"
    jenkins.vm.provider "virtualbox" do |jn|
      jn.memory = "2048"
    jenkins.vm.provision "shell", path: "jenkins.sh"
    end
  end
end

