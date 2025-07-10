#! /usr/bin/bash

set -e

sudo apt update -y
sudo apt install nginx curl git -y

sudo systemctl start nginx
sudo systemctl enable nginx

git clone https://github.com/daniah2/simple-3-tiers-app.git

cd simple-3-tiers-app/frontend/

sed -i "s/BACKEND_DNS/${BACKEND_LB_DNS}/g" ./nginx.conf
sed -i "s/BACKEND_PORT/${BACKEND_LB_PORT}/g" ./nginx.conf

cp ./index.html /usr/share/nginx/html/
cp ./style.css  /usr/share/nginx/html/
cp ./script.js  /usr/share/nginx/html/
cp nginx.conf /etc/nginx/nginx.conf

sudo systemctl restart nginx