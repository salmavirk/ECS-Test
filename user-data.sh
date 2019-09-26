#!/bin/bash

sudo apt upgrade -y
sudo apt install -y nginx
curl https://pastebin.com/raw/UPuZCtsx | sudo tee /var/www/html/index.html
sudo snap refresh
sudo systemctl restart nginx
sudo apt install ec2-instance-connect
