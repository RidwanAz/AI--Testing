```
#!/bin/bash
sudo yum install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx

cat > /tmp/block_to_inject <<EOF
# BEGIN INJECTED BLOCK
#/etc/nginx/reverse.conf
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

     server {
        listen       80;
        listen       443 http2 ssl;
        listen       [::]:443 http2 ssl;
        root          /var/www/html;
        server_name  *.onyekaonu.site;
        
        
        ssl_certificate /etc/ssl/certs/onyi.crt;
        ssl_certificate_key /etc/ssl/private/onyi.key;
        ssl_dhparam /etc/ssl/certs/dhparam.pem;

      

        location /home {
        access_log off;
        return 200;
       }
    
         
        location / {
            proxy_set_header             Host $host;
            proxy_pass                   https://internal-onyi-int-alb-1029753775.eu-west-2.elb.amazonaws.com/; 
           }
    }
}
# END INJECTED BLOCK
EOF

sudo tee -a /etc/nginx/reverse.conf < /tmp/block_to_inject > /dev/null
sudo mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf-distro
cd /etc/nginx/
sudo touch nginx.conf
sudo sed -n 'w nginx.conf' reverse.conf
sudo systemctl restart nginx
sudo rm -rf reverse.conf
```