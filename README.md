# Ansible e Terraform + AWS

## Descrição

Branch relacionada ao curso **Infraestrutura como código: preparando máquinas na AWS com Ansible e Terraform** da Alura

## Pré-requisitos

- [**Ansible**](https://developer.hashicorp.com/vagrant/downloads) instalado na máquina com versão mínima em 2.14.x
- [**Terraform**](https://www.virtualbox.org/wiki/Downloads) instalado na máquina com versão mínima em 1.5.x
- [**Python**](https://www.virtualbox.org/wiki/Downloads) instalado na máquina com versão mínima em 3.11.x
- [**AWS CLI**](https://docs.aws.amazon.com/pt_br/cli/latest/userguide/getting-started-install.html) instalado na máquina com versão mínima em 2.11.x

## Instruções de uso

### 1. Gere uma nova chave SSH

  ```bash
  ssh-keygen -f <nome-da-chave> -t rsa
  ```

### 2. Importe a chave para a AWS

  ![Importando a chave para a AWS](https://raw.githubusercontent.com/T0mAlexander/CICD-Alura/screenshots/ansible-terraform/importando-chaves-para-aws.png)

  > **Localização:** vá até ***EC2 > Pares de chaves*** para acessar o painel de gerenciamento de chaves SSH

  * **2.1** Crie um nome para a chave e importe o arquivo `.pub` da chave

  ![Criando nome e importando chave pública](https://raw.githubusercontent.com/T0mAlexander/CICD-Alura/screenshots/ansible-terraform/criando-nome-e-importando-chave.png)

## 3. Crie a instância EC2

  ```bash
  terraform apply
  ```

  > **Lembrete:** digite `yes` para confirmação

## 4. Interagindo com a instância EC2

  * **4.1** Acesse via SSH

  ```bash
  ssh -i <chave> ubuntu@<ip-público>
  ```

  * **4.2** Crie um arquivo HTML com o comando abaixo:

  ```bash
  echo "<h1>Ola, Ansible e Terraform</h1>" > index.html
  ```

  * **4.3** Instancie um servidor para teste rápido

  ```bash
  nohup busybox httpd -f -p 8080 &
  ```

  * **4.4** Obtenha o IP público da instância e acesse o servidor

  ```bash
  terraform output
  ```

  **Lembrete:** o servidor estará acessível na porta **8080**
