# Terraform, Docker e ECS

Cursos da Alura relacionados a esta ramificação

**I.** Infraestrutura como código: Docker e Elastic Beanstalk na AWS

## 🔧 Ferramentas

<div>
  <table>

  * ### Infraestrutura e nuvem
    <tr>
      <td align="center">
        <img src="https://res.cloudinary.com/tommello/image/upload/v1687709304/Github/Profile%20Markdown/iconizer-terraform-original_vl0ivu.svg" width="65px"/>
        <sub>
          <b>
            <h3>Terraform</h3>
          </b>
        </sub>
      </td>
      <td align="center">
        <img src="https://dqw5z6tkg7aeo.cloudfront.net/icon/2eb2930111864beeb409e946751215b1-3ecb316865dc77cffc9cd77eed455da2.svg" style="border-radius: 15px" width="65px"/>
        <sub>
          <b>
            <h3>ECS</h3>
          </b>
        </sub>
      </td>
      <td align="center">
        <img src="https://dqw5z6tkg7aeo.cloudfront.net/icon/c0828e0381730befd1f7a025057c74fb-43acc0496e64afba82dbc9ab774dc622.svg" style="border-radius: 15px" width="65px"/>
        <sub>
          <b>
            <h3>S3 Bucket</h3>
          </b>
        </sub>
      </td>
      <td align="center">
        <img src="https://dqw5z6tkg7aeo.cloudfront.net/icon/74f8d03e857091589308684a506ba915-4d9c246d4283a8c3150cf0aa442dec10.svg" style="border-radius: 15px" width="65px"/>
        <sub>
          <b>
            <h3>VPC</h3>
          </b>
        </sub>
      </td>
    </tr>
    <tr>
      <td align="center">
        <img src="https://dqw5z6tkg7aeo.cloudfront.net/icon/de7db04805a33606a40b897578543648-c0174badf433f1e0148e43426ae8e43a.svg" style="border-radius: 15px" width="65px"/>
        <sub>
          <b>
            <h3>ECR</h3>
          </b>
        </sub>
      </td>
      <td align="center">
        <img src="https://dqw5z6tkg7aeo.cloudfront.net/icon/d88319dfa5d204f019b4284149886c59-7d586ea82f792b61a8c87de60565133d.svg" style="border-radius: 15px" width="65px"/>
        <sub>
          <b>
            <h3>EC2</h3>
          </b>
        </sub>
      </td>
      <td align="center">
        <img src="https://dqw5z6tkg7aeo.cloudfront.net/icon/8f57ebd825a828e205b2dde223ba17e4-6af63a22dc297f8041286760ee8cd2c9.svg" style="border-radius: 15px" width="65px"/>
        <sub>
          <b>
            <h3>CloudWatch</h3>
          </b>
        </sub>
      </td>
      <td align="center">
        <img src="https://d2q66yyjeovezo.cloudfront.net/icon/0ebc580ae6450fce8762fad1bff32e7b-0841c1f0e7c5788b88d07a7dbcaceb6e.svg" style="border-radius: 15px" width="65px"/>
        <sub>
          <b>
            <h3>IAM</h3>
          </b>
        </sub>
      </td>
    </tr>
  </table>
</div>

## ⚙️ Funcionalidades do projeto

- Configuração inicial de um repositório de imagens de container com *Elastic Container Registry* (ECR)
- Isolamento de rede com o *Virtual Private Cloud* (VPC)
- Atribuição de cargos, recursos e políticas com IAM Policy
- Criação de balanceador de carga e encaminhamento da porta da aplicação
- Criação de cluster do *Elastic Container Service* (ECS) gerenciado pelo Fargate

## ✔️ Práticas e técnicas

- Armazenamento do estado da infraestrutura no Bucket S3 da AWS
- Aplicação web compilada como imagem Docker
- Separação de ambientes de desenvolvimento e produção
- Publicação da imagem Docker da aplicação para o ECR
- Agrupamento do cluster ECS com tarefas
- Definição de recursos computacionais (processamento e memória) sob demanda para hospedagem da aplicação
