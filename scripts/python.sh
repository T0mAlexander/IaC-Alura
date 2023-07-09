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
