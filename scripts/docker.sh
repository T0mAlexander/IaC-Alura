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
