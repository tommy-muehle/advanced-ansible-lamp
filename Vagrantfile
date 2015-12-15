Vagrant.configure("2") do |config|

  config.vm.box = "centos-6.7-x86_64.box"
  config.vm.box_url = "https://github.com/tommy-muehle/ansible-vagrant-boxes/releases/download/1.1/centos-6.7-x86_64.box"

  config.vm.hostname = "awesome.dev"
  config.vm.network "private_network", ip: "192.168.33.245"
  config.vm.network "forwarded_port", guest: 1080, host: 1080

  config.ssh.forward_agent = true
  config.ssh.keep_alive = true
  config.ssh.username = "vagrant"
  config.ssh.password = "vagrant"

  config.vm.provider :virtualbox do |v|
    v.memory = 1024
    v.cpus = 2
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--name", "awesome.dev"]
    v.customize ["modifyvm", :id, "--accelerate3d", "off"]
    v.customize ["modifyvm", :id, "--accelerate2dvideo", "off"]
    v.customize ["modifyvm", :id, "--cpuexecutioncap", "75"]
    v.customize ["modifyvm", :id, "--largepages", "on"]
  end

  config.vm.provision :shell, :path => "ansible/provision.sh"

end
