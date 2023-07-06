#!/bin/sh

### TODO - Configs do Jenkins ###
- Iniciar um job acoplado ao repositório do Github via HTTPS na branch "jenkins-docker"
- Ativar o Poll SCM inserindo o "* * * * *"
- Instalar plugins do Docker e Config File Provider
- Ativar o cloud do Docker
- Criar .env-dev e .env-prod
- Inserir variavel .env-dev no Build Environment do Job com target ".env"
- Deletar workspace antes de executar a build

#? Build Shell 1
echo "-------- Validando a sintaxe do Dockerfile --------"
cd app
cat Dockerfile
docker run --rm -i hadolint/hadolint < Dockerfile

#? Build Dockerfile
#* Diretório: ./app/
#* Cloud: docker
#* Img Docker: django_todolist_image_build

#? Build Shell 3
#!/bin/sh
echo "-------- Subindo o container de teste --------"
docker run -d -p 82:8000 -v /var/run/mysqld/mysqld.sock:/var/run/mysqld/mysqld.sock \
-v /var/lib/jenkins/workspace/lista-de-tarefas/app/to_do/:/usr/src/app/to_do/ --name=lista-tarefas-teste django_todolist_image_build

# echo "-------- Localizando .env no container --------"
# docker exec -i lista-tarefas-teste la to_do/ | grep .env

echo "-------- Testando .env --------"
docker exec -i lista-tarefas-teste cat .env

echo "-------- Atualizando o pip --------"
docker exec -i lista-tarefas-teste pip install --upgrade pip

echo "-------- Testando a imagem --------"
docker exec -i lista-tarefas-teste python manage.py test --keep
exit_code=$?

echo "-------- Encerrando o container antigo --------"
docker rm -f lista-tarefas-teste

if [ $exit_code -ne 0 ]; then
  exit 1
fi

#TODO - instalar o plugin "Parameterized trigger"
- adicionar os seguintes parametros na config do job
# --------------
passo 1 - (parametro de string)
nome: Imagem do Docker
valor padrão: <conta-dockerhub>/django_todolist_image_build
# --------------
passo 2 - (parametro de string)
nome: Host do Docker
valor padrão: tcp://127.0.0.1:2376
# --------------
- marque a opção "Push Image" no passo de build de img do Docker
- clique no botão "Add" e insira as credenciais do DockerHub

#TODO - criar uma conta no Slack para integração ao Jenkins (https://plugins.jenkins.io/slack/)

#TODO - crie uma pipeline
- adicione os seguintes parametros na config da pipeline
# --------------
passo 1 - (parametro de string)
nome: HostDocker
valor padrão: tcp://127.0.0.1:2376
# --------------
passo 2 - (parametro de string)
nome: ImagemDocker
valor padrão: nenhum (O job anterior irá repassar essa imagem)
# --------------

#TODO - Teste o código abaixo no Pipeline Script e faça build no Jenkins

pipeline {

  agent any

  stages {
    stage('Mensagem de boas vindas') {
      steps {
        sh 'echo "Olá, Jenkins e Docker"'
      }
    }
  }
}

#TODO - Substitua por esse script
#TODO - Insira o IDarquivo .env-dev e o ID do token do Slack no código abaixo
#TODO - Faça build da pipeline com a imagem t0malexander/django_todolist_image_build

pipeline {
  environment {
    DOCKER_IMAGE = "${ImagemDocker}"
  }

  agent any

  stages {

    stage('Carregando variáveis de desenvolvimento') {
      steps {
        configFileProvider([configFile(fileId: '<id do .env-dev>', variable: 'env')]) {
          sh 'cat $env > .env'
        }
      }
    }

    stage('Encerrando o container antigo') {
      steps {
        script {
          try {
            sh 'docker rm -f lista-tarefas-dev'
          } catch (Exception e) {
            sh "echo $e"
          }
        }
      }
    }
    
    stage('Construindo o container novo') {
      steps {
        script {
          try {
            sh "docker run -d -p 81:8000 -v /var/run/mysqld/mysqld.sock:/var/run/mysqld/mysqld.sock -v /var/lib/jenkins/workspace/lista-de-tarefas-dev/app/:/usr/src/app/ --name=lista-tarefas-dev ${DOCKER_IMAGE}:latest"
          } catch (Exception e) {
            slackSend (color: 'error', message: "[ FALHA ] Não foi possivel subir o container - ${BUILD_URL} em ${currentBuild.duration}s", tokenCredentialId: 'id-token-slack')
            sh "echo $e"
            currentBuild.result = 'ABORTED'
            error('Erro')
          }
        }
      }
    }
    
    stage('Notificando o canal do Slack') {
      steps {
        slackSend (color: 'good', message: '[ Sucesso ] O novo build esta disponivel em: http://192.168.56.10:81/ ', tokenCredentialId: 'id-token-slack')
      }
    }
  }
}
