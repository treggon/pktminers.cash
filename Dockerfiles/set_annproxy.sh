!#/bin/bash

echo "server {
    listen 80;
    listen [::]:80;
    server_name $1.pktminers.cash;
    location / {
        proxy_pass http://localhost:8201/;
        }
}
" > /etc/nginx/sites-available/reverse-proxy.conf
