BOX_IMAGE = "sbeliakou/centos"
	Vagrant.configure("2") do |config|
		config.vm.define "jenkins" do |subconfig|
    			subconfig.vm.box = BOX_IMAGE
    			subconfig.vm.hostname = "jenkins"
    			subconfig.vm.network :private_network, ip: "192.168.170.173"
    			subconfig.vm.provider "virtualbox" do |vb|	
    				vb.memory = "2048"
    				vb.name = "jenkins"
			end
		subconfig.vm.provision 'shell', path: "script.sh"	
		end
	end

