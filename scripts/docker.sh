curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker vagrant
sudo service docker restart
docker pull hadolint/hadolint
sudo mkdir -p /etc/systemd/system/docker.service.d/

sudo cat << EOF > /etc/systemd/system/docker.service.d/override.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2376
EOF

sudo systemctl daemon-reload
sudo systemctl restart docker.service

#TODO - Exposição do daemon do Docker pós instalação

#todo 1 - sudo mkdir -p /etc/systemd/system/docker.service.d/
#-----------------------------------
#todo 2 - sudo vim /etc/systemd/system/docker.service.d/override.conf

#todo [Service]
#todo ExecStart=
#todo ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2376
#------------------------------------

#todo 3 - sudo systemctl daemon-reload
#todo 4 - sudo systemctl restart docker.service

#! - Inserir o Host URI "tcp://127.0.0.1:2376" e marcar "Enabled" na cloud do Docker dentro do Jenkins 