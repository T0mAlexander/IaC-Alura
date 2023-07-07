sudo apt-get update -y
sudo apt-get install swapspace python3 python3-pip \
  python3-dev libmysqlclient-dev python3-venv build-essential \
  libssl-dev libffi-dev unzip -y
cd app
pip3 install virtualenv nose coverage nosexcover pylint django
virtualenv --always-copy django-app
source venv-django-app/bin/activate
pip3 install -r requirements.txt

cat << EOF > .env
[config]
# Secret configuration
SECRET_KEY=r*5ltfzw-61ksdm41fuul8+hxs$86yo9%k1%k=(!@=-wv4qtyv

# Configs
DEBUG=True

# Database
DB_NAME=todo_dev
DB_USER=devops_dev
DB_PASSWORD=devops
DB_HOST=localhost
DB_PORT=3306
EOF

cat << EOF > to_do/.env
[config]
# Secret configuration
SECRET_KEY=r*5ltfzw-61ksdm41fuul8+hxs$86yo9%k1%k=(!@=-wv4qtyv

# Configs
DEBUG=True

# Database
DB_NAME=todo
DB_USER=devops
DB_PASSWORD=devops
DB_HOST=localhost
DB_PORT=3306
EOF

python3 manage.py makemigrations
python3 manage.py migrate

cd to_do/

python3 ../manage.py makemigrations
python3 ../manage.py migrate

cd ..

#todo - python3 manage.py createsuperuser

### TODO Configurações do app ###

#TODO Criando e ativando o Venv

#todo - sudo apt-get update && sudo apt-get install swapspace python3 python3-pip \
#todo     python3-dev libmysqlclient-dev python3-venv build-essential libssl-dev libffi-dev unzip -y

#todo - sudo pip3 install virtualenv nose coverage nosexcover pylint

#todo - virtualenv --always-copy venv-django-todolist
#todo - source venv-django-todolist/bin/activate
#todo - pip install -r requirements.txt

# ----------------------------

#todo - criando o arquivo .env pro ambiente de desenvolvimento

#todo vi .env

#todo [config]
#* Secret configuration
#todo SECRET_KEY=r*5ltfzw-61ksdm41fuul8+hxs$86yo9%k1%k=(!@=-wv4qtyv

#* Configs
#todo DEBUG=True

#* Database
#todo DB_NAME=todo_dev
#todo DB_USER=devops_dev
#todo DB_PASSWORD=devops
#todo DB_HOST=localhost
#todo DB_PORT=3306

#TODO Fazendo migrações pro ambiente de desenvolvimento
#todo - python manage.py makemigrations
#todo - python manage.py migrate

#TODO Criando o superuser para acessar a app em desenvolvimento
#todo - python manage.py createsuperuser

#--------------------------

#TODO - Repetir o processo de migração para o ambiente de produção

#todo vi to_do/.env

#todo [config]
#* Secret configuration
#todo SECRET_KEY = 'r*5ltfzw-61ksdm41fuul8+hxs$86yo9%k1%k=(!@=-wv4qtyv'

#* Configs
#todo DEBUG=True

#* Database
#todo DB_NAME=todo
#todo DB_USER=devops
#todo DB_PASSWORD=devops
#todo DB_HOST=localhost
#todo DB_PORT=3306

#---------------------------

#TODO Fazendo migrações pro ambiente de produção
#todo - python manage.py makemigrations
#todo - python manage.py migrate

#TODO Criando o superuser para acessar a app em produção
#todo - python manage.py createsuperuser

#TODO Verificando e executando servidor

#todo python3 manage.py runserver 0:8000
#todo - URL do server: http://192.168.56.10:8000