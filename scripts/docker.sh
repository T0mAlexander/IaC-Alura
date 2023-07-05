# Instalando o docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Concedendo permissões para o Docker
sudo usermod -aG docker vagrant

# Reiniciando o serviço do Docker
sudo service docker restart

# TODO: Reconecte-se a VM para aplicar executar docker sem a palavra 'sudo'

# Obtendo a imagem "hadolint"
docker pull hadolint/hadolint 
