# Ansible e Terraform + AWS

## Descrição

Branch relacionada ao curso **Infraestrutura como código: preparando máquinas na AWS com Ansible e Terraform** da Alura

## Mapa do Projeto

  <div align="center">
  
  ![Mapa do Projeto](/project-map.png)
  </div>

## Pré-requisitos

- [**Ansible**](https://developer.hashicorp.com/vagrant/downloads) instalado na máquina com versão mínima em 2.14.x
- [**Terraform**](https://www.virtualbox.org/wiki/Downloads) instalado na máquina com versão mínima em 1.5.x
- [**Python**](https://www.virtualbox.org/wiki/Downloads) instalado na máquina com versão mínima em 3.11.x
- [**AWS CLI**](https://docs.aws.amazon.com/pt_br/cli/latest/userguide/getting-started-install.html) instalado na máquina com versão mínima em 2.11.x (opcional)

## Instruções de uso

### 1. Gere uma nova chave SSH

  ```bash
  ssh-keygen -f <nome-da-chave> -t rsa
  ```

### 2. Importe a chave para a AWS

  ![Importando a chave para a AWS](https://raw.githubusercontent.com/T0mAlexander/CICD-Alura/screenshots/ansible-terraform/importando-chaves-para-aws.png)

  > **Localização:** vá até ***EC2 > Pares de chaves*** para acessar o painel de gerenciamento de chaves SSH

  - **2.1** Crie um nome para a chave e importe o arquivo `.pub` da chave

  ![Criando nome e importando chave pública](https://raw.githubusercontent.com/T0mAlexander/CICD-Alura/screenshots/ansible-terraform/criando-nome-e-importando-chave.png)

## 3. Criando a instância EC2

  ```bash
  terraform apply
  ```

  > **Lembrete:** digite `yes` para confirmação

## 4. Interagindo com a instância EC2

  - **4.1** Acesse via SSH

  ```bash
  ssh -i <chave> ubuntu@<ip-público>
  ```

  - **4.2** Crie um arquivo HTML com o comando abaixo:

  ```bash
  echo "<h1>Ola, Ansible e Terraform</h1>" > index.html
  ```

  - **4.3** Instancie um servidor para teste rápido

  ```bash
  nohup busybox httpd -f -p 8080 &
  ```

  - **4.4** Obtenha o IP público da instância e acesse o servidor

  ```bash
  terraform output
  ```

  **Lembrete:** o servidor estará acessível na porta **8080**

## 5. Experimentando o Ansible

  - **5.1** Crie uma pasta chamada `ansible`

  ```bash
  mkdir ansible
  ```

  - **5.2** Crie um arquivo para hosts

  ```bash
  touch hosts.yml
  ```

  - **5.2.1** Insira as informações do host de acordo com o código abaixo:

  ```yml
  all:
    hosts:
      <nome-do-host>:
        ansible_host: <ip-público>
        ansible_user: ubuntu
        ansible_ssh_private_key_file: 'localização/da/chave'
  ```

  > **Nota:** insira um nome customizado para o host

  - **5.3** Crie um arquivo para roteiro da infraestrutura
  
  ```bash
  touch playbook.yml
  ```

  - **5.3.1** Dentro do arquivo de roteiro, insira as seguintes informações:

  ```yml
  - hosts: <nome-do-host>
    tasks:
      - name: Importando as tarefas
        ansible.builtin.import_role:
          name: <nome-do-host>
          tasks_from: main
  ```

  - **5.4** Crie uma função para o host

  ```bash
  ansible-galaxy init <nome-do-host>
  ```

  * **5.4.1** Vá até a pasta do host e localize a subpasta de tarefas (tasks) e edite o arquivo `main.yml`

  ```yml
  ---
  - name: Criando o arquivo de boas-vindas
    ansible.builtin.copy:
      dest: /home/ubuntu/index.html
      content: <h1>Feito com Terraform e Ansible</h1>

  - name: Criando o servidor de teste na porta 8080
    ansible.builtin.shell:
      cmd: 'nohup busybox httpd -f -p 8080 &'
  ```

 * **5.5** Execute o roteiro *(playbook)* de instalação

  ```bash
  ansible-playbook <arquivo-roteiro>.yml -i <arquivo-hosts>.yml
  ```

  > **Qual a vantagem desta prática com o Ansible?**
  >
  > **R:** Por meio do Terraform, para fazer alterações é necessário recriar toda a infraestrutura. Usando o Ansible, novas alterações não necessitam de recriação da infraestrutura.
  >
  > **Dica:** experimente testar o poder de gerenciamento de infraestrutura do Ansible alterando a mensagem de boas vindas

### 6. Instalando as dependências e pacotes para a infraestrutura

  - **6.1** Encerre a infraestrutura

  ```bash
  terraform destroy
  ```

  - **6.1.1** Insira a tag abaixo na instância EC2

  ```terraform
  tags = {
    "name" = "Ansible Terraform Python"
  }
  ```

  - **6.1.2** Recrie a infraestrutura

  ```bash
  terraform apply
  ```

  > **Lembrete:** ao criar uma nova instância, um novo endereço de IP público é atribuído à ela. Certifique-se de atualizar o endereço no arquivo `hosts.yml`

  - **6.2** Na pasta de tasks, altere o conteúdo do arquivo para este abaixo:

  ```yml
  ---
  - name: Instalando Python3 e VirtualEnv
    ansible.builtin.apt:
      name:
        - python3
        - virtualenv
      state: latest
      update_cache: true
    become: true

  - name: Instalando dependências com o PIP
    ansible.builtin.pip:
      virtualenv: /home/ubuntu/python/virtual-env
      name:
        - django
        - djangorestframework
  ```

  - **6.2.1** Execute o roteiro do Ansible

  ```bash
  ansible-playbook <arquivo-roteiro>.yml -i <arquivo-hosts>.yml
  ```

  - **6.3** Acesse a instância EC2 e ative a virtualização do Python

  ```bash
  source python/virtual-env/bin/activate
  ```

  > **Dica:** para ver os pacotes instalados, digite o comando `pip freeze`

### 7. Simulando implementação (deploy) de um projeto

  - **7.1** Acesse a pasta `python` na instância EC2

  ```bash
  cd python/
  ```

  - **7.2** Inicie um novo projeto com Django

  ```bash
  django-admin startproject <nome> .
  ```

  - **7.3** Instancie o servidor da aplicação Django

  ```bash
  python manage.py runserver 0.0.0.0:8000
  ```

  > **Aviso:** ao acessar o servidor, é esperado este aviso do Django. Após isto, encerre o servidor

  ![tela padrão app django](https://raw.githubusercontent.com/T0mAlexander/CICD-Alura/screenshots/ansible-terraform/tela-padr%C3%A3o-app-django.png)

  - **7.3** Edite o arquivo de configurações `settings.py`

  ```bash
  vim app/settings.py
  ```

  - **7.3.1** Procure por `ALLOWED_HOSTS` e edite conforme o código abaixo

  ```vim
  ALLOWED_HOSTS = ['*']
  ```

  > **O que isto irá fazer?**
  >
  > **R:** o símbolo de asterico permite todo o tráfego. Isso fará com o que o Django não mostre um erro na página inicial da aplicação

  - **7.4** Reinicie o servidor e ao acessar você verá esta interface

  ![app funcional django](https://raw.githubusercontent.com/T0mAlexander/CICD-Alura/screenshots/ansible-terraform/django-app-corrigido.png)

## 8. Automatizando deploy da aplicação com Ansible

  - **8.1** Desative a virtualização do Python e mantenha apenas a pasta `virtual-env`

  ```bash
  deactivate && rm -rf app db.sqlite3 manage.py
  ```

  - **8.2** Adicione mais duas tarefas e execute o roteiro

  ```yml
  - name: Criando um projeto com o Django
  ansible.builtin.shell:
    cmd: |
      source /home/ubuntu/python/virtual-env/bin/activate &&
      django-admin startproject app /home/ubuntu/python/
    executable: /bin/bash

  - name: Permitindo todos os hosts no arquivo settings.py
    ansible.builtin.lineinfile:
      path: /home/ubuntu/python/app/settings.py
      regexp: 'ALLOWED_HOSTS'
      line: "ALLOWED_HOSTS = ['*']"
      backrefs: true
  ```

  - **8.3** Reative a virtualização do Python e o servidor do Django

  ```bash
  source python/virtual-env/bin/activate &&
  python python/manage.py runserver 0.0.0.0:8000
  ```
