# Bastion ami installation
```
sudo yum install -y telnet htop git net-tools chrony zip unzip
sudo dnf install mariadb105 -y
sudo systemctl start chronyd
sudo systemctl enable chronyd
```
################################################################################

# Nginx ami installation 
-----------------------------------------
```
sudo yum install telnet htop git net-tools chrony -y
sudo dnf install mariadb105 -y
sudo systemctl start chronyd
sudo systemctl enable chronyd
```

## configure selinux policies for the nginx servers
```
sudo setsebool -P httpd_can_network_connect=1
sudo setsebool -P httpd_can_network_connect_db=1
sudo setsebool -P httpd_execmem=1
sudo setsebool -P httpd_use_nfs 1
```

## seting up self-signed certificate for the nginx instance
```
sudo mkdir /etc/ssl/private
sudo chmod 700 /etc/ssl/private
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/onyi.key -out /etc/ssl/certs/onyi.crt
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
```
######################################################################################

# webserver ami installation 
```
sudo yum install telnet htop git net-tools chrony -y
sudo dnf install mariadb105 -y
sudo yum install amazon-efs-utils -y
sudo systemctl start chronyd
sudo systemctl enable chronyd
```
## configure selinux policies for the webservers servers
```
sudo setsebool -P httpd_can_network_connect=1
sudo setsebool -P httpd_can_network_connect_db=1
sudo setsebool -P httpd_execmem=1
sudo setsebool -P httpd_use_nfs 1
```

## seting up self-signed certificate for the apache  webserver instance
```
sudo yum install -y mod_ssl

sudo openssl req -newkey rsa:2048 -nodes -keyout /etc/pki/tls/private/onyi.key -x509 -days 365 -out /etc/pki/tls/certs/onyi.crt

Edit the path for ssl certificate in this file. Change the localhost.crt to onyi.crt and localhost.key to onyi.key
sudo vi /etc/httpd/conf.d/ssl.conf
```
#####################################################################

Go to the console, from each instance create an ami : action - image and templates - create image


# References
[IP ranges](https://ipinfo.io/ips)

[ssh-gent forwarding on mobaxterm](http://docs.gcc.rug.nl/hyperchicken/ssh-agent-forwarding-mobaxterm/)

[Nginx reverse proxy server](https://www.nginx.com/resources/glossary/reverse-proxy-server/)

[Underdstanding ec2 user data](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html)

[Manually installing the Amazon EFS client](https://docs.aws.amazon.com/efs/latest/ug/installing-amazon-efs-utils.html#installing-other-distro)

[creating target groups for AWS Loadbalancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-target-groups.html)

[Self-Signed SSL Certificate for Apache](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-apache-on-centos-8)

[Create a Self-Signed SSL Certificate for Nginx](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-on-centos-7)