Vagrant.configure("2") do |config|
  #? Sistema operacional da máquina virtual
  config.vm.box = "nitindas/ubuntu-22"

  #? Nomeando a máquina virtual e atribuindo um IP
  config.vm.define "jenkins-docker" do |m|
    m.vm.network "private_network", ip: "192.168.56.10"
  end

  #? Checagem automática de atualizações do sistema operacional da VM
  config.vm.box_check_update = true

  #? Definido provedor de virtualização
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end

  #? Definindo armazenamento para a máquina virtual

  # TODO Execute o comando "vagrant plugin vagrant-disksize"
  config.disksize.size = '30GB'

  #* Encaminhamento de portas
  config.vm.network "forwarded_port", guest: 8080, host: 8080 # Porta do Jenkins
  config.vm.network "forwarded_port", guest: 3306, host: 3306 # Porta do MySQL
  # config.vm.network "forwarded_port", guest: 9000, host: 9000
  # config.vm.network "forwarded_port", guest: 81, host: 81
  # config.vm.network "forwarded_port", guest: 80, host: 80
  # config.vm.network "forwarded_port", guest: 19999, host: 19999
  # config.vm.network "forwarded_port", guest: 9001, host:9001

  #* Instalações e configurações via terminal
  config.vm.provision "shell", path: "./scripts/python.sh" # Instalando o Python
  config.vm.provision "shell", path: "./scripts/jenkins.sh" # Instalando o Jenkins

  config.vm.provision "shell", inline: "chmod +x /vagrant/scripts/*" # Concessão de permissões de execução a pasta de scripts
  config.vm.provision "shell", inline: "sudo /vagrant/scripts/docker.sh" # Instalando o Docker através da máquina virtual

  config.vm.provision "shell", path: "./scripts/mysql-server.sh" # Instalando o MySQL Server
  config.vm.provision "shell", inline: "cat /configs/mysqld.cnf > /etc/mysql/mysql.conf.d/mysqld.cnf" # Copiando configurações do MySQL

  #* Sincronização e compartilhamento de pastas
  config.vm.synced_folder "./configs/", "/configs" # Pasta de configuração
  config.vm.synced_folder "./app", "/home/vagrant/app" # Pasta de configuração
end