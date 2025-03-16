#!/bin/bash
# https://docs.docker.com/engine/install/rhel/#install-using-the-repository

set -e

sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker
sudo usermod -G docker $USER

echo "INFO: sudo docker run hello-world"
echo "INFO: Run the above command to test out installation, also run it without sudo"
