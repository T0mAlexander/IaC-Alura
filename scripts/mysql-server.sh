sudo apt install mysql-server
mysql -e "create user 'devops'@'%' identified by '123';"  && \
mysql -e "create user 'devops_dev'@'%' identified by '123';"  && \
mysql -e "create database todo;" && \
mysql -e "create database todo_dev;" && \
mysql -e "create database test_todo_dev;" && \
mysql -e "grant all privileges on *.* to devops@'%' identified by '123';" && \
mysql -e "grant all privileges on *.* to devops_dev@'%' identified by '123';"