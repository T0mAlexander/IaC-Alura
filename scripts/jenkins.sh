# Obtendo chaves de autenticação do Jenkins 
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key \
| sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Checando as chaves de autenticação do Jenkins
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null

# Atualizando pacotes e repositórios do Ubuntu
sudo apt-get update -y

# Instalando Kit de Desenvolvimento do Java (JDK)
sudo apt-get install fontconfig openjdk-11-jre -y

# Instalando o Jenkins
sudo apt-get install jenkins -y