#!/bin/bash
# https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
# https://mirantis.github.io/cri-dockerd/usage/install-manually/

set -e

# Add Docker's official GPG key:
sudo apt-get update
sudo apt upgrade -y
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
  conntrackd/focal apt-transport-https ca-certificates curl gpg

sudo wget -O /root/cri-dockerd.deb https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.16/cri-dockerd_0.3.16.3-0.ubuntu-$(lsb_release -cs)_amd64.deb 
sudo dpkg -i /root/cri-dockerd.deb
sudo mkdir -p /etc/cni/net.d

sudo usermod -G docker $USER

systemctl status docker docker.socket cri-docker cri-docker.socket

echo "INFO: sudo docker run hello-world"
echo "INFO: Run the above command to test out installation, also logout/in and run it without sudo"
