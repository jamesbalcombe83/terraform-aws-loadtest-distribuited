#!/bin/bash

sudo dnf update -y
sudo dnf install -y --allowerasing pcre2-devel.x86_64 python gcc python3.11-devel tzdata unzip bash htop python3.11-pip
sudo dnf remove -y python3-requests

sudo pip3 install requests

# LOCUST
export LOCUST_VERSION="2.29.0"
sudo pip3 install locust==$LOCUST_VERSION --log pip_install.log

export PRIVATE_IP=$(hostname -I | awk '{print $1}')
echo "PRIVATE_IP=$PRIVATE_IP" >> /etc/environment

source ~/.bashrc

mkdir -p ~/.ssh
echo 'Host *' > ~/.ssh/config
echo 'StrictHostKeyChecking no' >> ~/.ssh/config

sudo pip3 install "urllib3<2.0"
sudo pip3 install locust_plugins

sudo iptables -A INPUT -i eth0 -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -i eth0 -p tcp --dport 8080 -j ACCEPT
sudo iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080

touch /tmp/finished-setup
