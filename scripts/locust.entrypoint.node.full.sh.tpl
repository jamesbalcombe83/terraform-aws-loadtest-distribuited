#!/bin/bash

sudo yum update -y
sudo yum install -y pcre2-devel.x86_64 python gcc python3-devel tzdata curl unzip bash htop

# LOCUST
export LOCUST_VERSION="2.29.0"
sudo pip3 install locust==$LOCUST_VERSION
sudo pip3 uninstall urllib3
sudo pip3 install urllib3==1.26.6
sudo pip3 install locust_plugins

export PRIVATE_IP=$(hostname -I | awk '{print $1}')
echo "PRIVATE_IP=$PRIVATE_IP" >> /etc/environment

source ~/.bashrc

mkdir -p ~/.ssh
echo 'Host *' > ~/.ssh/config
echo 'StrictHostKeyChecking no' >> ~/.ssh/config

touch /tmp/finished-setup
