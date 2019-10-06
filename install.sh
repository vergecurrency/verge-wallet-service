#!/bin/bash
# This file installs all the needed software on the production environment.

dpkg -s docker &> /dev/null
if [ $? -ne 0 ]
  then
    echo "Docker missing, lets install docker now..."
    # Install docker
    sudo apt install docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
  else
    echo "Docker already installed"
fi

dpkg -s docker-compose &> /dev/null
if [ $? -ne 0 ]
  then
    echo "Docker-compose missing, lets install docker-compose now..."
    # Install docker-compose
    curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` > ~/docker-compose
    chmod +x ~/docker-compose
    sudo mv ~/docker-compose /usr/local/bin/docker-compose
  else
    echo "Docker-compose already installed"
fi

dpkg -s certbot &> /dev/null
if [ $? -ne 0 ]
  then
    echo "Certbot missing, lets install certbot now..."
    # Install certbot
    sudo apt-get update
    sudo apt-get install software-properties-common
    sudo add-apt-repository universe
    sudo add-apt-repository ppa:certbot/certbot
    sudo apt-get update
    sudo apt-get install certbot
  else
    echo "Certbot already installed"
fi

echo "VWS dependency installation complete."
