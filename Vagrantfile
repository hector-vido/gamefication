# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
  config.vm.box = "debian/stretch64"
  config.vm.box_check_update = false

  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y apache2 sshpass
    systemctl stop apache2
    systemctl disable apache2
    chmod -x /usr/sbin/apachectl
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
    systemctl restart sshd
    cp /vagrant/files/gamefy.sh /usr/bin
    chmod +x /usr/bin/gamefy.sh
    cp /vagrant/files/rotina.sh /usr/local/bin
    chmod +x /usr/local/bin/rotina.sh
    echo -e '123\n123' | passwd
  SHELL
end
