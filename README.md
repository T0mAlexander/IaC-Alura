# Terraform, Docker e AWS

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
        <img src="https://skillicons.dev/icons?i=docker" width="65px"/>
        <sub>
          <b>
            <h3>Docker</h3>
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
        <img src="https://dqw5z6tkg7aeo.cloudfront.net/icon/d43b67a293d39d11b046bd1813c804cb-4bc0ce71c93950e1ad695b25a4f1d4b5.svg" style="border-radius: 15px" width="65px"/>
        <sub>
          <b>
            <h3>Beanstalk</h3>
          </b>
        </sub>
      </td>
      <td align="center">
        <img src="https://dqw5z6tkg7aeo.cloudfront.net/icon/de7db04805a33606a40b897578543648-c0174badf433f1e0148e43426ae8e43a.svg" style="border-radius: 15px" width="65px"/>
        <sub>
          <b>
            <h3>ECR</h3>
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
    </tr>
  </table>

  <table>
  
  * ### Linguagens e tecnologias
    <tr>
      <td align="center">
        <img src="https://skillicons.dev/icons?i=py" width="65px"/>
        <sub>
          <b>
            <h3>Python</h3>
          </b>
        </sub>
      </td>
      <td align="center">
        <img src="https://skillicons.dev/icons?i=django" width="65px"/>
        <sub>
          <b>
            <h3>Django</h3>
          </b>
        </sub>
      </td>
    </tr>
  </table>
</div>

## ⚙️ Funcionalidades do projeto

- Criação de máquinas virtuais através da *Elastic Cloud Computing* (EC2) para execução de contêineres do Docker
- Configuração de repositório de imagens Docker com *Elastic Container Registry* (ECR)
- Preparação de infraestrutura elástica
- Automação de execução do container com a aplicação web na máquina virtual
- Deploy da aplicação web em versão de produção através do serviço *Elastic Beanstalk*

## ✔️ Práticas e técnicas

- Armazenamento do estado da infraestrutura no Bucket S3 da AWS
- Aplicação web compilada como imagem Docker
- Definição de políticas de uso e cargos (*roles*) com IAM Policy
- Separação de ambientes de desenvolvimento e produção
- Publicação da imagem Docker da aplicação para o ECR
