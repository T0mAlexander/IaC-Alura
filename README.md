# Ansible e Terraform + AWS

## Descrição

Branch relacionada ao curso **Infraestrutura como código: preparando máquinas na AWS com Ansible e Terraform** da Alura

## Mapa do Projeto

  <div align="center">
  
  ![Mapa do Projeto](./project-map.svg)
  </div>

## Pré-requisitos

- [**Ansible**](https://developer.hashicorp.com/vagrant/downloads) instalado na máquina com versão mínima em 2.14.x
- [**Terraform**](https://www.virtualbox.org/wiki/Downloads) instalado na máquina com versão mínima em 1.5.x
- [**Python**](https://www.virtualbox.org/wiki/Downloads) instalado na máquina com versão mínima em 3.11.x
- [**AWS CLI**](https://docs.aws.amazon.com/pt_br/cli/latest/userguide/getting-started-install.html) instalado na máquina com versão mínima em 2.11.x (opcional)

## Instruções de uso

### 1. Gere uma nova chave SSH

  ```bash
  chave-sshgen -f <nome-da-chave> -t rsa
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

  - **8.4** Crie uma tarefa de verificação de um projeto Django conforme o código abaixo:

  ```yml
  - name: Verificando existência prévia de um projeto Django
  ansible.builtin.stat:
    path: /home/ubuntu/python/app/settings.py
  register: app_django

  - name: Criando um projeto com o Django
    ansible.builtin.shell:
      cmd: |
        source /home/ubuntu/python/virtual-env/bin/activate &&
        django-admin startproject app /home/ubuntu/python/
      executable: /bin/bash
    when: not app_django.stat.exists
  ```

## 9. Separando ambientes de trabalho

  - **9.1** Crie uma instância EC2 para ambiente de produção no Terraform

  ```terraform
  resource "aws_instance" "prod" {
    ami           = "ami-0af6e9042ea5a4e3e" # Ubuntu Server 22.04 LTS
    instance_type = "t2.micro"              # Instância do Free Tier da AWS
    key_name      = var.<chave-ssh>
    
    vpc_security_group_ids = [aws_security_group.ssh-access.id]

    tags = {
      "name" = "Máquina de Produção"
    }
  }
  ```

  - **9.2.1** No arquivo de hosts, insira as informações da instância EC2 de produção

  ```yml
  <host-de-produção>:
  ansible_host: <ip-público>
  ansible_user: ubuntu
  ansible_ssh_private_key_file: caminho/da/chave
  ```

  - **9.2.2** Crie uma função para a máquina de produção e crie a seguinte sequência de tarefas

  ```yml
  ---
  - name: Instalando Python3 e VirtualEnv
    ansible.builtin.apt:
      name:
        - python3
        - virtualenv
      update_cache: true
    become: true

  # ---------------------- Tarefa nova ---------------------------
  - name: Clonando o repositório Git
    ansible.builtin.git:
      repo: 'https://github.com/alura-cursos/clientes-leo-api.git'
      dest: /home/ubuntu/python/
      version: master
      force: true
  # ---------------------------------------------------------------

  # ------------------- Tarefa modificada -------------------------
  - name: Instalando dependências com o PIP
    ansible.builtin.pip:
      virtualenv: /home/ubuntu/python/virtual-env
      requirements: /home/ubuntu/python/requirements.txt

  - name: Verificando existência prévia de um projeto Django
    ansible.builtin.stat:
      path: /home/ubuntu/python/setup/settings.py
    register: app_django
  #-----------------------------------------------------------------

  - name: Criando um projeto com o Django
    ansible.builtin.shell:
      cmd: |
        source /home/ubuntu/python/virtual-env/bin/activate &&
        django-admin startproject setup /home/ubuntu/python/
      executable: /bin/bash
    when: not app_django.stat.exists

  - name: Permitindo todos os hosts no arquivo settings.py
    ansible.builtin.lineinfile:
      path: /home/ubuntu/python/app/settings.py
      regexp: 'ALLOWED_HOSTS'
      line: "ALLOWED_HOSTS = ['*']"
      backrefs: true

  - name: Configurando o banco de dados
  ansible.builtin.shell:
    cmd: |
      source /home/ubuntu/python/virtual-env/bin/activate &&
      python3 /home/ubuntu/python/manage.py migrate
    executable: /bin/bash

  - name: Carregando os dados iniciais
    ansible.builtin.shell:
      cmd: |
        source /home/ubuntu/python/virtual-env/bin/activate &&
        python3 /home/ubuntu/python/manage.py loaddata clientes.json
      executable: /bin/bash
  ```
  
  - **9.2.3** No arquivo de roteiro (playbook), atribua as tarefas ao host de produção e execute o roteiro

  ```yml
  - hosts: <host-de-produção>
  tasks:
    - name: Importando as tarefas da máquina de produção
      ansible.builtin.import_role:
        name: <host-de-produção>
        tasks_from: main
  ```

  - **9.3** Crie uma tarefa para instanciar o servidor de produção

  ```yml
  - name: Instanciando o servidor de produção
  ansible.builtin.shell:
    cmd: |
      source /home/ubuntu/python/virtual-env/bin/activate &&
      nohup python3 /home/ubuntu/python/manage.py runserver 0.0.0.0:8000 &
    executable: /bin/bash
  ```

  > **Nota:** ao acessar a aplicação, você deverá ver esta interface. Você pode clicar na URL em vermelho para ver a lista de clientes
  > ![App em produção](https://raw.githubusercontent.com/T0mAlexander/CICD-Alura/screenshots/ansible-terraform/django-app-produ%C3%A7%C3%A3o.png)

## 10. Autoscaling Group e infraestrutura elástica

  - **10.1** Crie um template de instância EC2 em um arquivo separado

  ```terraform
  resource "aws_launch_template" "<nome-qualquer>" {
    image_id      = <sistema-operacional>    # Ubuntu Server 22.04 LTS
    instance_type = <tipo-da-instância>      # Instância do Free Tier da AWS
    key_name      = <chave-ssh>

    security_group_names = [ var.<nome-variavel-grupo-seg> ]
  }
  ```

  - **10.1.1** Crie um grupo de escalonamento automático

  ```terraform
  resource "aws_autoscaling_group" "<nome-qualquer>" {
    name = var.nome_do_agrupamento
    availability_zones = [ "<zona>" ]
    min_size = <valor-numérico>
    max_size = <valor-numérico>

    launch_template {
      id = aws_launch_template.<nome>.id
      version = "$Latest"
    }
  }
  ```

  - **10.1.2** Crie uma pasta chamada `modules` e crie uma subpasta chamada `machines`

  ```bash
  mkdir -p modules/machines
  ```

  - **10.1.3** Crie 2 subpastas dentro da pasta `machines` chamada `dev` e `prod`

  ```bash
  mkdir modules/machines/dev && mkdir modules/machines/prod
  ```

  - **10.1.4** Crie 2 arquivos de módulos do Terraform para cada máquina

  ```bash
  touch modules/machines/dev/<nome-qualquer> && touch modules/machines/prod/<nome-qualquer>
  ```

  - **10.1.5** Insira os seguintes módulos para cada máquina

  ```terraform
  # Máquina de Desenvolvimento

  module "dev" {
    source            = "../../../"
    regiao            = "<regiao-aws>"
    tipo_da_instancia = "t2.micro"
    chave             = "<nome-da-chave>"
    grupo_seg         = "dev"
    autoscale_min     = 1
    autoscale_max     = 3
    nome_do_agrupamento = "<nome>
  }
  
  # Máquina de Produção

  module "prod" {
    source            = "../../../"
    regiao            = "<regiao-aws>"
    tipo_da_instancia = "t2.micro"
    chave             = "<nome-da-chave>"
    grupo_seg         = "prod"
    autoscale_min     = 1
    autoscale_max     = 5
    nome_do_agrupamento = "<nome>
  }
  ```

  > **Lembrete:** cada módulo deve ser inserido no arquivo de cada maquina respectiva criado anteriormente

  - **10.1.6** Crie novas variáveis no arquivo `vars.tf`

  ```terraform
  variable "regiao" {
    type = string
  }

  variable "tipo_da_instancia" {
    type = string
  }

  variable "chave" {
    type = string
  }

  variable "nome_do_agrupamento" {
    type = string
  }

  variable "grupo_seg" {
    type = string
  }

  variable "autoscale_min" {
    type = number
  }

  variable "autoscale_max" {
    type = number
  }
  ```

  - **10.2** Acesse a pasta da máquina de produção e inicie o módulo

  ```bash
  cd modules/machines/prod && terraform init
  ```

  > **Dica:** experimente encerrar a instância manualmente para ver o que acontece

  - **10.3** Na mesma pasta do módulo da máquina de produção, crie um arquivo de script

  ```bash
  touch <nome-do-script>.sh
  ```

  > **Sugestão:** crie uma pasta chamada `scripts` e coloque o arquivo dentro

  - **10.3.1** Dentro do arquivo de script, insira o código abaixo:

<details>
  <summary>Código</summary>

  ```shell
  #!/bin/bash
  cd /home/ubuntu/
  curl -fsSL https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  sudo python3 get-pip.py
  sudo python3 -m pip install ansible
  tee -a playbook.yml > /dev/null <<EOT
  - hosts: localhost
    tasks:
    - name: Instalando Python3 e VirtualEnv
      ansible.builtin.apt:
        name:
          - python3
          - virtualenv
        update_cache: true
      become: true

    - name: Clonando o repositório Git
      ansible.builtin.git:
        repo: 'https://github.com/alura-cursos/clientes-leo-api.git'
        dest: /home/ubuntu/python/
        version: master
        force: true

    - name: Instalando dependências com o PIP
      ansible.builtin.pip:
        virtualenv: /home/ubuntu/python/virtual-env
        requirements: /home/ubuntu/python/requirements.txt

    - name: Verificando existência prévia de um projeto Django
      ansible.builtin.stat:
        path: /home/ubuntu/python/setup/settings.py
      register: app_django

    - name: Criando um projeto com o Django
      ansible.builtin.shell:
        cmd: |
          source /home/ubuntu/python/virtual-env/bin/activate &&
          django-admin startproject setup /home/ubuntu/python/
        executable: /bin/bash
      when: not app_django.stat.exists

    - name: Permitindo todos os hosts no arquivo settings.py
      ansible.builtin.lineinfile:
        path: /home/ubuntu/python/setup/settings.py
        regexp: 'ALLOWED_HOSTS'
        line: "ALLOWED_HOSTS = ['*']"
        backrefs: true

    - name: Configurando o banco de dados
      ansible.builtin.shell:
        cmd: |
          source /home/ubuntu/python/virtual-env/bin/activate &&
          python3 /home/ubuntu/python/manage.py migrate
        executable: /bin/bash

    - name: Carregando os dados iniciais
      ansible.builtin.shell:
        cmd: |
          source /home/ubuntu/python/virtual-env/bin/activate &&
          python3 /home/ubuntu/python/manage.py loaddata clientes.json
        executable: /bin/bash

    - name: Instanciando o servidor de produção
      ansible.builtin.shell:
        cmd: |
          source /home/ubuntu/python/virtual-env/bin/activate &&
          nohup python3 /home/ubuntu/python/manage.py runserver 0.0.0.0:8000 &
        executable: /bin/bash
  EOT
  ansible-playbook playbook.yml
  ```

</details>

  - **10.3.2** No template de instâncias, informe o caminho do script

  ```terraform
  # launch-template.tf

  user_data = filebase64("./caminho/absoluto/do/script")
  ```

## 11. Configurando o balanceador de carga (Load Balancer)

  - **11.1** Crie uma variável de zona alternativa da AWS e atribua ao Autoscaling Group

  ```terraform
  # vars.tf

  variable "<zona-c>" {
    type = string
    default = "sa-east-1c"
  }

  # auto-scaling.tf

  availability_zones = [ "${var.<zona-a>}, ${var.<zona-c>}" ]
  ```

  - **11.2** Crie um arquivo chamado `subnets.tf` duas sub-redes para cada zona da AWS

  ```terraform
  resource "aws_default_subnet" "subnet_1" {
    availability_zone = var.<zona-a>
  }

  resource "aws_default_subnet" "subnet_2" {
    availability_zone = var.<zona-c>
  }
  ```

  - **11.3** Crie uma VPC, Load Balancer, alvo e entrada do balanceador

  ```terraform
  # vpc.tf

  resource "aws_default_vpc" "<nome>" {
  }

  # load-balancer.tf
  resource "aws_lb" "<nome>" {
    internal = false
    security_groups = [ aws_security_group.<nome>.id ]
    subnets = [ aws_default_subnet.<subnet-1>.id, aws_default_subnet.<subnet-2>.id ]
  }

  resource "aws_lb_target_group" "<nome>" {
    name = "<nome>"
    port = "8000"
    protocol = "HTTP"
    vpc_id = aws_default_vpc.<nome-vpc>.id
  }

  resource "aws_lb_listener" "entrada-lb" {
    load_balancer_arn = aws_lb.load-balancer.arn
    port = "8000"
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.alvo-lb.arn
    }
  }
  ```

  - **11.3.1** Referencie o alvo do balanceador no grupo de auto escalonamento

  ```terraform
  # auto-scaling.tf
  [...]

  target_group_arns = [ aws_lb_target_group.<nome-do-alvo-lb>.arn ]
  ```
