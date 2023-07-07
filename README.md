# Jenkins e Docker

## Descrição

Repositório relacionado ao curso "Jenkins e Docker: pipeline de entrega contínua" da Alura

## Pré-requisitos

- [**Vagrant**](https://developer.hashicorp.com/vagrant/downloads) instalado na máquina com versão mínima em 2.x.x
- [**VirtualBox**](https://www.virtualbox.org/wiki/Downloads) instalado na máquina com versão mínima em 7.x.x

## Pré configurações da máquina virtual

### 1. Inicialize a máquina virtual

  ```bash
  vagrant up
  ```

  > **Nota:** Este processo pode levar de 3 a 5 minutos

### 2. Conecte-se a máquina virtual

  ```bash
  vagrant ssh
  ```

  > **Info:** o **IP** da VM é [**192.168.56.10**](http://192.168.56.10). Você pode mudar editando o `Vagrantfile` em caso de incompatibilidade

### 3. Acesse a pasta da aplicação web

  ```bash
  cd app/
  ```

  **Dica:** caso queira listar arquivos e pastas, digite `la` no terminal

### 4. Configure o ambiente virtual do Python

- **4.1** Instale as ferramentas de desenvolvimento e testes

  ```python
  pip3 install virtualenv nose coverage nosexcover pylint
  ```

- **4.2** Crie um ambiente virtual

  ```python
  virtualenv --always-copy django-app
  ```

> **Info:** o nome do ambiente será **django-app**

- **4.2.1** Ative o ambiente virtual

  ```python
  source django-app/bin/activate
  ```

- **4.3** Instale as dependências do Python

  ```python
  pip3 install -r requirements.txt
  ```

  **Dica:** para atualizar o pip, execute `pip3 install --upgrade pip`

- **4.4** Crie migrações para o ambiente de desenvolvimento

  ```python
  python3 manage.py makemigrations
  ```

  > **Aviso:** certifique-se de estar na pasta `/app`

- **4.4.1** Faça migração para o ambiente de desenvolvimento

  ```python
  python3 manage.py migrate
  ```

- **4.4.2** Crie um super usuário para acesso do app em desenvolvimento

  ```python
  python3 manage.py migrate
  ```

- **4.5** Crie migrações para o ambiente de produção

  ```python
  python3 ../manage.py makemigrations
  ```

  > **Aviso:** certifique-se de estar na pasta `/app/to_do`

- **4.5.1** Faça migração para o ambiente de produção

  ```python
  python3 ../manage.py migrate
  ```

- **4.5.2** Crie um super usuário para acesso do app em produção

  ```python
  python3 ../manage.py migrate
  ```

### 5. Exponha e ative o daemon do Docker

- **5.1** Crie um diretório de configurações customizadas do Docker

  ```bash
  sudo mkdir -p /etc/systemd/system/docker.service.d/
  ```

- **5.2** Crie e edite o arquivo `override.conf`

  ```bash
  sudo vim /etc/systemd/system/docker.service.d/override.conf
  ```

- **5.2.1** Adicione as informações abaixo

  ```vim
  [Service]
  ExecStart=
  ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2376
  ```

- **5.3** Recarregue as configurações do sistema

  ```bash
  sudo systemctl daemon-reload
  ```

- **5.4** Reinicie o serviço Docker

  ```bash
  sudo systemctl restart docker.service
  ```

## Pré configurando e utilizando o Jenkins

### 1. Acesse o servidor do Jenkins

- **1.1** Acesse a URL [**192.168.56.10:8080**](http://192.168.56.10:8080)

  > **Nota:** por padrão, o Jenkins é executado na porta **8080** mas pode ser alterado. Consulte a [**documentação do Jenkins**](https://www.jenkins.io/doc/book/security/services/#exposed-services-and-ports)

- **1.2** No primeiro uso, o Jenkins exigirá que você localize uma senha inicial em uma pasta determinada executando o comando abaixo:

  ```bash
  sudo cat <diretório-senha-jenkins>
  ```

  > **Nota:** em ambientes Linux, a senha geralmente está localizada na pasta `/var/lib/jenkins/secrets/initialAdminPassword`

  ![Desbloqueando o Jenkins](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/desbloqueando-jenkins.png?raw=true)

- **1.3** Instale os plugins sugeridos do Jenkins

  ![Instalando plugins sugeridos](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/jenkins-plugins-sugeridos.png?raw=true)

- **1.3.1** Aguarde a instalação dos plugins sugeridos

  ![Instalação dos plugins](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/instalando-plugins-sugeridos.png?raw=true)

- **1.4** Crie um usuário com privilégios administrativos

  ![Criando user](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/criando-adm-user.png?raw=true)

- **1.4.1** Você será redirecionado ao painel do Jenkinks

  ![Painel do Jenkins](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/homepage-jenkins.png?raw=true)

### 2. Adicione plugins customizados

- **2.1** Clique na opção **"*Manage Jenkins*"**

  ![Manage Plugins](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/add-plugin-passo-1.png?raw=true)

- **2.2** Clique em **"*Plugins*"**

  ![Opção Plugins](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/op%C3%A7%C3%A3o-plugins.png?raw=true)

- **2.3** Clique em **"*Available Plugins*"**

  ![Opção Plugins](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/op%C3%A7%C3%A3o-available-plugins.png?raw=true)

- **2.4** Instale os plugins abaixo

- **2.4.1** Docker

  ![Plugin Docker](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/plugin-docker.png?raw=true)

- **2.4.2** Config File Provider

  ![Plugin Config File Provider](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/plugin-config-file-provider.png?raw=true)
  
- **2.4.3** Slack Notifications

  ![Plugin Slack Notifications](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/plugin-slack-notifications.png?raw=true)

- **2.4.4** Parameterized Trigger

  ![Plugin Parameterized Trigger](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/plugin-param-trigger.png?raw=true)

  **2.4.5** Reinicie o servidor do Jenkins

  ![Reiniciando Jenkins](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/reiniciando-jenkins.png?raw=true)

  > **INFO:** sempre clique na opção **"*Download now and install after restart*"**

### 3. Crie um novo trabalho (job)

  ![Criando Job 1](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/criar-um-job-1.png?raw=true)

- **3.0.1** Nomeie e escolha o tipo **"*Freestyle project*"** (projeto livre)

  ![Criando Job 2](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/criando-job-2.png?raw=true)

  > **Aviso:** você será automaticamente redirecionado para página de configuração após criar o trabalho

- **3.0.2.** Na seção de Gerenciamento de Código Fonte, escolha a opção Git

  ![Opção Git](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/op%C3%A7%C3%A3o-git.png?raw=true)

- **3.0.3** Copie a URL do repositório-alvo

  ![URL Repositório](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/url-repositorio.png?raw=true)

- **3.0.4** Cole a URL no campo **"*Repository URL*"**

  ![URL Repositório](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/colando-url-repositorio.png?raw=true)

- **3.0.5** Insira o nome da branch-alvo no campo **"*Branch Specifier*"**

  ![URL Repositório](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/informando-branch.png?raw=true)

- **3.0.6** Ative o poll SCM e insira `* * * * *` no campo **"*Schedule*"**

  ![URL Repositório](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/job-poll-scm.png?raw=true)

- **3.0.7** Na seção sobre Build Env, marque a opção de deletar workspace antes de iniciar uma nova build

  ![Deletar workspace](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/deletar-workspace.png?raw=true)

  > **AVISO:** Não esqueça de clicar no botão **"*Apply*"** a partir daqui

- **3.0.8** Vá em ***Dashboard > Manage Jenkins > Managed Files*** e clique em **"*Add a new Config*"**

  ![Add arquivo de config](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/add-arquivos-de-config.png?raw=true)

- **3.0.9** Escolha o tipo de arquivo como customizado

  ![Arquivo customizado](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/op%C3%A7%C3%A3o-custom-file.png?raw=true)

- **3.1** Nomeie o primeiro arquivo como `.env-dev`e insira o conteúdo abaixo no campo **"*Content*"**

  ```vim
  [config]
  # Secret configuration
  SECRET_KEY=r*5ltfzw-61ksdm41fuul8+hxs$86yo9%k1%k=(!@=-wv4qtyv

  # Configuration
  DEBUG=True

  # Database
  DB_NAME=todo_dev
  DB_USER=devops_dev
  DB_PASSWORD=devops
  DB_HOST=localhost
  DB_PORT=3306
  ```

  > **Sugestão:** descreva a função do arquivo no campo **"*Comment*"**

- **3.1.1** Agora faça o mesmo criando outro arquivo chamado `.env-prod`

  ```vim
  [config]
  # Secret configuration
  SECRET_KEY=r*5ltfzw-61ksdm41fuul8+hxs$86yo9%k1%k=(!@=-wv4qtyv

  # Configuration
  DEBUG=True

  # Database
  DB_NAME=todo
  DB_USER=devops
  DB_PASSWORD=devops
  DB_HOST=localhost
  DB_PORT=3306
  ```

- **3.1.2** Vá em **"*Dashboard > Manage Jenkins > Nodes and Clouds > Clouds*"**

  ![Jenkins Cloud](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/jenkins-nodes.png?raw=true)

- **3.1.3** Adicione a nuvem do Docker

  ![Add Nuvem Docker](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/ativando-nuvem-docker.png?raw=true)

- **3.1.4** Insira `tcp://127.0.0.1:2376` no campo  **"*Host Docker URI*"**

  ![Host Docker URI](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/docker-host-uri.png?raw=true)

- **3.1.5** Habilite a nuvem do Docker e salve

  ![Habilitando cloud Docker](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/habilitando-cloud-docker.png?raw=true)

- **3.1.6** Volte nas configurações do trabalho, na seção **"*Build Env*"** e adicione o arquivo `.env-dev` com o campo **"*Target*"** preenchido com `./app/.env`

  ![Provendo Config File Job](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/provendo-config-file-job.png?raw=true)

- **3.2** Adicione uma instrução para execução de Shell Script

  ![Build Step 1](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/build-step-1.png?raw=true)

- **3.2.1** Copie o script abaixo e cole no campo **"*Command*"**

  ```bash
  echo "-------- Validando a sintaxe do Dockerfile --------"
  cd app
  cat Dockerfile
  docker run --rm -i hadolint/hadolint < Dockerfile
  ```

- **3.3** Adicione uma instrução para build de Dockerfile

  ![Build Step 2](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/build-step-2.png?raw=true)

- **3.3.1** Insira as seguintes informações abaixo

  ![Docker Build Local](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/build-local-dockerfile.png?raw=true)

  > **INFORMAÇÕES**
  >
  > **Diretório** *(Directory for Dockerfile)*: `./app/`
  >
  > **Nuvem** *(Cloud)*: nome dado ao cloud do Docker no Jenkins
  >
  > **Imagem do Docker** *(Image)*: **django_todolist_image_build**

<!-- - **3.3.2** Habilite o push da imagem e adicione as credenciais da sua conta do [**DockerHub**](https://hub.docker.com) no Jenkins

  ![Push e Credenciais](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/push-e-credenciais.png?raw=true)

- **3.3.3** Na pop-up, insira os dados da sua conta do DockerHub

  ![Dados Dockerhub](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/dockerhub-credenciais.png?raw=true)

  > **INFORMAÇÕES**
  >
  > **Nome de usuário** *(Username)*: usuário do DockerHub
  >
  > **Senha** *(Password)*: senha da sua conta no DockerHub
  >
  > **ID customizado** *(ID)*: apelido para identificar a credencial dentro do contexto do Jenkins
  >
  > **Descrição** *(Description)*: descrição para a credencial -->

- **3.4** Adicione outro shell script

  ![Build Step 3](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/build-step-1.png?raw=true)

- **3.4.1** Copie e cole o script abaixo

  ```bash
  #!/bin/sh
  echo "-------- Subindo o container de teste --------"
  docker run -d -p 82:8000 -v /var/run/mysqld/mysqld.sock:/var/run/mysqld/mysqld.sock \
  -v /var/lib/jenkins/workspace/<nome-do-job>/app/:/usr/src/app/ --name=<nome-do-container> django_todolist_image_build

  # echo "-------- Localizando .env no container --------"
  # docker exec -i <nome-do-container> la | grep .env

  echo "-------- Testando .env --------"
  docker exec -i <nome-do-container> cat .env

  echo "-------- Atualizando o pip --------"
  docker exec -i <nome-do-container> pip3 install --upgrade pip

  echo "-------- Testando o container --------"
  docker exec -i <nome-do-container> python3 manage.py test --keep
  exit_code=$?

  echo "-------- Encerrando o container antigo --------"
  docker rm -f <nome-do-container>

  if [ $exit_code -ne 0 ]; then
    exit 1
  fi
  ```

  > **Aviso:** não esqueça de ajustar o **< nome do job >** e **< nome do container >** aos que você nomeou para o seu ambiente
  >
  > **Lembrete:** salve as configurações clicando no botão **"*Apply*"**

- **3.5** Vá em **"*Manage Jenkins > System*"** e procure a seção **"*Slack*"**

  > **AVISO:** Este passo requer um workspace previamente criado no Slack

  ![Seção Slack](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/se%C3%A7%C3%A3o-slack.png?raw=true)

- **3.5.1** Acesse o [**guia de integração do Jenkins Slack**](https://plugins.jenkins.io/slack/) e gere o token de autenticação.

- **3.5.2** Crie a credencial para o token do Slack

  ![Criando credencial slack](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/criando-credencial-slack.png?raw=true)

- **3.5.3** Adicione os dados do Slack

  ![Dados credencial slack](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/dados-credenciais-slack.png?raw=true)

  > **INFORMAÇÕES**
  >
  > **Tipo** *(Kind)*: tipo da credencial (deverá ser **"*Secret Text*"**)
  >
  > **Token** *(Secret)*: token gerado pelo Slack
  >
  > **ID Customizado** *(ID)*: Apelido do token dentro do Jenkins

- **3.5.4** Volte a seção e preencha os dados de integração ao Slack e salve

  ![Seção slack preenchida](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/se%C3%A7%C3%A3o-slack-completa.png?raw=true)

  > **Sugestão:** teste a conexão clicando no botão **"*Test connection*"** no canto inferior direito. Você verá uma mensagem no canal do seu workspace no Slack em caso de sucesso
  >
  > ![Teste Slack](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/jenkins-slack-msg.png?raw=true)

- **3.6** Retorne as configurações do trabalho e adicione um passo pós build para notificar canais no Slack

  ![add notificação slack](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/add-notifica%C3%A7%C3%A3o-slack.png?raw=true)

- **3.6.1** Marque todas as opções e salve

  ![todas as notificações do slack](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/slack-todas-notifica%C3%A7%C3%B5es-marcadas.png?raw=true)

- **3.7** Execute a primeira build

  ![Primeira Build](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/executar-build.png?raw=true)

### 4. Crie uma pipeline

  ![Criando pipeline](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/criando-pipeline.png?raw=true)

- **4.1.1** Parametrize a pipeline com uma string

  ![Param String Pipeline](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/param-pipeline-string.png?raw=true)

- **4.1.2** Dê um nome a string e defina o valor padrão como `tcp://127.0.0.1:2376`

  ![dados string pipeline](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/dados-string1.png?raw=true)

  > **AVISO:** o nome da string será importante para um script nos próximos passos, portanto escolha um nome simples e semântico

- **4.1.3** Adicione um novo parâmetro de string apenas com o campo **"*Name*"** preenchido

  ![String 2](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/string2-sem-value.png?raw=true)

  > **Explicação:** o valor padrão *(Default Value)* não necessitará ser preenchido pois ele receberá a imagem do Docker do trabalho criado anteriormente

- **4.2** Dê scroll até o campo **"*Script*"** da seção **"*Pipeline*"**

  ![Pipeline Script](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/pipeline-script.png?raw=true)

- **4.2.1** Copie e cole o script de teste abaixo e em seguida, salve as configurações da pipeline

  ```groovy
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
  ```

  > **Informação:** a linguagem do script é o Groovy, compatível com o Java

- **4.2.3** Faça build da pipeline

  ![botao build pipeline](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/build-da-pipeline.png?raw=true)

- **4.2.4** Execute a build sem informar uma imagem como parâmetro

  ![pipeline build sem params](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/build-pipeline-sem-params.png?raw=true)

  > **Nota:** nos relatórios do estágio de build da pipeline, irá retornar um **"Olá Jenkins e Docker"**

  ![msg teste pipeline](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/msg-teste-pipeline.png?raw=true)

- **4.3** Volte ao campo de script, copie e cole o código abaixo:

  <details>
  <summary>Trecho do código</summary>

    ```groovy
    pipeline {
      environment {
        DOCKER_IMAGE = "${<NOME-STRING-IMG>}"
      }

      agent any

      stages {

        stage('Carregando variáveis de desenvolvimento') {
          steps {
            configFileProvider([configFile(fileId: '<ID-.ENV-DEV>', variable: 'env')]) {
              sh 'cat $env > .env'
            }
          }
        }

        stage('Encerrando o container antigo') {
          steps {
            script {
              try {
                sh 'docker rm -f <NOME-CONTAINER>'
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
                sh "docker run -d -p 81:8000 -v /var/run/mysqld/mysqld.sock:/var/run/mysqld/mysqld.sock -v /var/lib/jenkins/workspace/<NOME-WS>/app/:/usr/src/app/ --name=<NOME-CONTAINER> ${DOCKER_IMAGE}:latest"
              } catch (Exception e) {
                slackSend (color: 'error', message: "[ FALHA ] Não foi possivel subir o container - ${BUILD_URL} em ${currentBuild.duration}s", tokenCredentialId: '<ID-SLACK-TOKEN>')
                sh "echo $e"
                currentBuild.result = 'ABORTED'
                error('Erro')
              }
            }
          }
        }

        stage('Notificando o canal do Slack') {
          steps {
            slackSend (color: 'good', message: '[ Sucesso ] O novo build esta disponivel em: http://<IP-DA-MAQUINA>:81/ ', tokenCredentialId: '<ID-SLACK-TOKEN>')
          }
        }
      }
    }
    ```

    > **LEGENDA DAS VARIÁVEIS**:
    >
    >***NOME-STRING-IMG***: Nome da string referente a imagem do Docker
    >
    >***ID-.ENV-DEV***: UUID gerado pelo Jenkins do arquivo de variáveis de desenvolvimento
    >
    >***NOME-CONTAINER***: Nome para o container. Recomenda-se terminar com **-dev** para diferenciar
    >
    >***NOME-WS***: Nome da pasta do workspace do trabalho (job) criando anteriormente
    >
    >***ID-SLACK-TOKEN***: ID da credencial global referente ao token do Slack
    >
    >***IP-DA-MAQUINA***: IP da máquina virtual
  </details>

- **4.3.1** Execute a build informando a imagem a associada a sua conta no DockerHub

  > **Requisitos:** upload da imagem `django_todolist_image_build` para associação sua conta no DockerHub

  ![push com img pipeline](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/pipeline-com-build-params.png?raw=true)

> **Nota:** em caso de sucesso, o bot do Jenkins no Slack irá fornecer a URL da aplicação

- **4.4** No terminal, acesse o container em modo interativo

  ```bash
  docker exec -it <nome-do-container> bash
  ```

- **4.4.1** Execute os seguintes comandos

  ```bash
  python3 manage.py makemigrations
  python3 manage.py migrate
  ```

- **4.4.2** Crie um super usuário para acessar a aplicação

  ```bash
  python3 manage.py createsuperuser
  ```

### 5. Crie um trabalho de produção

  ![criando job prod](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/criando-job-prod.png?raw=true)

  > **Info:** assim como o trabalho de desenvolvimento, este também será do tipo Projeto Livre

- **5.1** Adicione um parâmetro pro host do Docker com o valor `tcp://127.0.0.1:2376`

  ![dados string pipeline](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/dados-string1.png?raw=true)

- **5.1.1** Adicione um parâmetro chamado **"*DockerImage*"** com valor vazio

  ![String 2](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/string2-sem-value.png?raw=true)

- **5.2** No Build Steps, selecione **"*Provide configuration files*"**

![config file build step](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/config-file-step.png?raw=true)

- **5.2.1** Escolha o arquivo `.env_prod` e informe a pasta-alvo como `./app/.env`

  ![config file ajustes](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/config-file-ajustes-prod.png?raw=true)

- **5.3** Adicione um shell script e cole o código abaixo:

  ```bash
  #!/bin/sh
  { \
    docker run -d -p 80:8000 \
      -v /var/run/mysqld/mysqld.sock:/var/run/mysqld/mysqld.sock \
      -v /var/lib/jenkins/workspace/<NOME-WS>/app/to_do/:/usr/src/app/to_do/ \
      --name=<NOME-CONTAINER> ${<NOME-STRING-IMG}:latest \
  } || { # catch
    docker rm -f <NOME-CONTAINER>
    docker run -d -p 80:8000 \
      -v /var/run/mysqld/mysqld.sock:/var/run/mysqld/mysqld.sock \
      -v /var/lib/jenkins/workspace/<NOME-WS>/app/to_do/:/usr/src/app/to_do/ \
      --name=<NOME-CONTAINER> ${<NOME-STRING-IMG}:latest \
  }
  ```

  > **LEGENDA DAS VARIÁVEIS**:
  >
  >***NOME-CONTAINER***: Nome para o container. Recomenda-se  terminar com **-prod** para diferenciar
  >
  >***NOME-STRING-IMG***: Nome da string referente a imagem do Docker
  >
  >***NOME-WS***: Nome da pasta do workspace do trabalho atual

- **5.3.1** No pós build, selecione notificações do Slack apenas de sucesso ou falha

  ![notificações pós build](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/pos-build-job-prod.png?raw=true)

- **5.3.2** Execute a build inserindo a imagem do Docker associada a sua conta

  ![build prod](https://github.com/T0mAlexander/CICD-Alura/blob/screenshots/build-prod.png?raw=true)

> **Nota:** em caso de sucesso, a aplicação estará na porta 80 do IP da sua máquina
