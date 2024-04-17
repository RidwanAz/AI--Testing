#!/bin/bash
sudo yum -y update
mkdir /var/www/
sudo mount -t efs -o tls,accesspoint=fsap-05b61191ccbfdd688 fs-087a7a53914813839:/ /var/www/
sudo yum install wget httpd php php-mysqlnd php-fpm php-json git net-tools -y
sudo dnf install mariadb105 -y
sudo systemctl enable httpd
sudo systemctl start httpd

# Download and copy wordpress to var/www/html
cd /var/www/html
sudo wget http://wordpress.org/latest.tar.gz
sudo tar -xzvf latest.tar.gz
sudo cp -R wordpress/* /var/www/html/
sudo rm -rf latest.tar.gz
sudo rm -rf wordpress
sudo chmod -R 755 wp-content
sudo chown -R apache:apache wp-content
sudo systemctl restart httpd
sudo cp wp-config-sample.php wp-config.php

# edit the wp-config.php with the database credentials
sudo sed -i "s/localhost/onyi-db.ch6ugi4uigv5.eu-west-2.rds.amazonaws.com/g" wp-config.php 
sudo sed -i "s/username_here/onyi_admin/g" wp-config.php 
sudo sed -i "s/password_here/admin12345/g" wp-config.php 
sudo sed -i "s/database_name_here/wordpressdb/g" wp-config.php 
sudo chcon -t httpd_sys_rw_content_t /var/www/html/ -R
sudo systemctl restart httpd
