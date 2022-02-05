#!/usr/bin/env bash

# curl -fsSL https://test.docker.com -o- | sudo sh
# curl -fsSL https://get.docker.com -o- | sudo sh

sudo apt remove -y -qq \
     docker docker-engine \
     docker.io containerd runc

sudo apt update
sudo apt install -y -qq \
     apt-transport-https \
     ca-certificates \
     curl gnupg lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg |
     sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" |
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y -qq \
     docker-ce docker-ce-cli containerd.io

sudo curl -sL "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" \
          -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl restart docker
exec "$SHELL" -l

# test
docker run --rm hello-world
