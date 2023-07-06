#!/bin/sh

### TODO - Configs do Jenkins ###
#todo - Iniciar um job acoplado ao repositório do Github via HTTPS na branch "jenkins-docker"
#todo - Ativar o Poll SCM inserindo o "* * * * *"
#todo - Instalar plugins do Docker e Config File Provider
#todo - Ativar o cloud do Docker
#todo - Criar .env-dev e .env-prod
#todo - Inserir variavel .env-dev no Build Environment do Job com target "./app/.env"
#todo - Deletar workspace antes de executar a build

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
-v /var/lib/jenkins/workspace/lista-de-tarefas/app/:/usr/src/app/ --name=lista-tarefas-teste django_todolist_image_build

echo "-------- Localizando .env no container --------"
docker exec -i lista-tarefas-teste la to_do/ | grep .env

echo "-------- Testando .env --------"
docker exec -i lista-tarefas-teste cat to_do/ .env

echo "-------- Testando a imagem --------"
docker exec -i lista-tarefas-teste python manage.py test --keep
exit_code=$?

echo "-------- Encerrando o container antigo --------"
docker rm -f lista-tarefas-teste

if [ $exit_code -ne 0 ]; then
  exit 1
fi