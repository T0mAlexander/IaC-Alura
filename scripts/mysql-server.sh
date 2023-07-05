sudo apt install mysql-server -y
sudo mysql -e "CREATE USER 'devops'@'%' IDENTIFIED BY 'devops';" && \
sudo mysql -e "CREATE USER 'devops_dev'@'%' IDENTIFIED BY 'devops';" && \
sudo mysql -e "CREATE DATABASE todo;" && \
sudo mysql -e "CREATE DATABASE todo_dev;" && \
sudo mysql -e "CREATE DATABASE test_todo_dev;" && \
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* to devops@'%';" && \
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* to devops_dev@'%';" && \
sudo mysql -e "FLUSH PRIVILEGES;"
sudo service mysql restart