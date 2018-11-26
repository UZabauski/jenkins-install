BOX_IMAGE = "sbeliakou/centos"
NODE_COUNT = 2

Vagrant.configure("2") do |config|
  config.vm.define "NGINXJ" do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "NGINXJ"
    subconfig.vm.network :private_network, ip: "192.168.39.120"
        subconfig.vm.provider "virtualbox" do |vb|
	vb.memory = "4096"
	vb.name = "NGINXJ"
	end
    subconfig.vm.provision 'shell', path: "Script.sh"
      end
  # (1..NODE_COUNT).each do |i|
  #  config.vm.define "TOMCAT#{i}" do |subconfig|
   #   subconfig.vm.box = BOX_IMAGE
    #  subconfig.vm.hostname = "TOMCAT#{i}"
     # subconfig.vm.network :private_network, ip: "192.168.10.#{i + 120}"
      #subconfig.vm.provision 'shell', path: "Tomcat#{i}.sh"
      #subconfig.vm.provider "virtualbox" do |vb|
	#vb.memory = "2048"
	#vb.name = "TOMCAT#{i}"
	#end
    #end
  #end
end
